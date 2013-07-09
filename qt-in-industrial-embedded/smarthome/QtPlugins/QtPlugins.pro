#-------------------------------------------------
#
# Project created by QtCreator 2010-07-23T16:05:54
#
#-------------------------------------------------

standalone {
    TEMPLATE = app
    SOURCES += main.cpp
    TARGET = smarthome
	CONFIG += console static
        #
        # uncomment this when building statically
        #
        #QTPLUGIN += qmlparticlesplugin qsvg
} else {
    SOURCES += plugin.cpp
    HEADERS += plugin.h
    TEMPLATE = lib
    DESTDIR = ../lib
}

CONFIG += qt plugin
QT += declarative svg xml
RESOURCES = smarthome.qrc

OBJECTS_DIR = tmp
MOC_DIR = tmp

SOURCES += \
    svgimage.cpp

HEADERS += \
    svgimage.h
