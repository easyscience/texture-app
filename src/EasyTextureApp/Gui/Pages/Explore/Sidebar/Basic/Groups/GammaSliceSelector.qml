// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals

Grid {
    rows: 2
    rowSpacing: 30

    Row {
        Grid {
            columns: 4
            columnSpacing: EaStyle.Sizes.fontPixelSize

            RadioButton {
                id: oneDegreeButton
                topPadding: 0
                checked: true
                text: '1°'

                onClicked: {
                    Globals.BackendWrapper.exploreGammaBinWidth = 1.0
                }

            }

            RadioButton {
                id: twoDegreeButton
                topPadding: 0
                text: '2°'

                onClicked: {
                    Globals.BackendWrapper.exploreGammaBinWidth = 2.0                }

            }

            RadioButton {
                id: fiveDegreeButton
                topPadding: 0
                text: '5°'
                enabled: false
                contentItem: Text {
                    text: fiveDegreeButton.text
                    color: 'grey'
                    leftPadding: fiveDegreeButton.indicator.width + fiveDegreeButton.spacing
                }

                onClicked: {
                    Globals.BackendWrapper.exploreGammaBinWidth = 5.0
                }

            }

            RadioButton {
                id: tenDegreeButton
                topPadding: 0
                text: '10°'
                enabled: false
                contentItem: Text {
                    text: tenDegreeButton.text
                    color: 'grey'
                    leftPadding: tenDegreeButton.indicator.width + tenDegreeButton.spacing
                }

                onClicked: {
                    Globals.BackendWrapper.exploreGammaBinWidth = 5.0
                }
            }
        }
    }
}
