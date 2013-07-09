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
import "content"

Rectangle {
    id: window
    width: 480
    height: 800
    color: "black"

    property string folder: "images/n900/"

    property int currentIndex : -1;
    property bool splashVisible : true
    property string weatherSource : ""

    property int verticalOffset: -40
    property real scaleFactorX: window.width / 480.0
    property real scaleFactorY: window.height / 800.0
    property int yOffset: 140
    property int xOffset: 0
    property int textOffset: 30

    CityModel {
        id: cityModel
    }

    WeatherView {
        id: view
        x: -65 * scaleFactorX
        width: 550
        height: window.height - bottomBar.height
    }

    CityPanel {
        id: cityPanel
        anchors.top: parent.top
        anchors.bottom: bottomBar.top
    }

    Image {
        id: bottomBar
        source: "content/" + folder + "bg_bottom_options.png"
        anchors.bottom: parent.bottom
    }

    SplashScreen {
        id: splash
        anchors.fill: parent
        visible: true
    }

    Timer {
        interval: 1000
        repeat: false
        running: true
        onTriggered: splash.visible = false;
    }

    Text {
        id: exitLabel
        text: "Exit"
        color: "white"
        font.family: "Nokia Sans"
        font.pixelSize: 28

        anchors.fill: bottomBar
        anchors.rightMargin: 15
        anchors.leftMargin: window.width / 2
        verticalAlignment: "AlignVCenter"
        horizontalAlignment: "AlignRight"

        MouseArea {
            anchors.fill: parent
            onClicked: { Qt.quit(); }
        }
    }
}
