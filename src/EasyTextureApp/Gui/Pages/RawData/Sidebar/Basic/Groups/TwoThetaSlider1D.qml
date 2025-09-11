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
                Globals.BackendWrapper.rawDataTwoThetaSliderValue1D = slider.value.toFixed(2)
                Globals.BackendWrapper.rawDataTwoThetaSliderValueSync = slider.value.toFixed(2)

                if (Globals.BackendWrapper.rawDataResetTwoThetaSlider) {
                    // Makes sure not to update the slider while the javascript calculation is ongoing
                    // (on two theta bin width change). The slider will be updated on its own in as
                    // a result of that calculation.
                    if (Globals.BackendWrapper.rawDataRunJavaScriptIsOff1D) {
                        Globals.BackendWrapper.rawDataTwoThetaSliderIndex1D = Globals.BackendWrapper.rawDataUpdateTwoThetaSliderIndex1D()
                        Globals.BackendWrapper.rawDataTwoThetaSliderIndexSync = Globals.BackendWrapper.rawDataUpdateTwoThetaSliderIndex1D()
                        // makes sure to update slider data only then when the object has already created a dictionary
                        // with data. Blocks warning on the launch of the interface, when onValueChanged signal is emitted
                        // due to property binding without the actual data have been loaded and changed.
                        if (Object.keys(Globals.References.pages.rawData.mainArea.tabLinePlot1d.fullData).length > 0) {
                            Globals.BackendWrapper.rawDataUpdateSliceData1D(Globals.References.pages.rawData.mainArea.tabLinePlot1d, Globals.BackendWrapper.rawDataTwoThetaSliderIndex1D)
                        }
                    }

                    if (Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                        //Globals.BackendWrapper.rawDataTwoThetaSliderValue2D = slider.value.toFixed(2)
                        // Globals.BackendWrapper.rawDataUpdateTwoThetaSliderIndex2D()
                        Globals.BackendWrapper.rawDataTwoThetaSliderValue3D = slider.value.toFixed(2)
                        Globals.References.pages.rawData.sidebar.basic.groups.binning3d.twoThetaSlider.value = slider.value.toFixed(2)
                        //Globals.BackendWrapper.rawDataUpdateTwoThetaSliderIndex3D()
                        //Globals.BackendWrapper.rawDataUpdateSliderPatchData3D(Globals.References.pages.rawData.mainArea.tabSurfacePlot3d, Globals.BackendWrapper.rawDataTwoThetaSliderIndex3D)
                        console.debug(`1D slider moved to ${Globals.BackendWrapper.rawDataTwoThetaSliderValueSync} degrees.`)
                    } else {
                        console.debug(`rawDataTwoThetaSliderValue1D was set to ${Globals.BackendWrapper.rawDataTwoThetaSliderValue1D} degrees.`)
                    }
                }
            }

            Component.onCompleted: {
                Globals.References.pages.rawData.sidebar.basic.groups.binning1d.twoThetaSlider = slider
            }
        }

        EaElements.Label {
            id: sliderToLabel
            text: slider.to.toFixed(2) + '°'
        }
    }
}

