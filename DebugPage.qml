import QtQuick 2.4

DebugPageForm {


    debugSendButton.onClicked: {
        console.log("debug send used.. ");
        Serial.serialWrite(debugInput.text);
        debugInput.text = "";
        debugInput.forceActiveFocus();
    }
}
