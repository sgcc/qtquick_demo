/****************************************************************************
**

**
****************************************************************************/

import QtQuick 2.0
import QtQml.Models 2.1
import "./content"

ListView {
    id: root
    width: 320
    height: 480
    snapMode: ListView.SnapOneItem
    focus: false
    orientation: ListView.Horizontal
    boundsBehavior: Flickable.StopAtBounds
    currentIndex: 1

    StockModel {
        id: stock
        stockId: listView.currentStockId
        stockName: listView.currentStockName
        startDate: settings.startDate
        endDate: settings.endDate
        onStockIdChanged: updateStock()
        onStartDateChanged: updateStock()
        onEndDateChanged: updateStock()
        onDataReady: {
            root.currentIndex = 1
            stockView.update()
        }
    }

    model: ObjectModel {
        StockListView {
            id: listView
            width: root.width
            height: root.height
        }

        StockView {
            id: stockView
            width: root.width
            height: root.height
            stocklist: listView
            settings: settings
            stock: stock

            onListViewClicked: root.currentIndex = 0
            onSettingsClicked: root.currentIndex = 2
        }

        StockSettings {
            id: settings
            width: root.width
            height: root.height
            onDrawHighPriceChanged: stockView.update()
            onDrawLowPriceChanged: stockView.update()
            onDrawOpenPriceChanged: stockView.update()
            onDrawClosePriceChanged: stockView.update()
            onDrawVolumeChanged: stockView.update()
            onDrawKLineChanged: stockView.update()
            onChartTypeChanged: stockView.update()
        }
    }
}
