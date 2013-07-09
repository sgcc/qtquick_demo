TEMPLATE = app
TARGET = coffeetweed

QT += declarative

symbian {
    LIBS += -lesock -lconnmon -lcone -lavkon

    TARGET.UID3 = 0xe4431593
    TARGET.EPOCHEAPSIZE = 0x20000 0x2000000

    DEPLOYMENT.installer_header = 0xA000D7CE
}

linux-g++-maemo5 {
    INSTALLS += desktop
    desktop.path = /usr/share/applications/hildon
    desktop.files = coffeetweed.desktop

    INSTALLS += icon64
    icon64.path = /usr/share/icons/hicolor/64x64/apps
    icon64.files = icon-coffeetweed.png
}

SOURCES += main.cpp

RESOURCES += resource.qrc
