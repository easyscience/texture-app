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
        console.debug(`Open file dialog ${this} accepted. Starting file loading process.`)

        // Extract the file name from the full path
        var filePath = selectedFile.toString()
        var fileName = filePath.split('/').pop()

        Globals.BackendWrapper.rawDataLoadMeasurement(filePath)
        Globals.BackendWrapper.rawDataSetSelectedFilename(filePath, fileName)
        //Globals.References.applicationWindow.appBarCentralTabs.correctionsButton.enabled = true
        //Globals.References.applicationWindow.appBarCentralTabs.resultsButton.enabled = true
        Globals.BackendWrapper.rawDataLoaded = true
        Globals.BackendWrapper.statusRawDataFile = fileName
        console.debug(`File loading process finished.`)

    }

    Component.onCompleted: {
        Globals.References.pages.rawData.sidebar.basic.popups.openJsonFile =  openJsonFileDialog
    }

}
