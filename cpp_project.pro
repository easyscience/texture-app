TEMPLATE = app

# Application name
TARGET = cpp_project #EasyTextureApp doesn't work for WASM

CONFIG += c++17

# Makes compiler emit warnings if deprecated feature is used
DEFINES += QT_DEPRECATED_WARNINGS

QT += quick gui qml webenginequick

SOURCES += \
    EasyTextureApp/main.cpp

RESOURCES += EasyTextureApp/resources.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += \
    EasyTextureApp \
    ../EasyApp

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH += \
    EasyTextureApp \
    ../EasyApp
