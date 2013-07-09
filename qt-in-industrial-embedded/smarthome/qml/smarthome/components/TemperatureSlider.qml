/** This file is part of Home Control Qt Quick Embedded Widgets Demo**
 *
 * Copyright © 2010 Nokia Corporation and/or its subsidiary(-ies).*
 * All rights reserved.
 *
 * Contact:  Nokia Corporation (qt-info@nokia.com)
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * “Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor the
 * names of its contributors may be used to endorse or promote products
 * derived from this software without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.”
 */

import Qt 4.7
import SmartHomeEx 1.0

/**
* This TemperatureSlider is a custom item for temperature settings.
* The TemperatureSlider has per default one user temperature and one current temperature.
* A second user temperature is invisible per default.
*/
Rectangle {
    id: temperatureSlider

    property real firstTemperature: 0
    property real secondTemperature: 0
    property real actualTemperature: 21
    property alias handleIconSource: handleIcon.source
    property alias secondHandleVisible: secondHandle.visible
    property alias secondHandleIconSource: secondHandleIcon.source

    width: background.width+20
    height: background.height+3
    color: "transparent"

    /**
    * This item encapsulate a value that should not be changed unwise.
    */
    Item {
        id: privateItem

        property real valuePerPixel: scaleLeft.height / ((scaleLeft.scaleModel.length - 1)  * scaleLeft.lineCount)
        property int lowestDegree: parseInt(scaleLeft.scaleModel[0])
    }

    Item {
        anchors {
            top: temperatureSlider.top
            topMargin: 3
        }

        /**
        * Draws the background without filling
        */
        Image {
            id: background
            smooth: false
            source: "pics/temperature/temperature_background.svg"

            TemperatureScale {
                id: scaleLeft
                anchors.top: parent.top
                anchors.topMargin: 37
                height: 206
                anchors.left: parent.left
                anchors.leftMargin: 4
            }

            TemperatureScale {
                id: scaleRight
                height: 206
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 97
                anchors.right: parent.right
                anchors.rightMargin: 7
                enableText: false
                transform: Rotation {
                    origin.x: scaleRight.width/2
                    origin.y: scaleRight.height/2
                    angle: 180
                }
            }

        }
        /**
        * SvgImage is a custom item for using special features of a Svg Image.
        * It comes with a c++ qtplugin.
        * Here it draws the filling.
        */
        SvgImage {
            id: fill
            source: "pics/temperature/temperature_fill.svg"
        }
        /**
        * A nice reflex is overlayed
        */
        Image {
            id: reflex
            source: "pics/temperature/temperature_reflex.svg"
        }
        /**
        * This Image item draws the handle that can be dragged
        */
        Image {
            id: handle

            property int spacing: 18

            x: background.width - handle.width + spacing
            source: "pics/temperature/handle.png"

            Image {
                id: handleIcon
                x: spacing
                y: 2
                width: parent.height-4
                height: parent.height-4
            }

            MouseArea {
                id: handleMouseArea
                anchors.fill: parent
                drag { target: parent; axis: Drag.YAxis; minimumY: 25; maximumY: 231 }

                onPositionChanged: {
                    firstTemperature = ((drag.maximumY - parent.y) / privateItem.valuePerPixel) + privateItem.lowestDegree
                    if ( !secondHandle.visible )
                        fill.startY = ((firstTemperature - privateItem.lowestDegree) * privateItem.valuePerPixel - drag.maximumY + privateItem.lowestDegree) * -1
                }

            }
        }

        /**
        * This Image item draws the second handle that can be dragged
        */
        Image {
            id: secondHandle
            x: background.width - handle.width + 18
            source: "pics/temperature/handle.png"
            visible: false

            Image {
                id: secondHandleIcon
                x: 18
                y: 2
                width: parent.height-4
                height: parent.height-4
            }

            MouseArea {
                enabled: visible ? true : false
                anchors.fill: parent
                drag { target: parent; axis: Drag.YAxis; minimumY: 25; maximumY: 231 }

                onPositionChanged: {
                    secondTemperature = ((drag.maximumY - parent.y) / privateItem.valuePerPixel) + privateItem.lowestDegree
                }

            }
        }

        Rectangle {
            id: needle
            width: parent.width
            height: 2
            color: Qt.rgba( 0.3,0.3,0.3,0.5 )
        }
    }

    // some values has to be initialized after the component is loaded
    Component.onCompleted: {
        handle.y = ((firstTemperature - privateItem.lowestDegree) * privateItem.valuePerPixel - handleMouseArea.drag.maximumY) * -1
        secondHandle.y = ((secondTemperature - privateItem.lowestDegree) * privateItem.valuePerPixel - handleMouseArea.drag.maximumY) * -1
        firstTemperature = ((handleMouseArea.drag.maximumY - handle.y) / privateItem.valuePerPixel) + privateItem.lowestDegree
        if ( !secondHandle.visible )
            fill.startY = ((firstTemperature - privateItem.lowestDegree) * privateItem.valuePerPixel - handleMouseArea.drag.maximumY + privateItem.lowestDegree) * -1
    }

    // the needle is moved along the y axis when the current temp is changed
    onActualTemperatureChanged: {
        needle.y = ((actualTemperature - privateItem.lowestDegree) * privateItem.valuePerPixel - handleMouseArea.drag.maximumY + privateItem.lowestDegree) * -1
    }
}
