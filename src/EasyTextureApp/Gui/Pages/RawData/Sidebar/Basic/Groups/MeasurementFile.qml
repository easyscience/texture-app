// SPDX-FileCopyrightText: 2022 easyDiffraction contributors <support@easydiffraction.org>
// SPDX-License-Identifier: BSD-3-Clause
// © 2021-2022 Contributors to the easyDiffraction project <https://github.com/easyScience/easyDiffractionApp>

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents
import EasyApp.Gui.Logic as EaLogic

import Gui.Globals as Globals


Column {
    spacing: EaStyle.Sizes.fontPixelSize

    // Table
    EaComponents.TableView {
        id: measurementFilesView

        defaultInfoText: qsTr('No measurements loaded')

        // Table model
        model: Globals.BackendWrapper.rawDataMeasurements

        // Headers
        header: EaComponents.TableViewHeader {

            EaComponents.TableViewLabel {
                text: qsTr('No.')
                width: EaStyle.Sizes.fontPixelSize * 2.5
            }

            EaComponents.TableViewLabel {
                flexibleWidth: true
                horizontalAlignment: Text.AlignLeft
                text: qsTr('Filename')
            }

            // Placeholder for row delete button
            EaComponents.TableViewLabel {
                width: EaStyle.Sizes.tableRowHeight
            }
        }

        // Table rows
        delegate: EaComponents.TableViewDelegate {

            // Index
            EaComponents.TableViewLabel {
                width: EaStyle.Sizes.fontPixelSize * 2.5
                text: index + 1
            }

            // Filename
            EaComponents.TableViewTextInput {
                id: tableViewLine
                text: measurementFilesView.model[index].name
                ToolTip.visible: EaGlobals.Vars.showToolTips && text !== '' && tableViewLine.hovered
                ToolTip.text: measurementFilesView.model[index].path
                readOnly: true
                color: EaStyle.Colors.themeForeground
            }

            // Remove button
            EaComponents.TableViewButton {
                enabled: measurementFilesView !== null
                fontIcon: 'minus-circle'
                ToolTip.text: qsTr('Remove this file')
                onClicked: Globals.BackendWrapper.rawDataRemoveFilename(measurementFilesView.model[index].name)
            }
        }
    }

    // Control buttons below table
    Row {

        spacing: EaStyle.Sizes.fontPixelSize

        EaElements.SideBarButton {
            wide: true
            //enabled: true //false //!Globals.Proxies.main.corrections.isCreated
            fontIcon: 'upload'
            text: qsTr('Load measurement file')

            onClicked: {
                console.debug(`Clicking '${text}' button ::: ${this}`)
                Globals.References.pages.rawData.sidebar.basic.popups.openJsonFile.open()
            }

            Loader {
                source: '../Popups/OpenJsonFile.qml'
            }

            /*Component.onCompleted: {
                Globals.Refs.app.rawDataPage.importDataFromLocalDriveButton = this
            }*/

        }
    }
}
