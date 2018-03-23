import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

Item {
    id: item1
    property alias infoModeOutput: infoModeOutput
    property alias infoFanDirection: infoFanDirection
    property alias infoFanSpeed: infoFanSpeed
    property alias infoFanPositionGauge: infoFanPositionGauge
    property alias infoFanPositionText: infoFanPositionText
    property alias infoTemp1: infoTemp1
    property alias infoTemp2: infoTemp2
    property alias infoTemp4: infoTemp4
    property alias infoTemp3: infoTemp3
    property alias infoLightLevel: infoLightLevel
    property alias wifiStatusText: wifiStatusText
    property alias updateButton: updateButton

    ColumnLayout {
        x: 18
        y: 20
        width: 250
        height: 278

        Frame {
            id: frame1
            Layout.preferredHeight: 190
            Layout.preferredWidth: 250

            RowLayout {
                id: rowLayout1
                x: -9
                y: -31
                height: 39
                anchors.leftMargin: 1
                anchors.topMargin: 0
                anchors.rightMargin: 21
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                Layout.preferredHeight: 105
                Layout.preferredWidth: 100
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Text {
                    id: iMode
                    height: 17
                    color: "#dcd5d5"
                    text: qsTr("Fan Mode: ")
                    Layout.columnSpan: 3
                    font.bold: true
                    horizontalAlignment: Text.AlignLeft
                    wrapMode: Text.NoWrap
                    font.pixelSize: 24
                }

                Text {
                    id: infoModeOutput
                    objectName: "infoModeOutput"
                    color: "#dcd5d5"
                    text: "Manual"
                    textFormat: Text.PlainText
                    font.family: "Verdana"
                    font.pixelSize: 23
                }
            }

           ColumnLayout {
                y: 12
                height: 71
                anchors.rightMargin: 28
                anchors.leftMargin: 8
                anchors.topMargin: 61
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                StatusIndicator {
                    id: wifiStatusIndicator
                    objectName: "wifiStatusIndicator"
                    color: "#f24444"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    active: false
                }

                Text {
                    id: text1
                    color: "#dcd5d5"
                    text: qsTr("WiFi Satus")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.pixelSize: 21
                }

                Label {
                    id: wifiStatusText
                    objectName: "wifiStatusText"
                    text: qsTr("Disconnected")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    color: "#EF9A9A"
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: false
            scale: 1
            spacing: 10
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredHeight: 48
            Layout.preferredWidth: 236

            RowLayout {

                Label {
                    id: label1
                    text: qsTr("Sensor Light Intensity: ")
                }

                Frame {
                    id: frame2
                    width: 76
                    spacing: 17
                    leftPadding: 12
                    opacity: 0.8
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.preferredHeight: 23
                    Layout.preferredWidth: 76

                    Text {
                        id: infoLightIntensity
                        objectName: "infoLightIntensity"
                        x: 1
                        y: -7
                        color: "#dcd5d5"
                        text: qsTr("0 Lux")
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: -7
                        opacity: 1
                        font.pixelSize: 12
                    }
                }
            }

            RowLayout {
                Layout.preferredHeight: 21
                Layout.preferredWidth: 178
                spacing: 0

                Label {
                    id: label2
                    width: 134
                    text: qsTr("   Ouput Light Level:    ")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    scale: 1
                    Layout.preferredHeight: 19
                    Layout.preferredWidth: 150
                    horizontalAlignment: Text.AlignLeft
                }

                Frame {
                    id: frame3
                    width: 78
                    enabled: false
                    spacing: 8
                    Layout.preferredHeight: 19
                    Layout.preferredWidth: 78

                    Text {
                        id: infoLightLevel
                        objectName: "infoLightLevel"
                        x: 23
                        y: -9
                        width: 9
                        height: 14
                        color: "#dcd5d5"
                        text: qsTr("0")
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: -4
                        textFormat: Text.AutoText
                        font.pixelSize: 12
                    }
                }
            }
        }

    }

    Frame {
        id: frame4
        x: 332
        y: 34
        width: 220
        height: 166

        ColumnLayout {
            anchors.rightMargin: 27
            anchors.fill: parent

            Text {
                id: text4
                color: "#dcd5d5"
                text: qsTr("Fan Position")
                Layout.minimumHeight: 0
                verticalAlignment: Text.AlignTop
                font.family: "Arial"
                Layout.preferredHeight: 0
                Layout.preferredWidth: 130
                textFormat: Text.AutoText
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.pixelSize: 17
            }

            CircularGauge {
                id: infoFanPositionGauge
                minimumValue: 0
                objectName: "infoFanPositionGauge"
                value: 19
                Layout.preferredHeight: 128
                Layout.preferredWidth: 215
                tickmarksVisible: false

            }
        }
    }

    Text {
        id: text6
        x: 78
        y: 304
        color: "#dcd5d5"
        text: qsTr("Fan Speed")
        font.family: "Verdana"
        font.pixelSize: 15
    }

    Label {
        id: infoFanDirection
        objectName: "infoFanDirection"
        x: 108
        y: 335
        text: qsTr("OFF")
    }

    Frame {
        id: frame6
        x: 67
        y: 335
        width: 22
        height: 19

        Label {
            id: infoFanSpeed
            objectName: "infoFanSpeed"
            x: -4
            y: -12
            text: qsTr("0")
        }
    }

    GridLayout {
        x: 327
        y: 247
        width: 231
        height: 83
        rows: 2
        columns: 2

        RowLayout {

            Label {
                id: label5
                text: qsTr("Temp 1")
            }

            Frame {
                id: frame7
                Layout.preferredHeight: 33
                Layout.preferredWidth: 40

                Label {
                    id: infoTemp1
                    objectName: "infoTemp1"
                    x: 0
                    y: -5
                    width: 14
                    height: 19
                }
            }
        }

        RowLayout {
            Label {
                id: label9
                text: qsTr("Temp 2")
            }

            Frame {
                id: frame9
                Layout.preferredHeight: 33
                Label {
                    id: infoTemp2
                    objectName: "infoTemp2"
                    x: 0
                    y: -5
                    width: 14
                    height: 19
                }
                Layout.preferredWidth: 40
            }
        }

        RowLayout {
            Label {
                id: label11
                text: qsTr("Temp 3")
            }

            Frame {
                id: frame10
                Layout.preferredHeight: 33
                Label {
                    id: infoTemp3
                    objectName: "infoTemp3"
                    x: 0
                    y: -5
                    width: 11
                    height: 19
                }
                Layout.preferredWidth: 40
            }
        }

        RowLayout {
            Label {
                id: label7
                text: qsTr("Temp 4")
            }

            Frame {
                id: frame8
                Layout.preferredHeight: 33
                Label {
                    id: infoTemp4
                    objectName: "infoTemp4"
                    x: 0
                    y: -5
                    width: 11
                    height: 19
                }
                Layout.preferredWidth: 40
            }
        }
    }

    RowLayout {
        x: 394
        y: 206

        Text {
            id: text5
            color: "#dcd5d5"
            text: qsTr("Position")
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            Layout.preferredHeight: 19
            Layout.preferredWidth: 49
            z: -2
            font.pixelSize: 12
        }

        Frame {
            id: frame5
            Layout.preferredHeight: 19
            Layout.preferredWidth: 23

            Label {
                id: infoFanPositionText
                objectName: "infoFanPositionText"
                x: -5
                y: -12
                width: 9
                height: 19
                text: qsTr("1")
            }
        }
    }

    Button {
        id: updateButton
        x: 400
        y: 336
        text: qsTr("Update")
    }



}
