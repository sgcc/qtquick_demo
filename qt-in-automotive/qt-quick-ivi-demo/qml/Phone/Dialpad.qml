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
    id: dialpad

    // Properties defining button dimensions and spacing
    property int buttonWidth: 55
    property int buttonHeight: 35
    property int spacing: 5
    property int numEntrySize: 16
    property alias dialnumber: maintext.text

    // Signals observers that calling has ended
    signal callEnded

    // Functions for adding and removing numbers
    // from the number entry
    function addNum(buttontext) {
        maintext.text += buttontext;
    }
    function delNum() {
        var len = maintext.text.length;
        if (len)
           maintext.text = maintext.text.substring(0, len-1);
    }

    Rectangle {
        id: background
        color: "black"
        border.color: "#f9a82e"
        border.width: 2
        anchors.fill: parent
        radius: 30
        opacity: 0.9
    }

    // Center dial buttons into center of the screen by
    // grouping them within Item
    Item {
        id: dialButtons

        anchors.centerIn: background
        width: topButtons.width
        height: topButtons.height + numpad.height

        // Add the number entry field and backspace button
        Row {
            id: topButtons
            spacing: dialpad.spacing

            Rectangle {
                id: maintextContainer
                radius: 5
                width: buttonWidth*3+dialpad.spacing*2
                height: buttonHeight
                Text {
                    id: maintext
                    x: 10
                    font.pixelSize: numEntrySize
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Button {
                id: backbutton
                width: buttonWidth
                height: buttonHeight
                buttontext: ""
                onClicked: delNum()

                // Use custom image (not text) for the backspace button
                Image {
                    anchors.centerIn: parent
                    source: "../images/icons/icon_backspace.png"
                }
            }
        }

        // Grid of numeric buttons
        Grid {
            id: numpad
            anchors.top: topButtons.bottom
            anchors.topMargin: spacing
            spacing: 5
            columns: 3
            Button { buttontext: "1"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
            Button { buttontext: "2"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
            Button { buttontext: "3"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
            Button { buttontext: "4"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
            Button { buttontext: "5"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
            Button { buttontext: "6"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
            Button { buttontext: "7"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
            Button { buttontext: "8"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
            Button { buttontext: "9"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
            Button { buttontext: "*"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
            Button { buttontext: "0"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
            Button { buttontext: "#"; width: buttonWidth; height: buttonHeight;
                onClicked: addNum(buttontext) }
        }

        // Button for blinking 'calling' button
        // The button is translated to right when
        // calling starts
        DialButton {
            id: callStatus
            width: buttonWidth
            height: 3*buttonHeight + 2*spacing
            anchors.top: numpad.top
            x: numpad.x + numpad.width + spacing
            buttontext: "..."
            iconImage: "../images/icons/icon_phone_green.png"
        }

        // Button for starting calling procedure.
        // The button is located over the call status button
        DialButton {
            id: callButton
            width: callStatus.width
            anchors.top: callStatus.top
            anchors.bottom: callStatus.bottom
            anchors.left: numpad.right
            anchors.leftMargin: spacing
            buttontext: "Call"
            iconImage: "../images/icons/icon_phone_green.png"
            onClicked: {
                // When clicking the button,
                // calling is started or dropped
                if (dialpad.state=="")
                    dialpad.state = "calling";
                else {
                    dialpad.state="";
                    dialpad.callEnded();
                }
            }
        }
    }

    // Defines a state for calling. In essence,
    // it means translating the call status icon to right
    // and start blinking it. Also the call icon
    // is changed to red 'Cancel' icon
    states:
        State {
            name: "calling"
            changes: [
                PropertyChanges {
                    target: callButton
                    buttontext: "Cancel"
                    iconImage: "../images/icons/icon_phone_red.png"
                },
                PropertyChanges {
                    target: callStatus
                    x: callButton.x + callButton.width + spacing
                },
                PropertyChanges {
                    target: callStatus
                    blink: true
                }
            ]
        }

    transitions:
        Transition {
            NumberAnimation {properties: "x"; duration: 200 }
        }
}
