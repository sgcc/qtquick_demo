CONFIG -= app_bundle

SOURCES = main.cpp \
    mainwidget.cpp \
    gamedata.cpp

QT += script \
    declarative

# This is needed for Maemo5 to recognize minimization of the application window
maemo5 {
    QT += dbus
}

contains(QT_CONFIG, opengles2)|contains(QT_CONFIG, opengl):QT += opengl
sources.files = $$SOURCES \
    $$HEADERS \
    $$RESOURCES \
    $$FORMS \
    5-in-a-row.pro

OTHER_FILES += content/MainView.qml \
    content/Tile.qml \
    content/Explosion.qml \
    content/ControlPanel.qml \
    content/Button.qml \
    content/MenuPanel.qml \
    content/GameView.qml \
    content/Switch.qml \
    content/Frame.qml

HEADERS += tile.h \
    mainwidget.h \
    gamedata.h
