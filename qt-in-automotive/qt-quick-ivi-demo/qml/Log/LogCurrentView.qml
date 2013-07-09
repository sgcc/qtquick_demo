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

// Contains components related to recording
// of a new log in the Log application.
Item {
    id: currentLog

    property int rowHeight: 34
    property int log_ecoindex : 3
    // Information of the current log that is exported
    // outside the Log application
    property alias log_title : logName.input
    property alias log_starttime : starttimeInput.timestring
    property alias log_triptype : triptypeSelection.currType
    property alias log_triplength : triplengthText.text
    property alias log_endtime : stoptimeInput.timestring

    Rectangle {
        id: background
        color: "black"
        width:currentLog.width
        height:  currentLog.height
        radius: 15
        opacity: 0.7
    }

    // Data fields of the current log are arranged
    // in a column. Last data fields are statif c
    // and their visibility depends whether the
    // loggins on/off (managed by the opacity attribute)
    Column {
        id: logList

        anchors.top : parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.topMargin: 15
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        spacing: 5

        // Name of the log
        LabelInputBox {
            id: logName
            width: parent.width
            height: rowHeight
            label: "Log name"
            helpText: "Enter log title"
        }

        // Starting location for logging
        LabelInputBox {
            id: from
            width: parent.width
            height: rowHeight
            label: "From"
            helpText: "Enter start location"
        }

        // Destination where the user is going
        LabelInputBox {
            id: to
            width: parent.width
            height: rowHeight
            label: "To"
            helpText: "Enter destination"
        }

        // Number of passengers field
        Item {
            width: parent.width
            height: currentLog.rowHeight

            Label {
                id: passLabel
               text: "Passengers"
            }

            PersonOMeter {
                anchors.left: passLabel.right
            }

            SelectBox {
                id: triptypeSelection
                anchors.right: parent.right
                anchors.rightMargin:5
                textsize: 18
            }
        }

        // Start time of logging. Visible only
        // when logging has started
        Row {
            id: startTimeItem
            anchors.left: parent.left
            anchors.right: parent.right
            height: currentLog.rowHeight
            opacity: 0

            Label {
                id: startLabel
                text: "Start time"
            }

            DateTimeInput {
                id: starttimeInput
                width: startTimeItem.width - startLabel.width
            }
        }

        // Eco index and and trip length. Displayed
        // after logging has ended
        Row{
            id: ecoEtc
            anchors.left: parent.left
            anchors.right: parent.right
            height: currentLog.rowHeight
            opacity: 0

            Label {
                id: ecoLabel
                text: "Eco index"
            }

            EcoIndexMeter {
                anchors.verticalCenter: parent.verticalCenter
                ecoindexvalue: log_ecoindex
            }

            Label {
                id: triplengthText
                text: "130.5 km"
                anchors.verticalCenter: parent.verticalCenter
                x: ecoEtc.x + ecoEtc.width - triplengthText.width
            }
        }

        // Stopping time of logging. Displayed
        // after logging has ended
        Row {
            id: stopTimeItem
            anchors.left: parent.left
            anchors.right: parent.right
            height: currentLog.rowHeight
            opacity: 0

            Label {
                id: stopLabel
                text: "Stop time"
            }

            DateTimeInput {
                id: stoptimeInput
                width: stopTimeItem.width - stopLabel.width
            }
        }
    }

    // Current log view has two states. In the 'started' state
    // the start time of the logging is displayed. When entering
    // the 'stopped' state, eco index data and stopped time
    // are also displayed.
    // In the default state, the log information is not visible.
    // Rather, the 'NEW' button is flashing, indicating
    // a recording of a new log can be started
    states: [
        State {
            name: "started"
            PropertyChanges {target: startTimeItem; opacity: 1 }
            // Update current time to the start time field
            StateChangeScript {
                name: 'timeUpdate'
                script: starttimeInput.showCurrentTime()
            }
        },

        State {
            name: "stopped"
            PropertyChanges {target: startTimeItem; opacity: 1 }
            PropertyChanges {target: ecoEtc; opacity: 1 }
            PropertyChanges {target: stopTimeItem; opacity: 1 }
            // Update current time to the stop time field
            StateChangeScript {
                name: 'timeUpdate'
                script: stoptimeInput.showCurrentTime()
            }
        }
    ]

    transitions:
        Transition {
            NumberAnimation { properties: "opacity"; duration: 200 }
        }
}
