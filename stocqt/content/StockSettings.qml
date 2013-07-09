/****************************************************************************
** 股票设置页面
**
****************************************************************************/

import QtQuick 2.0

Rectangle {
    id: root
    width: 320
    height: 480
    color: "#423A2F"
    property var startDate : startDatePicker.date
    property var endDate : endDatePicker.date

    property bool drawHighPrice: highButton.buttonEnabled
    property bool drawLowPrice: lowButton.buttonEnabled
    property bool drawOpenPrice: openButton.buttonEnabled
    property bool drawClosePrice: closeButton.buttonEnabled
    property bool drawVolume: volumeButton.buttonEnabled
    property bool drawKLine: klineButton.buttonEnabled

    property color highColor: Qt.rgba(1, 0, 0, 1)
    property color lowColor:  Qt.rgba(0, 1, 0, 1)
    property color openColor: Qt.rgba(0, 0, 1, 1)
    property color volumeColor: Qt.rgba(0.3, 0.5, 0.7, 1)
    property color closeColor: "#ecc088"

    property string chartType: "year"

    Image {
        id: logo
        source: "images/logo.png"
        anchors.horizontalCenter : parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 15
    }

    Text {
        id: startDateText
        text: "START DATE:"
        color: "#76644A"
        font.pointSize: 15
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: logo.bottom
        anchors.topMargin: 20
    }

    DatePicker {
        id: startDatePicker
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: startDateText.bottom
        anchors.topMargin: 8
    }

    Text {
        id: endDateText
        text: "END DATE:"
        color: "#76644A"
        font.pointSize: 15
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: startDatePicker.bottom
        anchors.topMargin: 20
    }

    DatePicker {
        id: endDatePicker
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: endDateText.bottom
        anchors.topMargin: 8
    }

    Text {
        id: drawOptionsText
        text: "DRAW OPTIONS:"
        color: "#76644A"
        font.pointSize: 15
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: endDatePicker.bottom
        anchors.topMargin: 20
    }
    Column {
        id: drawOptions
        anchors.top: drawOptionsText.bottom
        anchors.topMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 30
        spacing: 2

        Row {
            spacing: 10

            CheckBox {
                id: highButton
                text: "High"
                buttonEnabled: false
            }
            CheckBox {
                id: lowButton
                text: "Low"
                buttonEnabled: false
            }
        }
        Row {
            spacing: 10
            CheckBox {
                id: openButton
                text: "Open"
                buttonEnabled: false
            }
            CheckBox {
                text: "Close"
                id: closeButton
                buttonEnabled: true
            }

        }
        Row {
            spacing: 10
            CheckBox {
                id: volumeButton
                text: "Volume"
                buttonEnabled: true
            }
            CheckBox {
                id: klineButton
                text: "K Line"
                buttonEnabled: false
            }
        }
    }

    Text {
        id: chartTypeText
        text: "SHOW PREVIOUS:"
        color: "#76644A"
        font.pointSize: 15
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: drawOptions.bottom
        anchors.topMargin: 20
    }
    Row {
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: chartTypeText.bottom
        anchors.topMargin: 8
        spacing: -1
        Button {
            id: yearView
            text: "YEAR"
            buttonEnabled: root.chartType == "year"
            onClicked: root.chartType = "year"
        }
        Button {
            id: monthView
            text: "MONTH"
            buttonEnabled: root.chartType == "month"
            onClicked: root.chartType = "month"
        }
        Button {
            id: weekView
            text: "WEEK"
            buttonEnabled: root.chartType == "week"
            onClicked: root.chartType = "week"
        }
        Button {
            id: allView
            text: "ALL"
            buttonEnabled: root.chartType == "all"
            onClicked: root.chartType = "all"
        }
    }

    Component.onCompleted: startDatePicker.date = new Date(1995, 3, 25)
}
