/****************************************************************************
**
** This file is part of RadioTuner
**
** Copyright (c) 2010 Nokia Corporation and/or its subsidiary(-ies).*
** All rights reserved.
** Contact:  Nokia Corporation (qt-info@nokia.com)
**
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions
** are met:
**
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in the
**     documentation and/or other materials provided with the distribution.
**
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
**  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
**  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
**  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
**  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
**  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
**  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
**  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
**  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
**  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
**  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
**  POSSIBILITY OF SUCH DAMAGE."
**
****************************************************************************/

import Qt 4.7
import "rangemodel.js" as RangeFunctions

Item {
    id: root

    property real scaleFactor: root.width/800.0;

    StationsModel {
        id: stationsModel
    }

    Image {
        id: bottomBar
        source: folder+"bottom.png"
        anchors.bottom: root.bottom

        Text {
            id: stationName
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 16 * scaleFactor
            color: "#ffffff"
            styleColor: "#ffffff"
            font.family: "Nokia Sans"
            font.pixelSize: 35 * scaleFactor
       }

       Text {
            id: stationDial
            anchors.top: stationName.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: -6 * scaleFactor
            color: "#eaeaeb"
            styleColor: "#eaeaeb"
            font.family: "Nokia Sans"
            font.pixelSize: 25 * scaleFactor
        }
    }

    Image {
        id: topBar
        source: folder+"top.png"
        anchors.bottom: tunerBg.top
    }

    Image {
        id: tunerBg
        source: folder+"scala_bg.png"
        anchors.bottom: bottomBar.top
        anchors.left: buttonPrevious.right
    }

    ListModel{
        id: listModelExample
    }


    ListView {
        id: radioList
        anchors.fill: tunerBg
        anchors.leftMargin: -15 * scaleFactor
        orientation: "Horizontal"
        model: RangeFunctions.createModel(stationsModel, listModelExample)
        delegate: scaleDelegate
        highlightMoveSpeed: -1
        highlightRangeMode: "StrictlyEnforceRange"

        onCurrentIndexChanged: {
            var index = RangeFunctions.getCenterIndex(currentIndex);

            if (index >= 0 && index < radioList.model.count) {
                var model = radioList.model.get(index);
                if (model.stationName) {
                    stationName.text = model.stationName;
                    stationDial.text = model.station;
                }
            }
        }
    }

    Component {
        id: scaleDelegate
        RangeStation {
            width: parseInt(29 * scaleFactor)
            height: 264 * scaleFactor
            stationRange: model.stationRange
            kind: model.kind
            station: model.station
            stationName: model.stationName
        }
    }

    Image {
        id: buttonNext
        anchors.bottom: bottomBar.top
        anchors.left: tunerBg.right
        source: folder+"bt_next.png"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                var index = RangeFunctions.getNextStation(radioList);
                if (index >= 0)
                    radioList.currentIndex = index;
            }
        }
    }

    Image {
        id: buttonPrevious
        anchors.bottom: bottomBar.top
        anchors.left: parent.left
        source: folder+"bt_prev.png"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                var index = RangeFunctions.getPreviousStation(radioList);
                if (index >= 0)
                   radioList.currentIndex = index;
            }
        }
    }

    Image {
        anchors.top: tunerBg.top
        anchors.left: tunerBg.left
        source: folder+"scala_glass.png"
    }

    Image {
        anchors.bottom: bottomBar.top
        anchors.horizontalCenter: tunerBg.horizontalCenter
        source: folder+"scala_needle.png"
    }

    Component.onCompleted: {
        var station = RangeFunctions.getStation(0);

        if (station) {
            stationName.text = station.name;
            stationDial.text = station.dial;
            radioList.currentIndex = station.centerIndex;
        }

        radioList.highlightMoveSpeed = 1000;
    }

    Image {
        id: bt_close
        anchors.top: parent.top
        anchors.right: parent.right
        source: folder + "close.png"

        MouseArea {
            anchors.fill: parent
            onClicked: Qt.quit()
        }
    }
}
