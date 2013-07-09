
import QtQuick 2.0

Item {
    id: button
    property alias text: txt.text
    property bool buttonEnabled: true
    width: 140
    height: 25
    x: 5
    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: {
            if (buttonEnabled)
                buttonEnabled = false;
            else
                buttonEnabled = true;
        }
    }
    Rectangle {
        id: checkbox
        width: 23
        height: 23
        anchors.left: parent.left
        border.color: "#76644A"
        border.width: 1
        antialiasing: true
        radius: 2
        color: "transparent"
        Rectangle {
            anchors.fill: parent
            anchors.margins: 4
            antialiasing: true
            radius: 1
            color: mouse.pressed || buttonEnabled ? "#76644A" : "transparent"
        }
    }
    Text {
        id: txt
        anchors.left: checkbox.right
        anchors.leftMargin: 4
        anchors.verticalCenter: parent.verticalCenter
        text: "Close "
        color: "#ecc089"
        font.pixelSize: 18
    }
}
