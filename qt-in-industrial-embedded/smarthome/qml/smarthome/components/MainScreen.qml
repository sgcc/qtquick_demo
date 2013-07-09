/** This file is part of Home Control Qt Quick Embedded Widgets Demo**
*
* Copyright © 2010 Nokia Corporation and/or its subsidiary(-ies).*
* All rights reserved.
*
* Contact:  Nokia Corporation (qt-info@nokia.com)
*
* You may use this file under the terms of the BSD license as follows:
*
* “Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright notice, this
* list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice,
* this list of conditions and the following disclaimer in the documentation
* and/or other materials provided with the distribution.
* Neither the name of Nokia Corporation and its Subsidiary(-ies) nor the
* names of its contributors may be used to endorse or promote products
* derived from this software without specific prior written permission.
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
* THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
* PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
* BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
* SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
* INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
* CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
* ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
* THE POSSIBILITY OF SUCH DAMAGE.”
*/

import Qt 4.7
import "models"

/**
This Rectangle defines the main screen area which is visible most of the time.
*/
Rectangle {
    id: mainScreen

    property alias xSpacing: mainMenu.xSpacing
    property alias ySpacing: mainMenu.ySpacing
    property alias lux: mainMenu.currentLux
    property alias hour: mainMenu.currentHour
    property alias minute: mainMenu.currentMinute
    property alias wind: mainMenu.currentWindForce
    property alias rain: mainMenu.currentRain

    property alias weather: weatherView.weather
    property alias forecastWind: forecastView.wind
    property alias forecastRainProp: forecastView.rainProp
    property alias forecastRain: forecastView.rain
    property alias temperature: temperatureView.current
    property alias temperatureHigh: temperatureView.maximum
    property alias temperatureLow: temperatureView.minimum

    /*
    * This functions forces a check in underlying elements
    */
    function checkState() {
        mainMenu.checkStates();
    }

    /*
    * This sets the main menu to defaultview when clicked
    */
    MouseArea {
        id: mainMouseArea
        anchors.fill: parent
        onClicked: {
            mainMenu.showAll()
        }
    }

    /*
    * backgroud image
    */
    Image {
        id: background
        anchors.fill: parent
        source: "pics/screenelements/background.png"
    }

    /*
    * all current weather items are defined here
    */
    Row {
        id: weatherId

        property int count: 3
        property int elementWidth: (width - (2 * count * spacing)) / count

        anchors { left: parent.left; right: parent.right; top: parent.top; topMargin: 80}
        height: 220
        spacing: 35

        Rectangle {
            id: dummyStart
            width:  1
            height: parent.height
            color: "transparent"
        }

        WeatherView {
            id: weatherView
            width: weatherId.elementWidth
            height: parent.height
            state: "good"
        }

        Devider {
            id: seperator1
            height: 200
        }

        TemperatureView {
            id: temperatureView
            width: weatherId.elementWidth
            height: parent.height
            textColor: "white"
        }

        Devider {
            id: seperator2
            height: 200
        }

        ForeCastView {
            id: forecastView
            width: weatherId.elementWidth
            height: parent.height
        }

        Rectangle {
            id: dummyEnd
            width:  1
            height: parent.height
            color: "transparent"
        }
    }

    Image {
        id: divider
        source: "pics/screenelements/devider_shadow.png"
        width: parent.width
        y: 300

    }

    /*
    * This is just a basyskom logo, but the clue is that it can also quit the application
    * see the onPressed function in the MouseArea
    */
    Image {
        id:basyskomLogo
        anchors{ bottom: parent.bottom; bottomMargin:4; left: parent.left; leftMargin: 4 }
        smooth: true
        source: "pics/logos/basyskom-logo-small.png"
        MouseArea {
            anchors.fill: parent
            onPressed: Qt.quit()
        }
    }

    /*
    * The main menu show all smarthome settings
    */
    MainMenu {
        id: mainMenu
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height - 325
        baseWidth: parent.width
        baseHeight: parent.height - parent.ySpacing
        currentTemperature: mainScreen.temperature
    }
}
