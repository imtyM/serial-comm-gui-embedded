import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3

Item {
    id: item1
    width: 400
    height: 400
    property alias debugInput: debugInput
    property alias debugOutput: debugOutput
    property alias debugSendButton: debugSendButton

    ColumnLayout {
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.fill: parent

        Text {
            id: text3
            color: "#dcd5d5"
            text: qsTr("Debugging input")
            font.pixelSize: 12
        }

        TextField {
            id: debugInput
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredHeight: 40
            Layout.preferredWidth: 313
            Keys.enabled: true
            Keys.onReturnPressed: {
                console.log("debug send used.. ");
                Serial.serialWrite(debugInput.text);
                debugInput.text = "";
                debugInput.forceActiveFocus();
            }
        }

        Button {
            id: debugSendButton
            text: qsTr("Send")
            Layout.preferredHeight: -1
            scale: 1
            Layout.fillWidth: false
            Layout.preferredWidth: 73
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Text {
            id: text2
            color: "#dcd5d5"
            text: qsTr("Debugging output")
            font.pixelSize: 12
        }

        Frame {
            id: frame1
            width: 200
            height: 200
            bottomPadding: 20
            rightPadding: 20
            leftPadding: 20
            topPadding: 20
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Flickable{
                id: flickable
                anchors.fill: parent


                    TextArea.flickable: TextArea {
                        id: debugOutput
                        objectName: "debugOutput"
                        color: "#dcd5d5"
                        text: qsTr("")
                        font.pixelSize: 12
                        wrapMode: TextArea.Wrap
                        readOnly: true
                    }
            }
        }


    }
}
