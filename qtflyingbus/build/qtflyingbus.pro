TEMPLATE = app
TARGET = FlyingBus

QT += xml declarative

HEADERS += mainwindow.h
SOURCES += main.cpp mainwindow.cpp

symbian {
    LIBS += -lesock -lconnmon -lcone -lavkon

    TARGET.UID3 = 0xe9179145
    TARGET.EPOCHEAPSIZE = 0x20000 0x6000000

    ICON = icon-qtflyingbus.svg

    qmlfiles.sources = ../core ../main_640_360.qml
    DEPLOYMENT += qmlfiles

    DEPLOYMENT.installer_header = 0xA000D7CE
}

linux-g++-maemo5 {
    INSTALLS += desktop
    desktop.path = /usr/share/applications/hildon
    desktop.files = qtflyingbus.desktop

    INSTALLS += icon64
    icon64.path = /usr/share/icons/hicolor/64x64/apps
    icon64.files = icon-qtflyingbus.png

    INSTALLS += qmlfiles
    qmlfiles.path = /usr/share/qtflyingbus
    qmlfiles.files = ../core ../main_800_480.qml
}

target.path = /usr/bin
INSTALLS += target

QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.5
