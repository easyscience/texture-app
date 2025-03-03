// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


FileDialog{

    id: openJsonFileDialog

    fileMode: FileDialog.OpenFile
    nameFilters: [ 'JSON files (*.json)']

    onAccepted: {
        //Globals.BackendWrapper.projectName = projectName
        //Globals.BackendWrapper.projectEditInfo('description', projectDescription)
        //Globals.BackendWrapper.projectEditInfo('location', projectLocation)

        Globals.BackendWrapper.rawDataLoaded = true
        Globals.BackendWrapper.rawDataLoadMeasurement()
        Globals.References.applicationWindow.appBarCentralTabs.summaryButton.enabled = true
    }

    Component.onCompleted: {
        Globals.References.pages.rawData.sidebar.basic.popups.openJsonFile =  openJsonFileDialog
    }

}
