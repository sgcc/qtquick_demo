/****************************************************************************
**
** This file is part of Weather
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

Item {
    id: root

    Component {
        id: cityDelegate

        Item {
            id: itemInner
            width: 572 * scaleFactorX
            height: parent.height

            signal present();

            Component.onCompleted: {
                var component = Qt.createComponent("forecasts/" + model.weather + ".qml");
                var element = component.createObject(itemInner);

                if (element != undefined) {
                    element.cityName = model.cityName;
                    element.isDay = !model.isNight;
                    element.lowTemperature = model.lower;
                    element.highTemperature = model.upper;
                    element.currentTemperature = model.current;
                }
            }
        }
    }

    ListView {
        id: list
        property bool moving: false

        anchors.fill: parent
        orientation: "Horizontal"
        //currentIndex: window.currentIndex

        onCurrentIndexChanged: {
            if (!moving && list.currentItem)
                list.currentItem.present();
        }

        onMovementStarted: {
            moving = true;
        }

        onMovementEnded: {
            moving = false;
            list.currentItem.present();
        }

        model: cityModel
        //cacheBuffer: 1000
        delegate: cityDelegate

        snapMode: ListView.SnapOneItem
        highlightRangeMode: "StrictlyEnforceRange"
    }
}
