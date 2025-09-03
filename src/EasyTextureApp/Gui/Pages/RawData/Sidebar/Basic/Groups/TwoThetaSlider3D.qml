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
    property alias sliderValue3D: slider.value

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
            from: Globals.BackendWrapper.rawDataMinTwoThetaCenter3D
            to: Globals.BackendWrapper.rawDataMaxTwoThetaCenter3D
            stepSize: Globals.BackendWrapper.rawDataTwoThetaBinWidth3D
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
                Globals.BackendWrapper.rawDataTwoThetaSliderValue3D = slider.value.toFixed(2)
                // Makes sure not to update the slider while the javascript calculation is ongoing
                // (on bin two theta width change). The slider will be updated on its own in as
                // a result of that calculation.
                if (Globals.BackendWrapper.rawDataRunJavaScriptIsOff3D) {
                    Globals.BackendWrapper.rawDataUpdateTwoThetaSliderIndex3D()
                    // makes sure to update slider data only then when the object has already created a dictionary
                    // with data. Blocks warning on the launch of the interface, when onValueChanged signal is emitted
                    // due to property binding without the actual data have been loaded and changed.
                    if (Object.keys(Globals.References.pages.rawData.mainArea.tabSurfacePlot3d.plotData).length > 0) {
                        Globals.BackendWrapper.rawDataUpdateSliderPatchData3D(Globals.References.pages.rawData.mainArea.tabSurfacePlot3d, Globals.BackendWrapper.rawDataTwoThetaSliderIndex3D)
                    }
                }
                //
                // if (Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                //     //Globals.BackendWrapper.rawDataTwoThetaSliderValue2D = slider.value.toFixed(2)
                //     //Globals.BackendWrapper.rawDataUpdateTwoThetaSliderIndex2D()
                //     //Globals.BackendWrapper.rawDataTwoThetaSliderValue1D = slider.value.toFixed(2)
                //     //Globals.BackendWrapper.rawDataUpdateTwoThetaSliderIndex1D()
                //     //Globals.BackendWrapper.rawDataTwoThetaSliderValueSync = Globals.BackendWrapper.rawDataTwoThetaSliderValue3D //slider.value.toFixed(2)
                //     console.debug(`3D slider moved to ${Globals.BackendWrapper.rawDataTwoThetaSliderValueSync} degrees.`)
                // } else {
                //     console.debug(`rawDataTwoThetaSliderValue3D was set to ${Globals.BackendWrapper.rawDataTwoThetaSliderValue3D} degrees.`)
                // }
            }

            Component.onCompleted: Globals.References.pages.rawData.sidebar.basic.groups.binning3d.twoThetaSlider = slider
        }

        EaElements.Label {
            id: sliderToLabel
            text: slider.to.toFixed(2) + '°'
        }
    }
}
