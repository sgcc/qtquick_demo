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
import "../shared"

// A framework component that contains the available
// applications and global controls available to all
// applications
Item {
    id: appFw

    // Defines whether global controls (VolumeBar, UserSelector
    // and TopNav) use semitransparent backgound
    property bool transparentControls: false
    // Defines the configuration of available applications
    property variant configuration
    property alias currentUser: userSelector.currentUser

    // Signal that active application has changed
    signal applicationActive(string appName)
    // Signals home widgets that application data has been changed
    // It is the responsibility of the widget to display the
    // data as it wishes
    signal appDataChanged(string appName, variant data)

    // Switches to the application given by appName
    function changeApp(appName) {
        appHolder.changeApp(appName);
    }

    // Container for available applications
    AppHolder{
        id: appHolder

        anchors.left: volumeBar.right
        anchors.right: appFw.right
        anchors.top: topNav.bottom
        anchors.bottom: toolbar.top
    }

    // Navigation pane at the top of the screen
    TopNav {
        id: topNav

        configuration: appFw.configuration
        anchors.left: volumeBar.right
        anchors.right: appFw.right
        height:  110
        // By clicking on an icon
        // switch to the application
        onItemClicked: changeApp(appName)
    }

    // Place toolbar at the bottom of the screen
    Toolbar {
        id: toolbar
        height: 70
        anchors.left: volumeBar.right
        anchors.right: appFw.right
        anchors.bottom: appFw.bottom
        anchors.leftMargin: 0
        anchors.rightMargin:10
    }

    // Place volume bar at the left side of the screen
    VolumeBar {
        id: volumeBar
        anchors.top : topNav.bottom
        anchors.bottom: appFw.bottom
        width:  110
    }
    // User selector needs to be available at all times,
    // as it displays small user icon at the top left hand corner
    // of the screen
    UserSelector {
        id: userSelector

        width: appFw.width
        height: appFw.height
        // When a new user has been selected, enter the Home application
        onUserChanged: changeApp("Home")
    }

    QuitDialog { id: quitDialog }
}
