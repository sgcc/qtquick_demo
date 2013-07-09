
import QtQuick 2.0

Rectangle {
    id: button
    signal clicked
    property alias text: txt.text
    property bool buttonEnabled: false
    width: Math.max(64, txt.width + 16)
    height: 32
    color: buttonEnabled ? "#76644A" : "transparent"
    border.color: "#76644A"
    border.width: 1
    MouseArea {
        anchors.fill: parent
        onClicked: button.clicked()
    }
    Text {
        anchors.centerIn: parent
        font.pixelSize: 18
        color: "#ecc089"
        id: txt
    }
}
