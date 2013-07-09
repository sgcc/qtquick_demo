/****************************************************************************
**
** This file is part of RadioTuner
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

var middleRange = 11;
var startRange = 860;
var finalRange = 1050;
var stations = [];
var currentStation = 0;


function createModel(stationsModel, listModelExample)
{
    //var component = Qt.createComponent("RadioModel.qml");
    //var model = component.createObject(root);

    var model = listModelExample;

    var stationNames = [];
    for (var i = 0; i < stationsModel.count; i++) {
        var item = stationsModel.get(i);
        stationNames[item.dial] = item.name;
    }

    var k = 0;
    for (var i = startRange; i <= finalRange; i++, k++) {
        var range = i / 10.0;
        var kind = ((i % 10 == 0) ? "high" : (i % 5 == 0) ? "medium" : "low");

        if (range in stationNames) {
            var station = new Object();
            station.index = k;
            station.centerIndex = k - middleRange;
            station.dial = range;
            station.name = stationNames[range];
            stations.push(station);

            model.append({stationRange: range, kind: kind, station: station.dial, stationName: station.name});
        } else {
            model.append({stationRange: range, kind: kind, station: -1, stationName: ""});
        }
    }

    return model;
}

function getStation(index)
{
    return stations[index];
}

function getCenterIndex(currentIndex)
{
    return currentIndex + middleRange;
}

function getNextStation(radiosList)
{
    var model = radiosList.model;
    var currentIndex = getCenterIndex(radiosList.currentIndex);

    var total = model.count;
    for (var i = currentIndex; i < total; i++) {
        if (i != currentIndex && model.get(i).station >= 0)
            return i - middleRange;
    }

    return -1;
}

function getPreviousStation(radiosList)
{
    var model = radiosList.model;
    var currentIndex = getCenterIndex(radiosList.currentIndex);

    for (var i = currentIndex; i >= 0; i--) {
        if (i != currentIndex && model.get(i).station >= 0)
            return i - middleRange;
    }

    return -1;
}
