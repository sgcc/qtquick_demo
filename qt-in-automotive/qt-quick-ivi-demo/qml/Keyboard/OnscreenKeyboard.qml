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

Item {
    id: keybMainWindow

    property int leftmargin: 5
    property int topmargin: 50
    property int frame: 10
    property string label: ""
    // Initial value for the text field
    property alias initText: curText.text

    // Signalled when Enter is pressed on the keyboard
    signal textEntered(string kbdText)

    // Background for the keyboard
    Rectangle {
        id: bg
        color: "black"
        width: parent.width - 2 * frame
        height: layout.height + 30
        border.width: 4
        border.color:"white"
        radius: 15
        opacity: 0.8
        x: frame
        y:topmargin
    }

    Column{
        id: layout

        y: bg.y + 15
        anchors.left: bg.left
        anchors.right: bg.right
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        spacing: 20

        Text {
            id: labelText

            anchors.leftMargin: leftmargin
            text: keybMainWindow.label + ": "
            font.bold: true
            font.pixelSize: 26
            color: "white"
        }

        // Framed text field for the input text
        Rectangle {
            id: textFrame

            radius: 8
            anchors.left: parent.left
            anchors.right: parent.right
            height: 40
            color:  "#323232"
            border.color: "#d5d5d5"
            border.width: 1

            Text {
                id: curText

                anchors.left: parent.left
                anchors.leftMargin: frame
                anchors.verticalCenter: parent.verticalCenter
                text: keybMainWindow.initText
                font.bold: true
                font.pixelSize: 26
                color: "white"
            }
        }

        // Arrange keypad keys into a grid
        // Special keys are placed into the last
        // column with a custom width
        Grid {
            id: numKeypad
            spacing: 2
            columns: 12

            KeyButton { operation: "1" }
            KeyButton { operation: "2" }
            KeyButton { operation: "3" }
            KeyButton { operation: "4" }
            KeyButton { operation: "5" }
            KeyButton { operation: "6" }
            KeyButton { operation: "7" }
            KeyButton { operation: "8" }
            KeyButton { operation: "9" }
            KeyButton { operation: "0" }
            KeyButton { operation: "+" }
            KeyButton { operation: "Bksp"; width: 68;}

            KeyButton { operation: "Q" }
            KeyButton { operation: "W" }
            KeyButton { operation: "E" }
            KeyButton { operation: "R" }
            KeyButton { operation: "T" }
            KeyButton { operation: "Y" }
            KeyButton { operation: "U" }
            KeyButton { operation: "I" }
            KeyButton { operation: "O" }
            KeyButton { operation: "P" }
            KeyButton { operation: "" }
            KeyButton { operation: "Enter"; width: 68; }

            KeyButton { operation: "A" }
            KeyButton { operation: "S" }
            KeyButton { operation: "D" }
            KeyButton { operation: "F" }
            KeyButton { operation: "G" }
            KeyButton { operation: "H" }
            KeyButton { operation: "J" }
            KeyButton { operation: "K" }
            KeyButton { operation: "L" }
            KeyButton { operation: "" }
            KeyButton { operation: "" }
            KeyButton { operation: "Clear"; width: 68; }

            KeyButton { operation: "Z" }
            KeyButton { operation: "X" }
            KeyButton { operation: "C" }
            KeyButton { operation: "V" }
            KeyButton { operation: "B" }
            KeyButton { operation: "N" }
            KeyButton { operation: "M" }
            KeyButton { operation: "," }
            KeyButton { operation: "." }
            KeyButton { operation: "-" }
        }
        // Space key
        KeyButton {
            anchors.horizontalCenter: numKeypad.horizontalCenter
            width: 270
            operation: "Space"
        }
    }

    DigitalClock {
        id: digitalClock
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
    }
}
