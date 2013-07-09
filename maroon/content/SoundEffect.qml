/****************************************************************************
**
**
****************************************************************************/

import QtQuick 2.0
//Proxies a SoundEffect if QtMultimedia is installed
Item {
    id: container
    property QtObject effect: Qt.createQmlObject("import QtMultimedia 5.0; SoundEffect{ source: '"
                                                   + container.source
                                                   + "' }",
                                                   container
                                                 );
    property url source: ""
    onSourceChanged: if (effect != null) effect.source = source;
    function play() {
        if (effect != null)
            effect.play();
    }

}
