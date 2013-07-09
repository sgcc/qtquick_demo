TEMPLATE = app

QT += qml quick
SOURCES += main.cpp
RESOURCES += samegame.qrc

target.path = $$[QT_INSTALL_EXAMPLES]/quick/demos/samegame
INSTALLS += target

OTHER_FILES += \
    samegame.qml \
    content/samegame.js \
    content/SmokeText.qml \
    content/SimpleBlock.qml \
    content/SamegameText.qml \
    content/PuzzleBlock.qml \
    content/PrimaryPack.qml \
    content/PaintEmitter.qml \
    content/MenuEmitter.qml \
    content/LogoAnimation.qml \
    content/GameArea.qml \
    content/Button.qml \
    content/BlockEmitter.qml \
    content/Block.qml
