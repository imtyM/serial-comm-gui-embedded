#include "serial.h"

Serial::Serial(QObject *root)
{
    this->root = root;
    createQmlObjects();
    this->connected = false;
    this->busyRequesting = false;
    this->waitingForReply = false;
    this->waitCounter = 0;


}

Serial::~Serial(){
    if(serial->isOpen()){
        serial->close();
        qDebug() << "port closed." << endl;
    }
}

bool Serial::configureSerial(){
        qDebug() << "Trying to configure serial..";

        this->serial = new QSerialPort;
        findPort();
        openPort();
        createServer();
        return isPortAvailable;
}

bool Serial::serialWrite(QString data)
{
    qDebug() << "serialWrite accessed with " << data;
    data.append("\r\n");
    serial->write(data.toStdString().c_str());
    return true;
}

void Serial::createQmlObjects()
{
    debugOutput = root->findChild<QObject*>("debugOutput");
    modeSwitch = root->findChild<QObject*>("modeSwitch");

    controlLightSlider = root->findChild<QObject*>("controlLightSlider");
    controlFanSpeedSlider = root->findChild<QObject*>("controlFanSpeedSlider");
    controlFanPositionSpin = root->findChild<QObject*>("controlFanPositionSpin");
    controlFanSpeedText = root->findChild<QObject*>("controlFanSpeedText");

    infoModeOutput = root->findChild<QObject*>("infoModeOutput");
    infoLightIntensity = root->findChild<QObject*>("infoLightIntensity");
    infoFanSpeed = root->findChild<QObject*>("infoFanSpeed");
    infoFanDirection = root->findChild<QObject*>("infoFanDirection");
    infoFanPositionGauge = root->findChild<QObject*>("infoFanPositionGauge");
    infoFanPositionText = root->findChild<QObject*>("infoFanPositionText");
    infoLightLevel = root->findChild<QObject*>("infoLightLevel");
    wifiStatusIndicator = root->findChild<QObject*>("wifiStatusIndicator");
    wifiStatusText = root->findChild<QObject*>("wifiStatusText");

    lightControlFrame = root->findChild<QObject*>("lightControlFrame");
    fanControlFrame = root->findChild<QObject*>("fanControlFrame");

    infoTemp1 = root->findChild<QObject*>("infoTemp1");
    infoTemp2 = root->findChild<QObject*>("infoTemp2");
    infoTemp3 = root->findChild<QObject*>("infoTemp3");
    infoTemp4 = root->findChild<QObject*>("infoTemp4");
}

void Serial::findPort(){
    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts()){
            if(serialPortInfo.hasVendorIdentifier() && serialPortInfo.hasProductIdentifier()){
                if(serialPortInfo.vendorIdentifier() == VENDOR_ID){
                    if(serialPortInfo.productIdentifier() == PRODUCT_ID){
                        portName = serialPortInfo.portName();
                        isPortAvailable = true;
                    }
                }
            }
        }
}

void Serial::openPort(){
    if(isPortAvailable){
            // open and configure the serialport
            QObject::connect(serial,SIGNAL(readyRead()),
                    this,SLOT(readSerial()));
            serial->setPortName(portName);
            serial->open(QSerialPort::ReadWrite);
            serial->setBaudRate(QSerialPort::Baud19200);
            serial->setDataBits(QSerialPort::Data8);
            serial->setParity(QSerialPort::NoParity);
            serial->setStopBits(QSerialPort::OneStop);
            serial->setFlowControl(QSerialPort::NoFlowControl);

            qDebug() << "port open." << endl;
    }
}

void Serial::createServer()
{
    if(isPortAvailable){
        serialWrite("AT+RST");
        delay(3000);
        serialWrite("AT+CIPMUX=1");
        delay(100);
        serialWrite("AT+CIPSERVER=1");
        delay(100);
        serialWrite("ATE0");
    }
}

void Serial::setConnected()
{
    connected = true;
    showDebugOutput("Connected to Client (linked).");
    wifiStatusIndicator->setProperty("active", "true");
    wifiStatusText->setProperty("text", "Connected");
}

void Serial::setDisconnected()
{
    connected = false;
    showDebugOutput("Disconnected from Client (Unlinked).");
    wifiStatusIndicator->setProperty("active", "false");
    wifiStatusText->setProperty("text", "Disconnected");
}

void Serial::errorRestart()
{
//      delay(1000);
//      busyCounter++;
//      if(busyCounter == 10){

//        showDebugOutput("Error in communication..");
//        connected = false;
//        wifiStatusIndicator->setProperty("active", "false");
//        wifiStatusText->setProperty("text", "Error: Please replug\n    server module.");
//      }

}

void Serial::analyseData(QString buffer)
{

    if(buffer.contains(">", Qt::CaseInsensitive)){
        waitingForReply = false;
        busyCounter = 0;
        waitCounter = 0;
        prompt = true;
    }


    if(buffer.contains("busy s...",Qt::CaseInsensitive))
        errorRestart();
    if(buffer.contains("link is not", Qt::CaseInsensitive))
        setDisconnected();
    else if(buffer.contains("Unlink",Qt::CaseInsensitive))
        setDisconnected();
    else if(buffer.contains("Connected", Qt::CaseInsensitive))
        setConnected();
    else if(buffer.contains("RM"))
        changeMode(buffer);
    else if(buffer.contains("RL"))
        changeLightSensorIntensity(buffer);
    else if(buffer.contains("RS"))
        changeFanSpeed(buffer);
    else if(buffer.contains("RP"))
        changeFanPosition(buffer);
    else if(buffer.contains("RT"))
        changeTemp(buffer);
    else if(buffer.contains("RI"))
        changeLightLevel(buffer);
    this->buffer.clear();


}


void Serial::showDebugOutput(QString debugOut)
{
    debugOutput->setProperty("text", debugOut);
}

void Serial::changeMode(QString buffer)
{
    if (buffer.contains("RMm")){
        isAuto = false;
        infoModeOutput->setProperty("text", "Manual");
        modeSwitch->setProperty("checked", "true");
    }
    else if (buffer.contains("RMa")){
        isAuto = true;
        infoModeOutput->setProperty("text", "Auto");
        modeSwitch->setProperty("checked", "false");
    }
}

void Serial::changeFanSpeed(QString buffer)
{


    if(buffer.contains("RST"))
    {
        return;
    }

    QString fanSpeed = getValueFromString(buffer, "RS");
    int fanSpeedValue = fanSpeed.toInt();
    infoFanSpeed->setProperty("text", fanSpeed);

    controlFanSpeedSlider->setProperty("value", fanSpeedValue);
    controlFanSpeedText->setProperty("text", QString::number(fanSpeedValue));

    if(fanSpeedValue > 0)
        infoFanDirection->setProperty("text", "Clockwise");
    else if(fanSpeedValue < 0)
        infoFanDirection->setProperty("text", "Anti-Clockwise");
    else if(fanSpeedValue ==0)
        infoFanDirection->setProperty("text", "OFF");


}

void Serial::changeFanPosition(QString buffer)
{
    QString fanPosition = getValueFromString(buffer, "RP");
    int fanPositionValue = fanPosition.toInt();


    infoFanPositionText->setProperty("text", fanPosition);

    if(fanPositionValue != controlFanPositionSpin->property("value"))
      controlFanPositionSpin->setProperty("value", fanPositionValue);

    if(fanPositionValue == 1)
        infoFanPositionGauge->setProperty("value", 19);
    else if(fanPositionValue == 2)
        infoFanPositionGauge->setProperty("value", 0);
    else if(fanPositionValue == 3)
        infoFanPositionGauge->setProperty("value", 100);
    else if(fanPositionValue)
        infoFanPositionGauge->setProperty("value", 81);

}

void Serial::changeTemp(QString buffer)
{
    QString temperature = getValueFromString(buffer, "RT");
    int tempNumber = temperature.at(0).digitValue();
    temperature.remove(0,1);

    tempList[tempNumber-1] = temperature.toInt();

    if(tempNumber == 1)
        infoTemp1->setProperty("text", temperature);
    else if(tempNumber == 2)
        infoTemp2->setProperty("text", temperature);
    else if(tempNumber == 3)
        infoTemp3->setProperty("text", temperature);
    else if(tempNumber == 4)
        infoTemp4->setProperty("text", temperature);

}

void Serial::changeLightLevel(QString buffer)
{
    QString lightLevel = getValueFromString(buffer, "RI");
    int lightLevelValue = lightLevel.toInt();

    infoLightLevel->setProperty("text", lightLevel);
    controlLightSlider->setProperty("value", lightLevelValue);

}

int Serial::getLightLevel(int lux)
{
    if(lux <= 50)
        return 1;
    else if(lux <= 1000)
        return 2;
    else
        return 3;
}

void Serial::setLightLevel(int lightLevel)
{

    if(lightLevel == 1)
        serialSend("CI3");
    else if(lightLevel == 3)
        serialSend("CI1");
    else
        serialSend("CI2");
    delay(100);
}

void Serial::setTemperaturePosition()
{
    highestTemp = 0;
    int at = 0;

    for (int i = 0; i<4 ;i++ ){
        if(tempList[i] > highestTemp ){
            highestTemp = tempList[i];
            at = i;
        }
    }

    controlFanPosition(at+1);

}

void Serial::setTemperatureSpeed()
{
    if (highestTemp > 35)
        serialSend("CS4");
    else if (highestTemp > 30)
        serialSend("CS3");
    else if (highestTemp > 25)
        serialSend("CS2");
    else
        serialSend("CS1");
}

void Serial::serialSend(QString data)
{
    int sendCount = 0;
    while (sendCount != 2){

        if(data.length() == 2)
            serialWrite("AT+CIPSEND=0,4");
        else
            serialWrite("AT+CIPSEND=0,5");
        delay(1000);
        serialWrite(data.toStdString().c_str());
        delay(100);
        sendCount++;
    }
//    else{
//        qDebug() << "was waiting for the " << waitCounter << "reply";
//        if (waitCounter == 5){
//            waitingForReply = false;
//            waitCounter = 0;
//            return;
//        }
//        waitCounter++;

//    }
}

QString Serial::getValueFromString(QString buffer, QString indexString, int indexLength)
{
    QString tempString = buffer;
    int indexOfValue = tempString.indexOf(indexString)+indexLength;
    tempString = tempString.remove(0, indexOfValue);
    tempString.remove("\r\n");
    tempString.remove("OK");
    tempString.remove("O");
    tempString.remove("K");

    return tempString;
}

void Serial::delay(int milSec)
{
    QTime dieTime= QTime::currentTime().addMSecs(milSec);
        while (QTime::currentTime() < dieTime)
            QCoreApplication::processEvents(QEventLoop::AllEvents, 100);
}

void Serial::request(QString request)
{
    serialSend(request);
    waitingForReply = true;
    delay(100);
}

void Serial::commitAutoMethods()
{
    setLightLevel(currentLightLevel);
    delay(100);
    setTemperaturePosition();
    delay(150);
    setTemperatureSpeed();
    delay(100);
    setTemperaturePosition();
}

void Serial::commitRequests()
{
    busyRequesting = true;

    qDebug() << "Requesting.." ;

    request("RM");
    request("RL");
    request("RS");
    request("RP");
    request("RI");

    request("RT1");
    request("RT2");
    request("RT3");
    request("RT4");



    busyRequesting = false;

    if (isAuto)
        commitAutoMethods();

    foreach (QString command, commandBackLog) {
        serialSend(command);

    }
    commandBackLog.clear();

    serialSend("AT");

}

void Serial::sendRequests()
{
    if(connected && !(busyRequesting))
        commitRequests();
   else
     qDebug() << "Not connected to client or busy requesting.. ";
}

void Serial::controlFanMode(QString FanMode)
{
    if(connected && !busyRequesting)
        serialSend(FanMode);
    //delay(200);
}

void Serial::controlFanPosition(int fanPosition)
{
    controlFanPositionSpin->blockSignals(true);
    //no signal block here..
    QString fanPositionChar = QString::number(fanPosition);
    QString positionControl = "CP";
    positionControl.append(fanPositionChar);

    if (connected && !busyRequesting)
        serialSend(positionControl);
    else{
        commandBackLog.append(positionControl);
    }
    //delay(200);

    controlFanPositionSpin->blockSignals(false);

}

void Serial::controlLightIntensity(int lightIntensity)
{
    controlLightSlider->blockSignals(true);

    QString lightIntensityChar = QString::number(lightIntensity);
    QString lightIntensityControl = "CI";
    lightIntensityControl.append(lightIntensityChar);

    if (connected && !busyRequesting)
        serialSend(lightIntensityControl);
    else
        commandBackLog.append(lightIntensityControl);
    //delay(200);

    controlLightSlider->blockSignals(false);
}

void Serial::controlFanSpeed(int fanSpeed){
    controlFanSpeedSlider->blockSignals(true);
    controlFanSpeedSlider->setProperty("enabled", "false");

    QString fanSpeedChar = QString::number(fanSpeed);
    QString speedControl = "CS";
    speedControl.append(fanSpeedChar);

    if(connected && !busyRequesting)
        serialSend(speedControl);
    else
        commandBackLog.append(speedControl);
    //delay(200);

    controlFanSpeedSlider->setProperty("enabled", "true");
    controlFanSpeedSlider->blockSignals(false);
}

void Serial::changeLightSensorIntensity(QString buffer)
{
    QString luxValue = getValueFromString(buffer, "RL");
    int lightLevel = getLightLevel(luxValue.toInt());
    currentLightLevel = lightLevel;

    infoLightIntensity->setProperty("text", luxValue + " Lux");

}

void Serial::readSerial(){

    serialData = serial->readAll();
    buffer += serialData.toStdString().c_str();
    QString residue;
    if(buffer.contains("\r\n")){

        QString tempString = buffer;
        int indexOfValue = tempString.indexOf("\r\n")+2;
        tempString = tempString.remove(0, indexOfValue);
        residue = tempString;

        qDebug() << buffer;
        if(debugOutputText.length() < 70){
            debugOutputText.append(buffer);
            showDebugOutput(debugOutputText);
        }
        else{
            debugOutputText.clear();
            debugOutputText.append(buffer);
            showDebugOutput(debugOutputText);
        }
        analyseData(buffer);

        buffer.clear();
        buffer = residue;
    }
}
