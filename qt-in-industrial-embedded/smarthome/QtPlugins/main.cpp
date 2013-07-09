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

#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QFontDatabase>

#include "TimeAndDate.h"
#include "svgimage.h"

//
// uncomment this when building statically
//
//#include "F:\Qt\qt-4.7.0-beta2\src\imports\particles\qdeclarativeparticles_p.h"
//#include "/home/thip/my_space/local/qt/qt-everywhere-opensource-src-4.7.0-beta2/src/imports/particles/qdeclarativeparticles_p.h"

#include <QtPlugin>

//
// uncomment this when building statically
//
//Q_IMPORT_PLUGIN(qsvg)

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    if ( argc > 2 )
    {
            const char* fontName = argv[ 2 ];

            if ( QFontDatabase::addApplicationFont( fontName ) == -1 )
                    qDebug("could not load font: %s", fontName );
    }

    QDeclarativeView view;
    QDeclarativeContext *context = view.rootContext();
    context->setContextProperty("backgroundColor",
                                QColor(Qt::yellow));

    //const char* uri =":/components";
    const char* uri ="SmartHomeEx";

    qmlRegisterType<SvgImage>(uri, 1, 0, "SvgImage");

    //
    // uncomment this when building statically
    //
//        qmlRegisterType<QDeclarativeParticleMotion>(uri,1,0,"ParticleMotion");
//        qmlRegisterType<QDeclarativeParticleMotionGravity>(uri,1,0,"ParticleMotionGravity");
//        qmlRegisterType<QDeclarativeParticleMotionLinear>(uri,1,0,"ParticleMotionLinear");
//        qmlRegisterType<QDeclarativeParticleMotionWander>(uri,1,0,"ParticleMotionWander");
//    qmlRegisterType<QDeclarativeParticles>(uri,1,0,"Particles");

    view.engine()->addImportPath(".");
    view.engine()->addImportPath("models");

    view.setSource(QUrl("qrc:/smarthome.qml"));

    view.show();

    return app.exec();
}
