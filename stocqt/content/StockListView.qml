
import QtQuick 2.0

Rectangle {
    id: root
    width: 320
    height: 480
    color: "#423A2F"

    property string currentStockId: ""
    property string currentStockName: ""

    ListView {
        id: view
        anchors.fill: parent
        keyNavigationWraps: true
        focus: true
        snapMode: ListView.SnapToItem
        model: StockListModel{}

        onCurrentIndexChanged: {
            root.currentStockId = model.get(currentIndex).stockId;
            root.currentStockName = model.get(currentIndex).name;
            console.log("current stock:" + root.currentStockId + " - " + root.currentStockName);
        }

        delegate: Rectangle {
            height: 30
            width: parent.width
            color: "transparent"
            MouseArea {
                anchors.fill: parent;
                onClicked:view.currentIndex = index;
            }

            Text {
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset : 15
                color: index == view.currentIndex ? "#ECC089" : "#A58963"
                font.pointSize: 12
                font.bold: true
                text:"         " + stockId + " - " + name
            }
        }

        highlight: Rectangle {
            width: parent.width
            color: "#662"
        }
    }
}
