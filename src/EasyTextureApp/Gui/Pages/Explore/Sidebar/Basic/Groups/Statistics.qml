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

            EaElements.Label {
                visible: Globals.Proxies.main.project.location !== '--- EXAMPLE ---'
                //font.bold: true
                text: qsTr('Counts Min:')
            }
            EaElements.Label {
                text: Globals.Proxies.main.explore.twoThetaRingCountMin
            }

            EaElements.Label {
                //font.bold: true
                text: qsTr('Counts Max:')
            }
            EaElements.Label {
                text: Globals.Proxies.main.explore.twoThetaRingCountMax
            }

            EaElements.Label {
                //font.bold: true
                text: qsTr('Counts Sum:')
            }
            EaElements.Label {
                text: Globals.Proxies.main.explore.twoThetaRingCountSum
            }

            EaElements.Label {
                //font.bold: true
                text: qsTr('Intensity Width (in γ°):')
            }
            EaElements.Label {
                id: intensityWidth
                text: Globals.Proxies.main.explore.maxIntensityWidth
            }
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
            EaElements.Label {
                visible: Globals.Proxies.main.project.location !== '--- EXAMPLE ---'
                //font.bold: true
                text: qsTr('Count Min:')
            }
            EaElements.Label {
                text: Globals.Proxies.main.explore.totalCountMin
            }

            EaElements.Label {
                //font.bold: true
                text: qsTr('Count Max:')
            }
            EaElements.Label {
                text: Globals.Proxies.main.explore.totalCountMax
            }

            EaElements.Label {
                //font.bold: true
                text: qsTr('Count Sum:')
            }
            EaElements.Label {
                text: Globals.Proxies.main.explore.totalCountSum
            }

            EaElements.Label {
                //font.bold: true
                text: qsTr('Number of Slices/Patterns:')
            }
            EaElements.Label {
                text: Globals.Proxies.main.explore.numberOfGammaSlices //.sliderMaxValue
            }
        }
    }
}



