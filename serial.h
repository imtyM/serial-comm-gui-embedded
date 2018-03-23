#ifndef SERIAL_H
#define SERIAL_H

#include <QMainWindow>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QObject>
#include <QTimer>
#include <QtWidgets>
#include <QQmlProperty>

class Serial: public  QObject
{
    Q_OBJECT
public:
    Serial(QObject *root = 0);
    ~Serial();
    Q_INVOKABLE bool configureSerial();
    Q_INVOKABLE bool serialWrite(QString data);
    Q_INVOKABLE void sendRequests();

    Q_INVOKABLE void controlFanSpeed(int fanSpeed);
    Q_INVOKABLE void controlFanMode(QString FanMode);
    Q_INVOKABLE void controlFanPosition(int fanPosition);
    Q_INVOKABLE void controlLightIntensity(int lightIntensity);

    Q_INVOKABLE bool busyRequesting = false;
    Q_INVOKABLE bool connected = false;

    Q_INVOKABLE void analyseData(QString buffer);

private:
    QObject *root;
    void createQmlObjects();
    void findPort();
    void openPort();
    void createServer();
    void showDebugOutput(QString buffer);
    QSerialPort *serial;
    QString portName;
    QByteArray serialData;
    QString buffer;
    QString debugOutputText;
    const int VENDOR_ID = 1240;
    const int PRODUCT_ID = 223;
    QString serialBuffer = "";
    bool isPortAvailable = false;
    bool isAuto = false;
    bool waitingForReply = false;

    int tempList[4] = {0,0,0,0};
    int highestTemp = 0;

    int currentLightLevel = 0;

    QObject *debugOutput;
    QObject *modeSwitch;

    QObject *controlLightSlider;
    QObject *controlFanSpeedSlider;
    QObject *controlFanPositionSpin;
    QObject *controlFanSpeedText;

    QObject *infoModeOutput;
    QObject *infoLightIntensity;
    QObject *infoFanSpeed;
    QObject *infoFanDirection;
    QObject *infoFanPositionGauge;
    QObject *infoFanPositionText;
    QObject *infoLightLevel;
    QObject *wifiStatusText;
    QObject* wifiStatusIndicator;

    QObject* lightControlFrame;
    QObject* fanControlFrame;

    QObject *infoTemp1;
    QObject *infoTemp2;
    QObject *infoTemp3;
    QObject *infoTemp4;

    QList<QString> commandBackLog;

    void changeMode(QString buffer);
    void changeFanSpeed(QString buffer);
    void changeFanPosition(QString buffer);
    void changeTemp(QString buffer);
    void changeLightLevel(QString buffer);
    void changeLightSensorIntensity(QString buffer);

    int getLightLevel(int lux);
    void setLightLevel(int lightLevel);

    void setTemperaturePosition();
    void setTemperatureSpeed();

    void serialSend(QString data);

    int busyCounter;
    int waitCounter = 0;
    bool prompt;

    QString getValueFromString(QString buffer, QString indexString, int indexLength = 2);

    void delay(int milSec);
    void commitRequests();

    void setConnected();
    void setDisconnected();
    void errorRestart();

    void request(QString request);

    void commitAutoMethods();

private slots:
    void readSerial();
};

#endif // SERIAL_H
