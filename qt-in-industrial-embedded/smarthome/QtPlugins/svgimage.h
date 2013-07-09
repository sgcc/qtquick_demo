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

#ifndef SVGIMAGE_H
#define SVGIMAGE_H

#include <QDeclarativeItem>
#include <QDomDocument>

class QSvgRenderer;
class SvgImage : public QDeclarativeItem
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource)
    Q_PROPERTY(QPixmap pixmap READ pixmap WRITE setPixmap)

    Q_PROPERTY(double startX READ startX WRITE setStartX)
    Q_PROPERTY(double startY READ startY WRITE setStartY)
    Q_PROPERTY(double endX  READ endX WRITE setEndX)
    Q_PROPERTY(double endY  READ endY WRITE setEndY)

    Q_PROPERTY(qreal width  READ width WRITE setWidth)
    Q_PROPERTY(qreal height  READ height WRITE setHeight)

public:
    explicit SvgImage(QDeclarativeItem *parent = 0);

    QString source() const;
    void setSource(const QString& source );

    QPixmap pixmap() const;
    void setPixmap( const QPixmap& pixmap );

    virtual void paint(QPainter *, const QStyleOptionGraphicsItem *, QWidget *);
    virtual QRectF boundingRect() const;

    double startX() { return m_startX; }
    double startY() { return m_startY; }
    double endX() { return m_endX; }
    double endY() { return m_endY; }

    qreal width() const { return m_width; }
    void setWidth(qreal w ) {
        m_width = w;
        m_updateNeeded = true;
        m_resizePixmap = true;
        update();
    }

    qreal height() const { return m_height; }
    void setHeight(qreal h ) {
        m_height = h;
        m_updateNeeded = true;
        m_resizePixmap = true;
        update();
    }

    void setStartX(double x) { m_startX = x; update();}
    void setStartY(double y) { m_startY = y; update(); }
    void setEndX(double w) { m_endX  = w; }
    void setEndY(double h) { m_endY = h; }


signals:

public slots:
    void modify( const QString& tag, const QString& id, const QString& attribute,
                 const QString& value);
private:
    void updatePixmap(bool updateSize = true);

    QString m_source;
    QPixmap m_pixmap;
    QSvgRenderer* m_renderer;
    QDomDocument m_svgDocument;

    double m_startX;
    double m_startY;
    double m_endX;
    double m_endY;

    qreal m_width;
    qreal m_height;

    bool    m_updateNeeded;
    bool    m_resizePixmap;
};

#endif // SVGIMAGE_H
