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

// ScrollIndicator displays a vertical scroll indicator
// with a knob that dislays the relative positin in
// the scrollable area.
// By rotating the component 90 degrees, it can
// be used also as horizontal scroll indicator
Item {
    id: scrollInd

    property real position: 0.5
    property real zoom: 0.5
    // Specifies whether the scroll indicator is shown
    property bool shown: false

    // Return the y position of the knob in
    // ScrollIndicator coordinate system
    function getY(position) {
        if (zoom == 1 || position < 0)
            return 0;
        else if (position > 1-zoom)
            return scrollInd.height-scroll_knob.height;
        else
            return position / (1-zoom) *(scrollInd.height - scroll_knob.height);
    }

    width: scroll_knob.width

    // Background area
    Rectangle {
        id: scroll_bar

        y: scroll_knob.height / 2
        x: scroll_knob.width / 2 - width /2
        color: "black"
        border.color:"white"
        border.width: 2
        width: 6
        height: parent.height - scroll_knob.height
        radius: 2
        opacity: 0
    }

    // Knob that displays the relative position
    Image {
        id: scroll_knob

        source: "../images/scroll_indicator.png"
        y: getY(position)
        opacity: 0
    }

    // ScrollIndicator has 'shown' state in addition
    // to the default state (when the component is invisible
    states:
        State {
            name: "shown"
            when: shown
            PropertyChanges{ target: scroll_knob; opacity: 1 }
            PropertyChanges{ target: scroll_bar; opacity: 0.2 }
        }

    transitions:
        Transition {
            NumberAnimation{ properties: "opacity"; easing.type: "InOutQuad"; duration: 400 }
        }
}
