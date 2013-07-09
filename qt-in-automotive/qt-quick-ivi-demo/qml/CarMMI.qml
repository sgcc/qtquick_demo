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
import "./AppFW"
import "./Keyboard"

// This item creates main screen
Item {
    id: document

    property alias properties: properties

    // Properties for the applications that
    // are accessible in the whole application
    QtObject {
        id: properties

        property int width: 800
        property int height: 480

        property alias keyboard: onscreenKeyboard
        property alias backgroundImage: background.source
    }

    width: properties.width
    height: properties.height

    Image {
      id: background
      anchors.fill: parent
      // Background image is user specific, and
      // it is set in UserSelector
      source: ""
    }

    // This item is used to flip between the main screen and keyboard screen
    Flipable {
        id: mainScreen

        anchors.fill: parent

        front:
            AppFramework {
                    id: appFw
                    anchors.fill: parent

                    configuration: activeConfiguration
                }

        back:
           OnscreenKeyboard {
               id: onscreenKeyboard

               // Shows/hides the keyboard
               property bool show: false

               width: properties.width
               height: properties.height
            }

        transform:
            Rotation {
                id: rotator
                origin.x: properties.width/2
                origin.y:properties.height/2
                axis.x: 1; axis.y: 0; axis.z: 0     // rotate around y-axis
                angle: 0
            }

        states:
            State {
                name: "keyboard"
                when: onscreenKeyboard.show
                PropertyChanges { target: rotator; angle: 180 }
            }

        transitions: Transition {
            NumberAnimation { properties: "angle"; duration: 500 }
        }
    }
}
