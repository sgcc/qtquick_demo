/****************************************************************************
** 获取股票的具体数据
**
****************************************************************************/

import QtQuick 2.0

ListModel {
    id: model
    property string stockId: ""
    property string stockName: ""
    property var    startDate
    property var    endDate
    property string stockDataCycle: "d"
    property bool   ready: false
    property real   stockPrice: 0.0
    property real   stockPriceChanged: 0.0
    property real   highestPrice: 0
    property real   highestVolume: 0

    signal dataReady

    function indexOf(date) {
        var end = new Date(model.get(0).date);
        var start = new Date(model.get(model.count - 1).date);
        if (end <= date)
            return model.count -1;

        if (start >= date)
            return 0;

        for (var i = 0; i < model.count; i++) {
            var d = new Date(model.get(i).date);
            if ( d === date)
                return i;
        }
        return -1;
    }

    /*
        Fetch stock data from yahoo finance:
        返回股票ID的 csv格式数据

        url: http://ichart.finance.yahoo.com/table.csv?s=NOK&a=5&b=11&c=2010&d=7&e=23&f=2010&g=d&ignore=.csv
        s:stock name/id,
        a:start day,
        b:start month,
        c:start year  default: 25 April 1995, oldest c= 1962
        d:end day,
        e:end month,
        f:end year,
        default:today  (data only available 3 days before today)
        g:data cycle(d daily,  w weekly, m monthly, v Dividend)
      */
    function requestUrl() {
        if (stockId === "")
            return;

        if (startDate === undefined)
            startDate = new Date(1995, 3, 25); //default: 25 April 1995

        if (endDate === undefined)
            endDate = new Date(); //today

        if (stockDataCycle !== "d" && stockDataCycle !== "w" && stockDataCycle !== "m")
            stockDataCycle = "d";

        var request = "http://ichart.finance.yahoo.com/table.csv?";
        request += "s=" + stockId;
        request += "&a=" + startDate.getDate();
        request += "&b=" + startDate.getMonth();
        request += "&c=" + startDate.getFullYear();
        request += "&d=" + endDate.getDate();
        request += "&e=" + endDate.getMonth();
        request += "&f=" + endDate.getFullYear();
        request += "&g=" + stockDataCycle;
        request += "&ignore=.csv";
        console.debug("stock requestURL:" + request)
        return request;
    }

    function createStockPrice(r) {
        if (highestPrice < r[2])
            highestPrice = r[2];
        if (highestVolume < r[5])
            highestVolume = r[5];
        return {
                "date": r[0],
                "open": r[1],
                "high": r[2],
                "low":  r[3],
                "close":r[4],
                "volume":r[5],
                "adjusted":r[6]
               };
    }

    function updateStock() {
        var xhr = new XMLHttpRequest;
        var req = requestUrl();
        xhr.open("GET", req);

        model.ready = false;
        model.clear();
        var i = 1; //skip the first line，is columns
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.LOADING || xhr.readyState === XMLHttpRequest.DONE) {
                var records = xhr.responseText.split('\n');

                for (;i < records.length; i++ ) {
                    var r = records[i].split(',');
                    if (r.length === 7)
                        model.append(createStockPrice(r));
                }

                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (model.count > 0) {
                        model.ready = true;
                        model.stockPrice = model.get(0).adjusted;
                        model.stockPriceChanged = Math.round((model.stockPrice - model.get(2).adjusted) * 100) / 100;
                        model.dataReady(); //emit signal
                    }
                }
            }
        }
        xhr.send()
    }
}
