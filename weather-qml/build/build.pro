TEMPLATE = app

QT += network xml declarative

maemo5 || unix {
    TARGET = ../weatherqml
    RESOURCES += resource_n900.qrc
}

symbian {
    TARGET = Weather
    LIBS += -lesock -lconnmon -lcone -lavkon
    ICON += ../icons/weatherqml.svg
    RESOURCES += resource_s60.qrc
}

HEADERS += mainwindow.h
SOURCES += main.cpp mainwindow.cpp
