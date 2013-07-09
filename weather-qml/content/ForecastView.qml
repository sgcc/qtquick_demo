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
import "forecasts/elements"

Item {
    id: root
    anchors.fill: parent

    signal present();

    property bool isDay : true;
    property bool isClear : true;
    property string cityName;
    property int lowTemperature;
    property int highTemperature;
    property int currentTemperature;

    function scaledX(x) {
        return x * window.scaleFactorX;
    }

    function scaledY(y) {
        return y * window.scaleFactorY + yOffset;
    }

    Image {
        id: bg
        x: root.width / 2 - bg.width / 2
        source: root.isDay ? (root.isClear ? folder + "bg_day_clear.png" : folder + "bg_day_rain.png")
                       : (root.isClear ? folder + "bg_night_clear.png" : folder + "bg_night_rain.png");
    }

    ForecastLabel {
        id: display1
        z: 99
        width: scaledX(320)
        height: 180
        anchors.left: parent.left
        anchors.leftMargin: (128 * window.scaleFactorX) - xOffset
        anchors.bottomMargin: 106
        anchors.bottom: parent.bottom
        currentTemperature: root.currentTemperature
        lowTemperature: root.lowTemperature
        highTemperature: root.highTemperature
    }

    Text {
        id: cityLabel
        z: 99
        text: root.cityName
        font.family: "Nokia Sans"
        font.pixelSize: scaledX(50)
        color: "#ffffff"
        horizontalAlignment: "AlignHCenter"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: scaledX(50)
        anchors.bottomMargin: textOffset
        anchors.bottom: parent.bottom
    }

    Connections { target: parent; onPresent: present(); }
}
