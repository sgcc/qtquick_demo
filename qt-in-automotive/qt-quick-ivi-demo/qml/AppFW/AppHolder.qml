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
import "../Home"

// Holder item for applications. Applications are
// loaded dynamically with Loader, when used for the first time
// There exist a unique loader for each application, as
// applications must run concurrently. In addition,
// 'Home' application is always available
Item {
    id: appHolder

    property variant currentApp
    property bool transparentControls: appFw.transparentControls

    // Switches to the application given by appName.
    // The application is loaded by setting the source
    // property, which makes the application code to
    // be loaded. The application handle
    // is obtained from the children property
    function changeApp(appName) {
        var app = null;
        // Home application is loaded statically
        // with a specific id
        if (appName == "Home")
            app = homeApp;
        else {
            for (var i=0; i < appHolder.children.length && !app; i++) {
                // Set the desired application source property
                // in the associated Loader
                if (appHolder.children[i].appName == appName &&
                    appHolder.children[i].application) {
                    appHolder.children[i].source = appHolder.children[i].tempSource;
                    app = appHolder.children[i];
                }
            }
        }
        // If application handle was found, switch
        // the currentApp property, and set
        // the application to the active state
        if (app) {
            if (appHolder.currentApp)
                appHolder.currentApp.activeApp = false;
            app.activeApp = true;
            appHolder.currentApp = app;
        // Set application focus here. Setting
        // it statically won't work
        appHolder.currentApp.focus = true
        applicationActive(appName);
        }
    }

    // Home app is always available
    HomeApp {
        id: homeApp
        property bool activeApp: false

        // Listen for user change signals, and
        // reset home widgtet contents
        Connections {
            target: userSelector
            onUserChanged: homeApp.resetContent();
        }
    }

    // Create with Repeater unique Loader components
    // for each application in the active configuration.
    // In essence, a new child gets created in
    // appHolder
    Repeater {
        model: configuration
        Loader {
            property bool application: true
            property string appName: name
            // Defines whether the application is currently
            // the foremost application
            property bool activeApp: false
            // A temp variable used to set the source
            // property from appSource from the configuration
            property string tempSource: appSource
            source: ""
        }
    }

    // Full screen is a specific state, in
    // which the appHolder occupies whole screen area
    states:
        State {
            name: "fullscreen"
            changes: [
                // Move appHolder the topmost component,
                // by placing it as a child of document
                // This ensures that the application is not
                // obscured by toolbar, volume bar
                // or navigation bar
                ParentChange {
                    target: appHolder
                    parent: document
                    x: 0
                    y: 0
                    width: document.width
                    height: document.height
                },
                // In full screen, show exit full screen button
                PropertyChanges {
                    target: exitFsBtn
                    opacity: 1
                }
            ]
        }

    // Full screen exit button is placed on top
    // of all applications
    ExitFullscreenButton {
        id: exitFsBtn
        anchors.right: appHolder.right
        anchors.top: appHolder.top
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        // By default the button is not visible
        opacity: 0

        MouseArea {
            anchors.fill: parent
            onClicked: appHolder.state = ""
        }
    }

    transitions: [
            Transition {
                to: "fullscreen"
                // Animate the transition to full screen
                ParentAnimation {
                    via: document
                    NumberAnimation {
                        target: appHolder
                        properties: "x,y, width, height"
                        easing.type: Easing.InOutQuad
                        duration: 500
                    }
                }
            },
            Transition {
                to: ""
                // Animate the transition back to normal mode
                ParentAnimation {
                    via: document
                    NumberAnimation {
                        target: appHolder
                        properties: "x,y"
                        easing.type: "InOutQuad"
                        duration: 500
                    }
                    PropertyAnimation {
                        target: appHolder
                        property: "width"
                        to: document.width
                        easing.type: Easing.InOutQuad
                    }
                    PropertyAnimation {
                        target: appHolder
                        property: "height"
                        to: document.height
                        easing.type: Easing.InOutQuad
                    }
                }
            }

        ]
}
