/** This file is part of QtQuickIVIDemo**

Copyright  2010 Nokia Corporation and/or its subsidiary(-ies).*
All rights reserved.

Contact:  Nokia Corporation qt-info@nokia.com

You may use this file under the terms of the BSD license as follows:

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
* Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
  the names of its contributors may be used to endorse or promote
  products derived from this software without specific prior written
  permission.


THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
*/
import Qt 4.7

// Defines the list of widgets
// shown in the Home application
ListModel {
    ListElement {
        descriptionText: "Music"
        titleText: "Now playing"
        statusText: "No title"
        otherText: ""
        launchApp: "Music"
        dataSource: "Music"
        backgroundImage: "../images/bars/home_bar_music.png"
        iconSource: "../images/icons/icon_music.png"
    }
    ListElement {
        descriptionText: "Navigation"
        titleText: "Location not set"
        statusText: ""
        otherText: ""
        launchApp: "Navigation"
        dataSource: "Navigation"
        backgroundImage: "../images/bars/home_bar_nav.png"
        iconSource: "../images/icons/icon_nav.png"
    }
    ListElement {
        descriptionText: "Log"
        titleText: "No log currently on"
        statusText: ""
        launchApp: "Log"
        otherText: "No type set"
        dataSource: "Log"
        backgroundImage: "../images/bars/home_bar_log.png"
        iconSource: "../images/icons/icon_log.png"
    }
    ListElement {
        titleText: "Phone"
        descriptionText: "Phone"
        statusText: "No phone set"
        otherText: ""
        launchApp: "Phone"
        backgroundImage: "../images/bars/home_bar_phone.png"
        iconSource: "../images/icons/icon_phone.png"
    }
    ListElement {
        titleText: "Internet"
        descriptionText: "Internet"
        statusText: ""
        otherText: ""
        launchApp: "Browser"
        backgroundImage: "../images/bars/home_bar_internet.png"
        iconSource: "../images/icons/icon_internet.png"
    }
    ListElement {
        titleText: "Weather forecast"
        descriptionText: "Weather"
        statusText: ""
        otherText: ""
        launchApp: ""
        backgroundImage: "../images/bars/home_bar_others.png"
        iconSource: "../images/icons/icon_weather.png"
    }
    ListElement {
        titleText: "Synchronization"
        descriptionText: "Synch"
        statusText: ""
        otherText: ""
        launchApp: ""
        backgroundImage: "../images/bars/home_bar_others.png"
        iconSource: "../images/icons/icon_synchronization.png"
    }
    ListElement {
        titleText: "Settings"
        descriptionText: "Settings"
        statusText: ""
        otherText: ""
        launchApp: ""
        backgroundImage: "../images/bars/home_bar_others.png"
        iconSource: "../images/icons/icon_profile_settings.png"
    }
}
