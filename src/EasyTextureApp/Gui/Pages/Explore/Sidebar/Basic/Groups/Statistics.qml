// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals

EaComponents.TableView {
    id: statisticsTable
    defaultInfoText: 'No statistics available'

    property var tableData: [
        { rowTitle: 'Counts Min', column1: Globals.BackendWrapper.exploreRingCountsMin, column2: Globals.BackendWrapper.exploreTotalCountsMin },
        { rowTitle: 'Counts Max', column1: Globals.BackendWrapper.exploreRingCountsMax, column2: Globals.BackendWrapper.exploreTotalCountsMax },
        { rowTitle: 'Counts Sum', column1: Globals.BackendWrapper.exploreRingCountsSum, column2: Globals.BackendWrapper.exploreTotalCountsSum },
        { rowTitle: 'Peak Width', column1: Globals.BackendWrapper.exploreRingMaxIntensityWidth + '°', column2: 'N/A' }
    ]

    model: tableData

    header: EaComponents.TableViewHeader {

        // Placeholder for row title
        EaComponents.TableViewLabel {
            width: statisticsTable.width / 5
        }

        EaComponents.TableViewLabel {
            text: qsTr('Current 2θ Ring')
            width: statisticsTable.width * 2 / 5
        }

        EaComponents.TableViewLabel {
            text: qsTr('Total')
            width: statisticsTable.width * 2 / 5
        }
    }

    // Rows
    delegate: EaComponents.TableViewDelegate {

        EaComponents.TableViewLabel {
            text: modelData.rowTitle
            width: statisticsTable.width / 5
            horizontalAlignment: Text.AlignHCenter
            //enabled: false
        }

        EaComponents.TableViewLabel {
            text: modelData.column1
            width: statisticsTable.width * 2 / 5
            enabled: false
        }

        EaComponents.TableViewLabel {
            text: modelData.column2
            width: statisticsTable.width * 2 / 5
            enabled: false
        }
    }

}
