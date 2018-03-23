import QtQuick 2.7

Page1Form {

    updateButton.onClicked: {
        swipeView.enabled = false
        Serial.sendRequests();
        swipeView.enabled = true
    }
}

