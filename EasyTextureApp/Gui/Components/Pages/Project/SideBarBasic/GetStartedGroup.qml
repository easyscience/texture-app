// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls
//import QtQuick.XmlListModel 2.15

import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents
import EasyApp.Gui.Logic as EaLogic

import Gui.Globals as Globals


Grid {
    columns: 2
    spacing: EaStyle.Sizes.fontPixelSize

    EaElements.SideBarButton {
        fontIcon: "plus-circle"
        text: qsTr("Create a new project")

        onClicked: {
            projectDescriptionDialog.source = 'ProjectDescriptionDialog.qml'
            EaGlobals.Variables.showProjectDescriptionDialog = true
        }

        Loader {
            id: projectDescriptionDialog
        }
    }

    EaElements.SideBarButton {
        enabled: Globals.Proxies.main.project.isEnabledOpenExistingProject

        fontIcon: "upload"
        text: qsTr("Open an existing project")
    }

    /*EaElements.SideBarButton {
        enabled: Globals.Proxies.main.project.isEnabledSaveProjectAs

        fontIcon: "download"
        text: qsTr("Save project as...")
    }

    EaElements.SideBarButton {
        enabled: Globals.Proxies.main.project.isEnabledCloseCurrentProject

        fontIcon: "times-circle"
        text: qsTr("Close current project")
    }*/

}

