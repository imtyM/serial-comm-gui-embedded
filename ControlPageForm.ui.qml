import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Universal 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Styles 1.4

Item {
    width: 400
    height: 400
    property alias lightIncreaseButton: lightIncreaseButton
    property alias lightDecreaseButton: lightDecreaseButton
    property alias increaseSpeedButton: increaseSpeedButton
    property alias decreaseSpeedButton: decreaseSpeedButton
    property alias controlFanPositionSpin: controlFanPositionSpin
    property alias controlFanSpeedText: controlFanSpeedText
    property alias controlFanSpeedSlider: controlFanSpeedSlider
    property alias controlLightSlider: controlLightSlider
    property alias fanControlFrame: fanControlFrame
    property alias lightControlFrame: lightControlFrame
    property alias modeSwitch: modeSwitch

    Switch {
        id: modeSwitch
        objectName: "modeSwitch"
        x: 34
        y: 39
        width: 160
        height: 40
        text: "Auto Mode"
        checked: false
    }

    Frame {
        id: lightControlFrame
        objectName: "lightControlFrame"
        x: 150
        y: 96
        width: 316
        height: 92
        enabled: false

        ColumnLayout {
            anchors.fill: parent

            Label {
                id: label1
                text: qsTr("Light Control")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            RowLayout {

                Label {
                    id: label2
                    text: qsTr("Output Light Intensity")
                    rightPadding: 4
                }

                Button {
                    id: lightDecreaseButton
                    text: qsTr("-")
                    Layout.maximumHeight: 30
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.minimumHeight: 30
                    Layout.minimumWidth: 30
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                }

                Slider {
                    snapMode: Slider.SnapAlways
                    id: controlLightSlider
                    objectName: "controlLightSlider"
                    stepSize: 1
                    from: 0
                    to: 3
                    Layout.preferredHeight: 17
                    Layout.preferredWidth: 80
                    value: 0
                }

                Button {
                    id: lightIncreaseButton
                    width: 30
                    height: 18
                    text: qsTr("+")
                    Layout.maximumHeight: 30
                    Layout.minimumHeight: 30
                    Layout.minimumWidth: 30
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

            }
        }
    }

    Frame {
        id: fanControlFrame
        objectName: "fanControlFrame"
        x: 116
        y: 205
        width: 387
        height: 131
        enabled: false

        GridLayout {
            anchors.fill: parent
            rows: 3
            columns: 3

            Item {
                id: spacer1
                Layout.preferredHeight: 14
                Layout.preferredWidth: 14
            }

            Label {
                id: label3
                text: qsTr("Fan Control")
                Layout.preferredWidth: 147
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Item {
                id: spacer2
                Layout.preferredHeight: 14
                Layout.preferredWidth: 34
            }

            RowLayout {
                Layout.columnSpan: 3

                Label {
                    id: label4
                    text: qsTr("Fan Speed Level")
                    rightPadding: 5
                }

                Button {
                    id: decreaseSpeedButton
                    objectName: "decreaseSpeedButton"
                    width: 34
                    height: 33
                    text: qsTr("-")
                    Layout.maximumHeight: 30
                    scale: 1
                    Layout.minimumHeight: 30
                    Layout.minimumWidth: 30
                    Layout.fillHeight: true
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Slider {
                    id: controlFanSpeedSlider
                    snapMode: Slider.SnapAlways
                    objectName: "controlFanSpeedSlider"
                    stepSize: 1
                    from: 0
                    value: 0
                    to: 4
                    Layout.preferredHeight: 28
                    Layout.preferredWidth: 137
                }

                Button {
                    id: increaseSpeedButton
                    objectName: "increaseSpeedButton"
                    height: 45
                    text: qsTr("+")
                    Layout.maximumHeight: 30
                    Layout.minimumHeight: 30
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                }

                Frame {
                    id: frame2
                    Layout.preferredHeight: 25
                    Layout.preferredWidth: 38

                    Label {
                        id: controlFanSpeedText
                        objectName: "controlFanSpeedText"
                        x: 3
                        y: -9
                        text: qsTr("0")
                    }
                }


            }

            Label {
                id: label6
                text: qsTr("Fan Position")
            }

            SpinBox {
                id: controlFanPositionSpin
                objectName: "controlFanPositionSpin"
                Layout.columnSpan: 2
                to: 4
                from: 1
                value: 1
            }
        }
    }

}
