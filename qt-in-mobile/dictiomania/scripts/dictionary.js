/*
 This file is part of Dictiomania

 Copyright (c) 2010 Movial Creative Technologies Inc. and Nokia Corporation
 and/or its subsidiary(-ies).

 All rights reserved.

 Contact: Movial Creative Technologies Inc. (info@movial.com) or
 Qt Development Frameworks Information (qt-info@nokia.com)

 You may use this file under the terms of the BSD license as follows:

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
     * Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
     * Neither the name of the Movial Creative Technologies Inc. nor Nokia
       Corporation and its Subsidiary(-ies) or the names of its contributors
       may be used to endorse or promote products derived from this software
       without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
var dictionaryFolder = "dicts/";
var dictionaryExtension = ".json";
var data = null;
var count = 0;
var httpRequest = null;

/*
    Load dictionary file for selected language to learn (languageToLearn) and level (level)
*/
function load (ownLanguage, languageToLearn, level) {
    var fileName = dictionaryFolder + languageToLearn.toUpperCase() +
                    "_" + ownLanguage.toUpperCase() + "_" + level + dictionaryExtension;

    data = {
        "capable": "able",
        "au-dessus": "about",
        "accueillir": "accept",
        "douleur": "ache",
        "acte": "act",
        "en fait": "actually",
    };

    count = 0;
    for (var p in data) {
        count++;
    }

    httpRequest = new XMLHttpRequest()
    httpRequest.onreadystatechange = dictionaryLoaded;
    httpRequest.open("GET", fileName);
    httpRequest.send();
}

/*
    Parse dictionary json to the dictionary object data
*/
function dictionaryLoaded () {
    if (httpRequest.readyState == XMLHttpRequest.DONE) {
        data = eval('(' + httpRequest.responseText + ')');
        count = 0;
        for (var p in data) {
            count++;
        }
    }    
}

/*
    Return 4 random words from the dictionary. These are used in the gameplay view as options.
*/
function getRandomWords() {
    var howManyWords = 4;
    var wordIndexes = [];
    var i = 0;
    var maxIterations = 50000;

    //sanity check :)
    if (howManyWords <= count) {
        while (i < howManyWords && maxIterations != 0) {
            var value = Math.ceil(Math.random() * (count - 1));
            if (wordIndexes.indexOf(value) == -1) {
                wordIndexes[i] = value;
                i++
            }
            maxIterations--;
        }
    }

    var validWord = wordIndexes[ Math.ceil(Math.random() * (howManyWords - 1)) ];
    var currentWordIndex = 0;
    var wordToTranslate = "";
    var words = [];
    var index;

    for(var word in data ) {
        if( (index = wordIndexes.indexOf(currentWordIndex)) != -1 ) {
            words.push({
                word: data[word],
                good: currentWordIndex == validWord ? true : false
            });

            if(currentWordIndex == validWord) {
                wordToTranslate = word;
            }

            wordIndexes = wordIndexes.filter(function(el, x, a) {
                return x != index;
            }, null );
        }

        if(wordIndexes.length == 0) {
            break;
        }
        currentWordIndex++;
    }

    return {
        word : wordToTranslate,
        options : words,
    };
}

