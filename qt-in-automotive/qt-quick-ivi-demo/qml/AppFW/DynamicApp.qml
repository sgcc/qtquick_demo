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

// A base component for applications
Item {
    id: dynamicApp

    // By default, an application uses the toolbar.
    // This can be changed in inherited components
    property bool useToolbar: true
    property bool inFullscreen: appHolder.state == "fullscreen"
    // Toolbar event handler
    property variant toolbarHandler

    signal setFullscreen(bool useFs)
    signal transparentControls(bool transparent)
    signal setToolbarModel(variant model)
    signal activateToolbarButton(int btn)
    signal setToolbarButton(int index, variant btnDef)
    // Signals that application state needs to be refreshed
    signal refresh
    signal changeApp(string appName)
    signal appDataChanged(string appName, variant data)

    width: appHolder.width
    height: useToolbar ? appHolder.height: appHolder.height + toolbar.height

    onSetFullscreen: useFs ? appHolder.state = "fullscreen" : appHolder.state = ""
    onTransparentControls: appFw.transparentControls = transparent
    onSetToolbarModel: toolbar.model = model
    // When refreshing, reset the toolbar visibility state
    onRefresh: toolbar.visible = useToolbar
    onActivateToolbarButton: toolbar.activateButton(btn)
    onSetToolbarButton: toolbar.model.set(index, btnDef)
    onChangeApp: appFw.changeApp(appName)
    onAppDataChanged: appFw.appDataChanged(appName, data)

    // Handle toolbar events. Handling is propagated
    // to to the toolbarHandler component
    Connections {
        // Set the target property only when the application
        // is in the active state. This prevents several
        // applications receiving toolbar events
        target: activeApp ? toolbar: null
        onBtnClicked: toolbarHandler.handleToolbarEvent(event)
    }
}
