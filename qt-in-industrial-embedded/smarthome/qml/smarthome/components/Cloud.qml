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
/*
 * To run the dynamically linked version uncomment the following line
 */
import Qt.labs.particles 1.0

/*
 * The Cloud component encalsulates the visuals for a cloud and all the effects like rain and snow.
 * It exposes a lot of internal properties to let other components customize the look of this
 * component.
 * It uses a special element called "SvgImage". This element is not part of the standard QML elements
 * but is implemented in C++ and made available to QML through a plugin.
 * It provides a special feature: It is now possible to directly alter elements inside an SVG
 * graphics element to change it's look at runtime. This is demonstrated in the cloud component
 * by changing two colors inside the SVG graphic.
 *
 * Properties:
 * color color1:    The inner color of the cloud
 * color color2:    The outer color of the cloud
 * Changing these properties will directly change the corresponding SVG elements. The change is
 * animated to make the transition look smooth.
 *
 * bool rain:               If true, enables rain
 * bool flash:              If true, enables a periodical flash animation
 * bool wind:               If true, enables periodical slow movement of the cloud
 * bool storm:              If true, enables a faster "storm like" animation of the cloud
 * real cloudSpeed:         A factor to set the speed of the cloud animation (>1 faster, <1 slower)
 *
 * int particleCount:               The maximum number of particles (snow flakes, rain drops)
 * string particleSource:           The file name of the particles graphics
 * real particleAngle:              The emission angle of the particles
 * real particleAngleDeviation:     The variance of the emission angle
 * int particleEmissionRate:        The rate at which the particles are emitted (particles/sec.)
 * real particleEmissionVariance:   The variance of the emission rate
 * int particleFadeInDuration:      The fade in duration
 * int particleFadeOutDuration:     The fade out duration
 * int particleLifeSpan:            The life span of a particle in milliseconds
 * int particleLifeSpanDeviation:   The variance of the life span
 * real particleVelocity:           The velocity of the particles
 * real particleVelocityDeviation:  The variance of the velocity
 *
 * real xStart:     The start x coordinate of the storm animation
 * real xStart:     The start x coordinate of the storm animation
 */
SvgImage {
    id: cloud
    x: -57
    y: 14
    width: 267
    height: 157
    property color color1: "#74c4fd"
    property color color2: "#3690d1"

    /*
     * These properties are bound to the respective properties of the internal components
     * Changing these properties implicitly changes the bound properties, with all corresponding
     * side effects (like animations starting/stopping)
     */
    property alias rain: rainAnimation.running
    property alias flash: flashTimer.running
    property alias wind: cloudAnimation.running
    property alias storm: cloudAnimation2.running
    property real cloudSpeed: 1.5


    property alias particleCount: particles.count
    property alias particleSource: particles.source
    property alias particleAngle: particles.angle
    property alias particleAngleDeviation: particles.angleDeviation
    property alias particleEmissionRate: particles.emissionRate
    property alias particleEmissionVariance: particles.emissionVariance
    property alias particleFadeInDuration: particles.fadeInDuration
    property alias particleFadeOutDuration: particles.fadeOutDuration
    property alias particleLifeSpan: particles.lifeSpan
    property alias particleLifeSpanDeviation: particles.lifeSpanDeviation
    property alias particleVelocity: particles.velocity
    property alias particleVelocityDeviation: particles.velocityDeviation

    property real xStart: -200
    property real xEnd: 800

    /*
     * Here comes the "changing-svg-elements-on-the-fly-magic"
     * The SvgImage element exposes a function called modify. It works like this
     * modify( <name of svg element type>, <id of the element>
     *         <name of the attribute to modify>, <new value>)
     */
    onColor1Changed: {
        var newValue = "stop-color:"+color1+";stop-opacity:1"
        /*
         * Here the attribute "style" of the SVG element "stop" with id "stop3667"
         * is modified to contain the value of newValue
         */
        cloud.modify("stop","stop3667","style",newValue)
    }
    onColor2Changed: {
        var newValue = "stop-color:"+color2+";stop-opacity:1"
        cloud.modify("stop","stop3669","style",newValue)
    }

    source: "pics/weather/cloud2.svg"

    /*
     * The particle system used for rain and snow
     */
    Particles {
        id: particles
        angle: 95
        angleDeviation: 0
        count: 0
        emissionRate: 7
        emissionVariance: 3
        fadeInDuration: 100
        fadeOutDuration: 10
        lifeSpan: 600
        lifeSpanDeviation: 0
        velocity: 100
        velocityDeviation: 0
        x: 50
        y: 90
        z: -2

    }

    /*
     * Here two flash images are instantiated
     */
    Image {
        id: flash1
        x: 110
        y: cloud.height - 80
        z: -2
        width: 20
        height: 100
        source: "pics/particle/flash-01.png"
        opacity: 0
    }

    Image {
        id: flash2
        x: 90
        y: cloud.height - 110
        z: -2
        width: 20
        height: 180
        source: "pics/particle/flash-01.png"
        opacity: 0
    }

    /*
     * When the flashTimer is started, a periodic flash animation is played
     */
    Timer {
        id: flashTimer
        interval: 2000
        repeat: true
        onTriggered:  flashAnimation.start()
        onRunningChanged: {
            if ( !running ) {
                flash1.opacity = 0
                flash2.opacity = 0
            }
        }
    }

    /*
     * All changes to the color1 or color2 properties should be animated to look smooth
     */
    Behavior on color1 {
        ColorAnimation { duration: 3000 }
    }

    Behavior on color2 {
        ColorAnimation { duration: 3000 }
    }

    SequentialAnimation {
        id: flashAnimation
        running: false

        NumberAnimation {
            from: 0; to: 1
            targets: [flash1,flash2]
            property: "opacity"
            duration: 50
        }

        NumberAnimation {
            from: 1; to: 0
            targets: [flash1,flash2]
            property: "opacity"
            duration: 100
        }

        NumberAnimation {
            from: 0; to: 1
            targets: [flash1,flash2]
            property: "opacity"
            duration: 70
        }

        NumberAnimation {
            from: 1; to: 0
            targets: [flash1,flash2]
            property: "opacity"
            duration: 90
        }
    }

    SequentialAnimation {
        id: rainAnimation
        loops: Animation.Infinite
        NumberAnimation { target: particles; property: "x"; to: 190; duration: 100 }
        NumberAnimation { target: particles; property: "x"; to: 40; duration: 100 }
    }

    /*
     * The cloud animation (gentle breeze)
     */
    SequentialAnimation {
        id: cloudAnimation
        loops: Animation.Infinite
        NumberAnimation { target: cloud; property: "x"; to: 8;
            duration: 4000 / cloud.cloudSpeed; }
        NumberAnimation { target: cloud; property: "x"; to: -13;
            duration: 5000 / cloud.cloudSpeed;}
    }

    /*
     * The storm animation
     */
    NumberAnimation {
        id: cloudAnimation2
        running: false
        loops: Animation.Infinite
        target: cloud
        property: "x"
        from:       cloud.xStart
        to:         cloud.xEnd
        duration: 4000 / cloud.cloudSpeed
    }
}
