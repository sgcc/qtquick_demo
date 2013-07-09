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

ListModel {
    ListElement {
        cityId: "Mostly Cloudy"
        cityName: "Mostly Cloudy"
        lower: 18
        upper: 31
        current: 22
        isNight: false
        weather: "MostlyCloudy"
    }

    ListElement {
        cityId: "Mostly Cloudy 2"
        cityName: "Mostly Cloudy 2"
        lower: 18
        upper: 31
        current: 22
        isNight: true
        weather: "MostlyCloudy"
    }

    ListElement {
        cityId: "Storm"
        cityName: "Storm"
        lower: 2
        upper: 21
        current: 8
        isNight: false
        weather: "Storm"
    }

    ListElement {
        cityId: "Storm 2"
        cityName: "Storm 2"
        lower: 2
        upper: 21
        current: 8
        isNight: true
        weather: "Storm"
    }

    ListElement {
        cityId: "Thunderstorm"
        cityName: "Thunderstorm"
        lower: 10
        upper: 13
        current: 7
        isNight: false
        weather: "Thunderstorm"
    }

    ListElement {
        cityId: "Thunderstorm 2"
        cityName: "Thunderstorm 2"
        lower: 10
        upper: 13
        current: 7
        isNight: true
        weather: "Thunderstorm"
    }

    ListElement {
        cityId: "Rain"
        cityName: "Rain"
        lower: 11
        upper: 25
        current: 12
        isNight: false
        weather: "Rain"
    }

    ListElement {
        cityId: "Rain 2"
        cityName: "Rain 2"
        lower: 11
        upper: 25
        current: 12
        isNight: true
        weather: "Rain"
    }

    ListElement {
        cityId: "Mist"
        cityName: "Mist"
        lower: 21
        upper: 25
        current: 22
        isNight: false
        weather: "Mist"
    }

    ListElement {
        cityId: "Mist 2"
        cityName: "Mist 2"
        lower: 21
        upper: 25
        current: 22
        isNight: true
        weather: "Mist"
    }

    ListElement {
        cityId: "Haze"
        cityName: "Haze"
        lower: 1
        upper: 9
        current: 11
        isNight: false
        weather: "Haze"
    }

    ListElement {
        cityId: "Haze 2"
        cityName: "Haze 2"
        lower: 1
        upper: 9
        current: 11
        isNight: true
        weather: "Haze"
    }

    ListElement {
        cityId: "Fog"
        cityName: "Fog"
        lower: 28
        upper: 35
        current: 30
        isNight: false
        weather: "Fog"
    }

    ListElement {
        cityId: "Fog 2"
        cityName: "Fog 2"
        lower: 28
        upper: 35
        current: 30
        isNight: true
        weather: "Fog"
    }

    ListElement {
        cityId: "Cloudy"
        cityName: "Cloudy"
        lower: 25
        upper: 28
        current: 27
        isNight: false
        weather: "Cloudy"
    }

    ListElement {
        cityId: "Cloudy 2"
        cityName: "Cloudy 2"
        lower: 25
        upper: 28
        current: 27
        isNight: true
        weather: "Cloudy"
    }

    ListElement {
        cityId: "Mostly Sunny"
        cityName: "Mostly Sunny"
        lower: 33
        upper: 39
        current: 36
        isNight: false
        weather: "MostlySunny"
    }

    ListElement {
        cityId: "Mostly Sunny 2"
        cityName: "Mostly Sunny 2"
        lower: 33
        upper: 39
        current: 36
        isNight: true
        weather: "MostlySunny"
    }
}
