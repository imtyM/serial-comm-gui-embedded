import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

ApplicationWindow {
    Material.theme: Material.Dark
    Material.accent: Material.Red
    id: root
    visible: true
    maximumWidth: 575
    minimumWidth: 575
    width: 575
    maximumHeight: 440
    minimumHeight: 440
    height: 440
    title: qsTr("Fan Interface")





    Timer{
        interval: 15000; running: false; repeat: true
        onTriggered: {
            Serial.sendRequests();
        }
    }

    SwipeView {
        visible: true
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Connect{

        }

        Page1 {

        }

        ControlPage {

        }
        DebugPage{

        }
    }

    header: TabBar {
        visible: true
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton{
            id: connectTab
            text: qsTr("Connect")
            width: 575
        }
        TabButton {
            id: infoTab
            enabled: false
            visible: false
            text: qsTr("Information")
        }
        TabButton{
            id: controlTab
            enabled: false
            visible: false
            text: qsTr("Control")
        }
        TabButton{
            id: debugTab
            enabled: false
            visible: false
            text: qsTr("Debugging")
        }
    }
}
