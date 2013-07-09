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

// Contact book information. Each contact
// has 'attributes' property that contains
// a variable length list of contact information elements
ListModel {
    ListElement {
        contactname: "Ellie Jones"
        primaryNumber: "+356 40 0629926"
        contactImageSource: "../dummydata/content/faces/contact_photo_ellie.jpg"
        attributes: [
           ListElement {
               description: "mobile"
               value: "+356400629926"
               actionIcon: "../images/icons/icon_phone_green.png"
           },
           ListElement {
               description: "work mobile"
               value: "+35650123456"
               actionIcon: "../images/icons/icon_phone_green.png"
           },
           ListElement {
               description: "address"
               value: "Piippukatu 1"
               actionIcon: "../images/icons/icon_locate.png"
           },
           ListElement {
               description: "facebook status"
               value: "is going home"
               actionIcon: ""
           }
        ]
    }
    ListElement {
       contactname: "John Johnson"
       primaryNumber: "+356 40 0629926"
       contactImageSource: "../dummydata/content/faces/contact_photo_john.jpg"
       attributes: [
           ListElement {
               description: "mobile"
               value: "+356400629926"
               actionIcon: "../images/icons/icon_phone_green.png"
           },
           ListElement {
               description: "address"
               value: "Piippukatu 1"
               actionIcon: "../images/icons/icon_locate.png"
           },
           ListElement {
               description: "other address"
               value: "Piippukatu 1"
               actionIcon: "../images/icons/icon_locate.png"
           },
           ListElement {
               description: "facebook status"
               value: "is working hard"
               actionIcon: ""
           }
       ]
    }
    ListElement {
        contactname: "Julia Williams"
        primaryNumber: "+356 40 0629926"
        contactImageSource: "../dummydata/content/faces/contact_photo_julia.jpg"
        attributes: [
            ListElement {
                description: "mobile"
                value: "+356400629926"
                actionIcon: "../images/icons/icon_phone_green.png"
            },
            ListElement {
                description: "address"
                value: "Piippukatu 1"
                actionIcon: "../images/icons/icon_locate.png"
            },
            ListElement {
                description: "facebook status"
                value: "Still going strong"
                actionIcon: ""
            }
        ]
    }
    ListElement {
        contactname: "Lucas Schmidt"
        primaryNumber: "+356 60 9876543"
        contactImageSource: "../dummydata/content/faces/contact_photo_jurgen.jpg"
        attributes: [
            ListElement {
                description: "mobile"
                value: "+356400629926"
                actionIcon: "../images/icons/icon_phone_green.png"
            },
            ListElement {
                description: "address"
                value: "Piippukatu 1"
                actionIcon: "../images/icons/icon_locate.png"
            },
            ListElement {
                description: "facebook status"
                value: "yeeehaa"
                actionIcon: ""
            }
        ]
    }
    ListElement {
        contactname: "Antonio Blanco"
        primaryNumber: "+356 40 0629926"
        contactImageSource: "../dummydata/content/faces/Face_man1.jpg"
        attributes: [
            ListElement {
                description: "mobile"
                value: "+356400629926"
                actionIcon: "../images/icons/icon_phone_green.png"
            },
            ListElement {
                description: "address"
                value: "Piippukatu 1"
                actionIcon: "../images/icons/icon_locate.png"
            },
            ListElement {
                description: "facebook status"
                value: "Still going strong"
                actionIcon: ""
            }
        ]
    }
}
