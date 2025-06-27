// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents
import EasyApp.Gui.Logic as EaLogic

import Gui.Globals as Globals


EaComponents.TableView {

    id: tableView

    showHeader: false
    tallRows: true
    maxRowCountShow: 6

    defaultInfoText: qsTr('No examples available')

    model: Globals.BackendWrapper.projectExamples

    // header
    header: EaComponents.TableViewHeader {
        EaComponents.TableViewLabel {
            enabled: false
            width: EaStyle.Sizes.fontPixelSize * 2.5
        }

        EaComponents.TableViewLabel {
            flexibleWidth: true
            horizontalAlignment: Text.AlignLeft
            text: qsTr('name / description')
        }
    }
    // header

    // delegate
    delegate: EaComponents.TableViewDelegate {
        mouseArea.onPressed: {
            const filePath = tableView.model[index].path
            console.debug(`Loading simulation of example from: ${filePath}`)
            Globals.BackendWrapper.projectName = tableView.model[index].name
            Globals.BackendWrapper.projectEditInfo('description', tableView.model[index].description)
            Globals.BackendWrapper.projectEditInfo('location', tableView.model[index].path)
            Globals.BackendWrapper.projectCreate()
            // todo: sum up as rawDataCreate()
            Globals.BackendWrapper.rawDataLoaded = true
            Globals.BackendWrapper.rawDataLoadMeasurement('example_rawdata.json')
            Globals.BackendWrapper.rawDataSetSelectedFilename('test/example_rawdata.json', 'example_rawdata.json')
            Globals.BackendWrapper.statusRawDataFile = 'example_rawdata.json'
            Globals.References.applicationWindow.appBarCentralTabs.rawDataButton.enabled = true
            Globals.References.applicationWindow.appBarCentralTabs.correctionsButton.enabled = true
            Globals.References.applicationWindow.appBarCentralTabs.exploreButton.enabled = true
            Globals.BackendWrapper.statusGammaSliceWidthVisible = true
            Globals.References.applicationWindow.appBarCentralTabs.resultsButton.enabled = true
        }

        EaComponents.TableViewLabel {
            text: index + 1
            color: EaStyle.Colors.themeForegroundMinor
        }

        EaComponents.TableViewTwoRowsAdvancedLabel {
            fontIcon: 'archive'
            text: tableView.model[index].name
            minorText: tableView.model[index].description
            ToolTip.text: tableView.model[index].description
        }
    }
    // delegate

}
