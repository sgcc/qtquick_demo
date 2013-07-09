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
import "keyboard.js" as Js

// Button used in OnScreenKeyboard.qml
Rectangle {
    id: button

    property string operation
    property bool toggable : false
    property bool toggled : false

    width: 60
    height: 40
    border.color: palette.mid
    radius: 5
    // Use gradient backround for the keyboard text
    gradient: Gradient {
        GradientStop {
            id: g1
            position: 0.0
            color: palette.button
        }
        GradientStop {
            id: g2
            position: 1.0
            color: Qt.darker(palette.button)
        }
    }

    // Use system palette to get
    // standard colors for the keyboard components
    SystemPalette { id: palette }

    Text {
        anchors.centerIn: parent
        font.bold: true
        text: operation
        font.pixelSize:18
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Js.handleOpCode(operation);
            // Toggle button state
            if (button.toggable)
                button.toggled ? button.toggled = false : button.toggled = true
        }
    }

    // A key can be pressed or not pressed, and it can be toggled on/off
    states: [
        State {
            name: "Pressed"
            when: clickRegion.pressed == true
            PropertyChanges { target: g1; color: palette.dark }
            PropertyChanges { target: g2; color: palette.button }
        },
        State {
            name: "Toggled"
            when: button.toggled == true
            PropertyChanges { target: g1; color: palette.dark }
            PropertyChanges { target: g2; color: palette.button }
        }
    ]
}
