TEMPLATE = app

QT += qml quick
SOURCES += main.cpp

target.path = /opt/Qt5_NMap_CarouselDemo
qml.files = Qt5_NMap_CarouselDemo.qml content
qml.path = /opt/Qt5_NMap_CarouselDemo
INSTALLS += target qml
