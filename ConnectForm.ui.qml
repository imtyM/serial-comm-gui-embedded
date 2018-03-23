import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

Item {
    id: item1
    width: 400
    height: 400
    property alias connectText: connectText
    property alias connectButton: connectButton

    ColumnLayout {
        id: columnLayout1
        anchors.fill: parent

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredWidth: -1

            Label {
                id: label1
                text: qsTr("Please Ensure that the wifi module is connected")
            }

            Button {
                id: connectButton
                text: qsTr("Connect")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Label {
                id: connectText
                text: qsTr("")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
        }
    }
}
