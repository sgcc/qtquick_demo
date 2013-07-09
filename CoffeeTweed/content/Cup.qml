/****************************************************************************
**
** This file is part of CoffeeTweed
**
** Copyright (c) 2010 Nokia Corporation and/or its subsidiary(-ies).*
** All rights reserved.
** Contact:  Nokia Corporation (qt-info@nokia.com)
**
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions
** are met:
**
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in the
**     documentation and/or other materials provided with the distribution.
**
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
**  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
**  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
**  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
**  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
**  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
**  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
**  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
**  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
**  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
**  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
**  POSSIBILITY OF SUCH DAMAGE."
**
****************************************************************************/

import Qt 4.7

Item {
    id: coffee_cup
    property bool isAnimating: coffee_cup.state == "less_one"
    width: 190 * root.scaleFactor
    height: 480 * root.scaleFactor

    function return_to_ashes() {
        coffee_cup.state = "";
    }

    Image {
        id: cup_plate
        y: 315 * root.scaleFactor
        x: 40 * root.scaleFactor
        source: folder + "coffee_plate.png"
    }

    Image {
        id: cup_full
        x: 47 * root.scaleFactor
        y: 225 * root.scaleFactor
        source: folder + "cup_back.png"

        Image { id: cup_content; source: folder + "cup_content.png"; }
        Image { id: cup_front; source: folder + "cup_front.png"; }
    }

    Image {
        id: cup_empty
        x: 47 * root.scaleFactor
        y: 225 * root.scaleFactor
        opacity: 0
        source: folder + "cup_empty.png"
    }

    Image {
        id: cup_smoke
        x: 33 * root.scaleFactor
        y: -10 * root.scaleFactor
        source: folder + "cup_smoke.png"
    }

    Image {
        id: cup_running
        x: 47 * root.scaleFactor
        y: -283 * root.scaleFactor
        opacity: 0
        source: folder + "cup_blur.png"
    }

    states: [
        State{
            name: "less_one"
        }
    ]

    transitions: [
        Transition {
            from: ""; to: "less_one"

            SequentialAnimation {
                // Empty the cup and fade the smoke
                ParallelAnimation {
                    PropertyAnimation { target: cup_smoke; property: "opacity"; to: 0; duration: 500; }
                    PropertyAnimation { target: cup_content; property: "y"; to: 20 * root.scaleFactor; duration: 500; }
                }

                // Change the full cup composition by the empty cup
                    PropertyAction { target: cup_empty; property: "opacity"; value: 1 }
                    PropertyAction { target: cup_full; property: "opacity"; value: 0; }

                // Pause for coffee
                PauseAnimation { duration: 100; }

                // Fade out the empty cup
                PropertyAnimation { target: cup_empty; property: "opacity"; to: 0; duration: 200; }

                // Send the empty cup to the top and update the number
                    PropertyAction { target: cup_empty; property: "y"; value: -243 * root.scaleFactor; }

                // Turn on the blur and empty cups
                    PropertyAction { target: cup_running; property: "opacity"; value: 1; }
                    PropertyAction { target: cup_empty; property: "opacity"; value: 1; }

                // Clean cup coming!
                ParallelAnimation {
                    PropertyAnimation { target: cup_running; property: "y"; to: 180 * root.scaleFactor; duration: 300; }
                    PropertyAnimation { target: cup_empty; property: "y"; to: 230 * root.scaleFactor; duration: 300; }
                }

                // Landing in the plate
                ParallelAnimation {
                    PropertyAnimation { target: cup_empty; property: "y"; to: 225 * root.scaleFactor; duration: 150; }
                    PropertyAnimation { target: cup_running; property: "opacity"; to: 0; duration: 200; }
                }

                // Get the blured cup to the original place
                    PropertyAction { target: cup_running; property: "y"; value: -283 * root.scaleFactor; }

                // Wait for the waiter
                PauseAnimation { duration: 500; }

                // Change the empty cup by the full cup composition
                    PropertyAction { target: cup_full; property: "opacity"; value: 1; }
                    PropertyAction { target: cup_empty; property: "opacity"; value: 0; }

                // Here is your coffee, sir
                PropertyAnimation { target: cup_content; property: "y"; to: 0; duration: 400; }
                PropertyAnimation { target: cup_smoke; property: "opacity"; to: 1; duration: 700; }

                // Ready for the next turn
                ScriptAction { script: return_to_ashes() }
            }
        }
    ]
}
