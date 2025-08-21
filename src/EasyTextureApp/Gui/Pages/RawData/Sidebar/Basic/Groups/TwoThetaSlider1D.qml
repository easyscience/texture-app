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
    rows: 2
    columnSpacing: EaStyle.Sizes.fontPixelSize
    rowSpacing: EaStyle.Sizes.fontPixelSize * 0.5
    property alias sliderValue1D: slider.value

    // Location
    Row {
        id: twoThetaRow

        Grid {
            readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5
            columns: 2
            rowSpacing: 10
        }

    }

    Row {
        id: sliderRow

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
            from: Globals.BackendWrapper.rawDataMinTwoThetaCenter1D
            to: Globals.BackendWrapper.rawDataMaxTwoThetaCenter1D
            stepSize: Globals.BackendWrapper.rawDataTwoThetaBinWidth1D
            toolTipText: slider.value + '°'
            // updates slider value only on release
            live: false
            // live update of slider tooltip value
            onPositionChanged: {
                let rawToolTipValue = from + visualPosition * (to - from)
                let toolTipValue = from + Math.round((rawToolTipValue - from) / stepSize) * stepSize
                toolTipText = toolTipValue.toString() + '°'
            }

            onValueChanged: {
                // Makes sure not to update the slider while the javascript calculation is ongoing
                // (on bin two theta width change). The slider will be updated on its own in as
                // a result of that calculation.
                Globals.BackendWrapper.rawDataTwoThetaSliderValue1D = slider.value.toFixed(2)
                if (Globals.BackendWrapper.rawDataRunJavaScriptIsOff1D) {
                    Globals.BackendWrapper.rawDataUpdateTwoThetaSliderIndex1D()
                }

                if (Globals.BackendWrapper.rawDataSyncTabsBinningsSliders) {
                    // Globals.BackendWrapper.rawDataTwoThetaSliderValue2D = slider.value.toFixed(2)
                    // Globals.BackendWrapper.rawDataUpdateTTSliderIndex2D()
                    // Globals.BackendWrapper.rawDataTwoThetaSliderValue3D = slider.value.toFixed(2)
                    // Globals.BackendWrapper.rawDataUpdateTwoThetaSliderIndex3D()
                    Globals.BackendWrapper.rawDataTwoThetaSliderValueSync = slider.value.toFixed(2)
                    console.debug(`1D slider moved to ${Globals.BackendWrapper.rawDataTwoThetaSliderValueSync} degrees.`)
                } else {
                    console.debug(`1D slider moved to ${Globals.BackendWrapper.rawDataTwoThetaSliderValue1D} degrees.`)
                }

            }

            Component.onCompleted: Globals.References.pages.rawData.sidebar.basic.groups.binning1d.twoThetaSlider = slider
        }

        EaElements.Label {
            id: sliderToLabel
            text: slider.to.toFixed(2) + '°'
        }
    }
}

