TEMPLATE = app

QT += qml quick
SOURCES += main.cpp
RESOURCES += maroon.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quick/demos/maroon
INSTALLS += target

OTHER_FILES += \
    maroon.qml \
    content/logic.js \
    content/SoundEffect.qml \
    content/NewGameScreen.qml \
    content/InfoBar.qml \
    content/GameOverScreen.qml \
    content/GameCanvas.qml \
    content/BuildButton.qml
