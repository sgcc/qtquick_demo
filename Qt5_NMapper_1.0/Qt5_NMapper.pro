TEMPLATE = app

QT += qml quick
SOURCES += main.cpp

target.path = /opt/Qt5_NMapper
qml.files = content
qml.path = /opt/Qt5_NMapper
INSTALLS += target qml
