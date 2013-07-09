/****************************************************************************


****************************************************************************/

import QtQuick 1.0

Rectangle {
    id: root

    signal clicked

    property alias textItem: buttonText

    width: 180
    height:  30
    color:  "#88456789"
    radius: 5

    Text { id: buttonText; anchors.margins: 5;  font.family: "Arial"; font.pixelSize: 23; color: "#ffffff"}

    MouseArea { anchors.fill: parent; onClicked: root.clicked() }
}
