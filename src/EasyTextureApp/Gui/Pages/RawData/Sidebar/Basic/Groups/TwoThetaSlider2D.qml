// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements

import Gui.Globals as Globals


Grid {
    rows: 4
    columnSpacing: EaStyle.Sizes.fontPixelSize
    rowSpacing: EaStyle.Sizes.fontPixelSize * 0.5
    property alias sliderValue: slider.value

    // Location
    Row {
        Grid {
            readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5
            columns: 2
            rowSpacing: 10
        }
    }


    Row {
        id: slideRow

        width: EaStyle.Sizes.sideBarContentWidth
        height: 50
        spacing: 10

        EaElements.Label {
            id: sliderFromLabel
            text: slider.from.toFixed(2) + '°'
        }

        // Slider
        EaElements.Slider {
            id: slider
            width: EaStyle.Sizes.sideBarContentWidth
                   - EaStyle.Sizes.fontPixelSize * 0.5 - 100
            height: parent.height
            from: Globals.BackendWrapper.rawDataMinTwoThetaCenter2D
            to: Globals.BackendWrapper.rawDataMaxTwoThetaCenter2D
            stepSize: Globals.BackendWrapper.rawDataTwoThetaBinWidth2D
            toolTipText: slider.value + '°'

            onValueChanged: {
                Globals.BackendWrapper.rawDataTwoThetaRingsSliderValue2D = slider.value.toFixed(2)
            }
        }

        EaElements.Label {
            id: sliderToLabel
            text: slider.to.toFixed(2) + '°'
        }
    }
}
