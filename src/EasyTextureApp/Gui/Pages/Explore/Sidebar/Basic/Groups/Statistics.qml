// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


Row {
    Grid {
        columns: 2
        columnSpacing: EaStyle.Sizes.fontPixelSize

        Column {
            width: 1/2 * EaStyle.Sizes.sideBarContentWidth

            EaElements.Label {
                //enabled: false
                text: qsTr('Current 2θ Ring')
            }

            EaElements.Label {
                //enabled: false
                text: qsTr(' ')
            }

            // Grid
            Grid {
                readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5

                columns: 2
                rowSpacing: 0
                columnSpacing: commonSpacing

                EaElements.Label {
                    //visible: Globals.Proxies.main.project.location !== '--- EXAMPLE ---'
                    //font.bold: true
                    text: qsTr('Counts Min:')
                }
                EaElements.Label {
                    text: Globals.BackendWrapper.exploreRingCountsMin
                }

                EaElements.Label {
                    //font.bold: true
                    text: qsTr('Counts Max:')
                }
                EaElements.Label {
                    text: Globals.BackendWrapper.exploreRingCountsMax
                }

                EaElements.Label {
                    //font.bold: true
                    text: qsTr('Counts Sum:')
                }
                EaElements.Label {
                    text: Globals.BackendWrapper.exploreRingCountsSum
                }

                EaElements.Label {
                    //font.bold: true
                    text: qsTr('Intensity Width (in γ°):')
                }
                EaElements.Label {
                    id: intensityWidth
                    text: Globals.BackendWrapper.exploreRingMaxIntensityWidth + '°'
                }
            }// Grid
        }

        Column {
            width: 1/2 * EaStyle.Sizes.sideBarContentWidth

            EaElements.Label {
                //enabled: false
                text: qsTr('Total')
            }
            EaElements.Label {
                //enabled: false
                text: qsTr(' ')
            }

            // Grid
            Grid {
                readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5

                columns: 2
                rowSpacing: 0
                columnSpacing: commonSpacing

                EaElements.Label {
                    //visible: Globals.Proxies.main.project.location !== '--- EXAMPLE ---'
                    //font.bold: true
                    text: qsTr('Counts Min:')
                }
                EaElements.Label {
                    text: Globals.BackendWrapper.exploreTotalCountsMin
                }

                EaElements.Label {
                    //font.bold: true
                    text: qsTr('Counts Max:')
                }
                EaElements.Label {
                    text: Globals.BackendWrapper.exploreTotalCountsMax
                }

                EaElements.Label {
                    //font.bold: true
                    text: qsTr('Counts Sum:')
                }
                EaElements.Label {
                    text: Globals.BackendWrapper.exploreTotalCountsSum
                }

            }// Grid
        }
    }
}



