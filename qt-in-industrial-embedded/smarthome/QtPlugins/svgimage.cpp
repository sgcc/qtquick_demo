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

#include "svgimage.h"
#include <QtSvg/QSvgRenderer>
#include <QFile>
#include <QPainter>
#include <QDomNodeList>

#include <QDeclarativeContext>
#include <QDeclarativeEngine>

#include <QFileInfo>

SvgImage::SvgImage(QDeclarativeItem *parent) :
    QDeclarativeItem(parent), m_pixmap(64,64),m_renderer( NULL ),
    m_startX(-1), m_startY(-1), m_endX(-1), m_endY(-1), m_updateNeeded( false )
    ,m_resizePixmap( false )
{
    setFlag( QGraphicsItem::ItemHasNoContents, false );
    m_renderer = new QSvgRenderer( this );
    m_width = QDeclarativeItem::width();
    m_height = QDeclarativeItem::height();
}

void SvgImage::setSource(const QString &source)
{
    QDeclarativeContext* context = QDeclarativeEngine::contextForObject( this );
    QString baseDir;
    if ( context )
    {
        QFileInfo info( context->baseUrl().path() );
        baseDir = info.path();
    }
    m_source = baseDir+ "/"+ source;
    QFile file( m_source );
    //qDebug("SvgImage: setSource: opening %s ...", m_source.toAscii().constData() );
    if ( file.open( QFile::ReadOnly ) )
    {
        m_svgDocument.setContent( file.readAll() );
        updatePixmap();
    }
    else
    {
        m_source = ":" + m_source;
        file.setFileName( m_source );
        if ( file.open( QFile::ReadOnly ) )
        {
            m_svgDocument.setContent( file.readAll() );
            updatePixmap();
        }
        else
            qDebug("SvgImage: setSource: %s not found!", m_source.toAscii().constData() );
    }
}

QString SvgImage::source() const
{
    return m_source;
}

void SvgImage::paint(QPainter *painter, const QStyleOptionGraphicsItem *, QWidget *)
{
    if ( m_updateNeeded )
    {
        updatePixmap( m_resizePixmap );
        m_resizePixmap = false;
    }

    QRectF target(0, 0, m_pixmap.width(), m_pixmap.height());

    if (m_startX != -1) {
        target.setX(m_startX);
    }
    if (m_startY != -1) {
        target.setY(m_startY);
    }
    if (m_endX != -1) {
        target.setWidth(m_endX);
    }
    if (m_endY != -1) {
        target.setHeight(m_endY);
    }

    painter->drawPixmap( target, m_pixmap, target );
}

QRectF SvgImage::boundingRect() const
{
    //QSize s( m_pixmap.size() );
    //return QRect( QPoint(-s.width() / 2, -s.height() / 2), s );
    return QRectF( QPointF(), m_pixmap.size() );
}

void SvgImage::updatePixmap(bool updateSize)
{
    m_updateNeeded = false;
    m_renderer->load( m_svgDocument.toByteArray( 0 ) );
    if ( updateSize )
    {
        if ( width() > 0. && height() > 0. )
            m_pixmap = QPixmap( QSize( m_width, m_height ) );
    //        m_pixmap = QPixmap( QSize( width(), height() ) );
        else
            m_pixmap = QPixmap( m_renderer->defaultSize() );
    }
    m_pixmap.fill( QColor(0, 0, 0, 0) );
    QPainter painter( &m_pixmap );
    m_renderer->render( &painter );
}

bool checkIDAttribute( const QDomNamedNodeMap& map, const QString& value )
{
    QDomNode attrElement = map.namedItem( "id" );
    if ( attrElement.isAttr() )
    {
        QDomAttr attr = attrElement.toAttr();
        return attr.value() == value;
    }
    return false;
}

void SvgImage::modify(const QString &tag, const QString &id, const QString &attribute,
                      const QString &value)
{
    bool modified = false;

    QDomNodeList nodeList = m_svgDocument.elementsByTagName( tag );
    for ( int i = 0; i < nodeList.count(); ++i )
    {
        QDomNode node = nodeList.at( i );
        QDomNamedNodeMap attributes = node.attributes();
        if ( checkIDAttribute( attributes, id ) )
        {
            QDomNode attrElement = attributes.namedItem( attribute );
            if ( attrElement.isAttr() )
            {
                QDomAttr attr = attrElement.toAttr();
                attr.setValue( value );
                modified = true;
            }
        }
    }

    if ( modified )
    {
        m_updateNeeded = true;
        update();
    }
}

void SvgImage::setPixmap(const QPixmap &pixmap)
{
    m_pixmap = pixmap;
    prepareGeometryChange();
    update();
}

QPixmap SvgImage::pixmap() const
{
    return m_pixmap;
}
