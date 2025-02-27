// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.ProjectDescriptionDialog {
    visible: EaGlobals.Vars.showProjectDescriptionDialog
    onClosed: EaGlobals.Vars.showProjectDescriptionDialog = false

    onAccepted: {
        Globals.Proxies.main.project.name = projectName
        Globals.Proxies.main.project.description = projectDescription
        Globals.Proxies.main.project.location = projectLocation
        Globals.Proxies.main.project.create()
    }

    Component.onCompleted: {
        projectName = 'DefaultProject'
        projectDescription = 'Default project description'
        projectLocation = Globals.Proxies.main.project.location
    }
}


