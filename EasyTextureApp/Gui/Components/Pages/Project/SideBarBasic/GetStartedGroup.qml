// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

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

        onClicked: {
            console.debug(`Clicking '${text}' button: ${this}`)
            if (Globals.Vars.isTestMode) {
                //console.debug('*** Open an existing project (test mode) ***')
                //Globals.Vars.modelPageEnabled = true
                //const fpath = Qt.resolvedUrl('../../../../../../examples/1-model_1-experiment/project.cif')
                //Globals.Proxies.main.project.loadProject(fpath)
                //Globals.Vars.summaryPageEnabled = true
            } else {
                openJsonFileDialog.open()
            }
        }
    }

    EaElements.SideBarButton {
        enabled: Globals.Proxies.main.project.isEnabledSaveProjectAs
        visible: false

        fontIcon: "download"
        text: qsTr("Save project as...")
    }

    EaElements.SideBarButton {
        enabled: Globals.Proxies.main.project.isEnabledCloseCurrentProject
        visible: false

        fontIcon: "times-circle"
        text: qsTr("Close current project")
    }


    // Misc
    FileDialog {
        id: openJsonFileDialog
        fileMode: FileDialog.OpenFile
        nameFilters: [ "JSON files (*.json)"]
        onAccepted: {
            console.debug('*** Loading project from file ***')
            //Globals.Proxies.disableAllPagesExceptProject()
            //Globals.Proxies.resetAll()

            //Globals.Vars.modelPageEnabled = true
            //Globals.Vars.experimentPageEnabled = true

            //Globals.Proxies.main.project.loadProject(selectedFile)

            //Globals.Vars.analysisPageEnabled = true
            //Globals.Vars.summaryPageEnabled = true
        }
    }
}

