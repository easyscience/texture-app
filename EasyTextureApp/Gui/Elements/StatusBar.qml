import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Animations as EaAnimations
import EasyApp.Gui.Elements as EaElements

import Gui.Globals as ExGlobals

Rectangle {
    id: statusBar

    //property alias text: label.text
    //property alias model: listView.model
    default property alias contentRowData: contentRow.data

    //visible: EaGlobals.Vars.showAppStatusBar

    //Component.onCompleted: y = visible ? 0 : height

    width: parent.width
    height: parent.height

    color: EaStyle.Colors.statusBarBackground
    Behavior on color { EaAnimations.ThemeChange {} }

    // main content container
    Row {
        id: contentRow

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: EaStyle.Sizes.fontPixelSize
        anchors.rightMargin: EaStyle.Sizes.fontPixelSize

        spacing: EaStyle.Sizes.fontPixelSize * 1.2
    }

    // Status bar top border
    Rectangle {
        anchors.top: statusBar.top
        anchors.left: statusBar.left
        anchors.right: statusBar.right

        height: 1//EaStyle.Sizes.borderThickness

        color: EaStyle.Colors.appBarBorder
        Behavior on color { EaAnimations.ThemeChange {} }
    }

    /*
    // Show-hide status bar animation
    Behavior on visible {
        InterfaceAnimations.BarShow {
            parentTarget: statusBar
        }
    }
    */
}
