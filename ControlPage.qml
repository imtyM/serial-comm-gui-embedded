import QtQuick 2.4

ControlPageForm {



    modeSwitch.onCheckedChanged: {
        swipeView.enabled = false;
        if(modeSwitch.checked){
            lightControlFrame.enabled = true;
            fanControlFrame.enabled = true;
            modeSwitch.text = "Manual Mode";
            //Serial.controlFanMode("RMm");

        }
        else{
            lightControlFrame.enabled = false;
            fanControlFrame.enabled = false;
            modeSwitch.text = "Auto Mode"
            //Serial.controlFanMode("RMa");

        }
        swipeView.enabled = true;
    }
    modeSwitch.onClicked:  {
        swipeView.enabled = false;
        if(modeSwitch.checked){
            Serial.controlFanMode("CMm");
        }
        else
            Serial.controlFanMode("CMa");
        swipeView.enabled = true;
    }

    increaseSpeedButton.onClicked: {
        swipeView.enabled = false
        controlFanSpeedSlider.value++;
        Serial.controlFanSpeed(controlFanSpeedSlider.value);
        swipeView.enabled = true
    }
    decreaseSpeedButton.onClicked: {
        swipeView.enabled = false
        controlFanSpeedSlider.value--;
        Serial.controlFanSpeed(controlFanSpeedSlider.value);
        swipeView.enabled = true
    }

    lightIncreaseButton.onClicked: {
        swipeView.enabled = false
        controlLightSlider.value++;
        Serial.controlLightIntensity(controlLightSlider.value);
        swipeView.enabled = true
    }
    lightDecreaseButton.onClicked: {
        swipeView.enabled = false
        controlLightSlider.value--;
        Serial.controlLightIntensity(controlLightSlider.value);
        swipeView.enabled = true
    }

    controlFanPositionSpin.onValueChanged: {
        Serial.controlFanPosition(controlFanPositionSpin.value)
    }


}
