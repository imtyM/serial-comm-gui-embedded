import QtQuick 2.7
import QtQuick.Controls.Material 2.0


ConnectForm {
    connectButton.onReleased:  {
        swipeView.enabled = false;
        connectText.color = "#EF9A9A"
        connectText.text = "    Connecting..."
        if(true){


            infoTab.visible = true;
            infoTab.enabled = true;

            controlTab.visible = true;
            controlTab.enabled = true;

            debugTab.visible = true;
            debugTab.enabled = true;

            swipeView.setCurrentIndex(1)

            swipeView.removeItem(0);
            tabBar.removeItem(0);

            swipeView.setCurrentIndex(0)

        }
        else{
            connectText.color = "#EF9A9A"
            connectText.text = "    Error Connecting to the Server.. \nThe Server was not found on any port."
        }
        swipeView.enabled = true;
    }
}

