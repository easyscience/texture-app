// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals

Row {

    EaElements.RadioButton {
        id: yesButton
        checked: Globals.BackendWrapper.rawDataCalculateViewsAtOnce
        //enabled: false
        text: 'Yes'
        onClicked: {
            Globals.BackendWrapper.rawDataCalculateViewsAtOnce = true
            // set the flag not to reset the slider on data syncing
            Globals.BackendWrapper.rawDataResetTwoThetaSlider = false
            // save global data values before they are modified on the change of the binning data
            let sliderValueSync = Globals.BackendWrapper.rawDataTwoThetaSliderValueSync
            let sliderIndexSync = Globals.BackendWrapper.rawDataTwoThetaSliderIndexSync
            let twoThetaBinWidthIndexSync = Globals.BackendWrapper.rawDataTwoThetaBinWidthIndexSync
            let gammaBinWidthIndexSync = Globals.BackendWrapper.rawDataGammaBinWidthIndexSync
            if (Globals.BackendWrapper.rawDataSelectedTabIndex === 0) { // in 3D view
                // syncing 1D values to global values specified in 3D view
                Globals.BackendWrapper.rawDataTwoThetaSliderIndex1D = sliderIndexSync
                Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex1D = twoThetaBinWidthIndexSync
                Globals.BackendWrapper.rawDataGammaBinWidthIndex1D = gammaBinWidthIndexSync
                Globals.References.pages.rawData.sidebar.basic.groups.binning1d.twoThetaSlider.value = sliderValueSync
                Globals.BackendWrapper.rawDataTwoThetaSliderValue1D = sliderValueSync
                Globals.BackendWrapper.rawDataUpdateSliceData1D(Globals.References.pages.rawData.mainArea.tabLinePlot1d, sliderIndexSync)
                // syncing 2D values to global values specified in 3D view
                Globals.BackendWrapper.rawDataTwoThetaSliderIndex2D = sliderIndexSync
                Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D = twoThetaBinWidthIndexSync
                Globals.BackendWrapper.rawDataGammaBinWidthIndex2D = gammaBinWidthIndexSync
                Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaSlider.value = sliderValueSync
                Globals.BackendWrapper.rawDataTwoThetaSliderValue2D = sliderValueSync
                Globals.BackendWrapper.rawDataUpdateSliceData2D(Globals.References.pages.rawData.mainArea.tabPolarHeatmapPlot2d, sliderIndexSync)
            } else if (Globals.BackendWrapper.rawDataSelectedTabIndex === 3) { // in 1D view
                // syncing 2D values to global values specified in 1D view
                Globals.BackendWrapper.rawDataTwoThetaSliderIndex2D = sliderIndexSync
                Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D = twoThetaBinWidthIndexSync
                Globals.BackendWrapper.rawDataGammaBinWidthIndex2D = gammaBinWidthIndexSync
                Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaSlider.value = sliderValueSync
                Globals.BackendWrapper.rawDataTwoThetaSliderValue2D = sliderValueSync
                Globals.BackendWrapper.rawDataUpdateSliceData2D(Globals.References.pages.rawData.mainArea.tabPolarHeatmapPlot2d, sliderIndexSync)
                // syncing 3D values to global values specified in 1D view
                Globals.BackendWrapper.rawDataTwoThetaSliderIndex3D = sliderIndexSync
                Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex3D = twoThetaBinWidthIndexSync
                Globals.BackendWrapper.rawDataGammaBinWidthIndex3D = gammaBinWidthIndexSync
                Globals.References.pages.rawData.sidebar.basic.groups.binning3d.twoThetaSlider.value = sliderValueSync
                Globals.BackendWrapper.rawDataTwoThetaSliderValue3D = sliderValueSync
                Globals.BackendWrapper.rawDataUpdateSliderPatchData3D(Globals.References.pages.rawData.mainArea.tabSurfacePlot3d, sliderIndexSync)
            } else if (Globals.BackendWrapper.rawDataSelectedTabIndex === 1 || Globals.BackendWrapper.rawDataSelectedTabIndex === 2) { // 2D view
                // syncing 1D values to global values specified in 2D view
                Globals.BackendWrapper.rawDataTwoThetaSliderIndex1D = sliderIndexSync
                Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex1D = twoThetaBinWidthIndexSync
                Globals.BackendWrapper.rawDataGammaBinWidthIndex1D = gammaBinWidthIndexSync
                Globals.References.pages.rawData.sidebar.basic.groups.binning1d.twoThetaSlider.value = sliderValueSync
                Globals.BackendWrapper.rawDataTwoThetaSliderValue1D = sliderValueSync
                Globals.BackendWrapper.rawDataUpdateSliceData1D(Globals.References.pages.rawData.mainArea.tabLinePlot1d, sliderIndexSync)
                // syncing 3D values to global values specified in 2D view
                Globals.BackendWrapper.rawDataTwoThetaSliderIndex3D = sliderIndexSync
                Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex3D = twoThetaBinWidthIndexSync
                Globals.BackendWrapper.rawDataGammaBinWidthIndex3D = gammaBinWidthIndexSync
                Globals.References.pages.rawData.sidebar.basic.groups.binning3d.twoThetaSlider.value = sliderValueSync
                Globals.BackendWrapper.rawDataTwoThetaSliderValue3D = sliderValueSync
                Globals.BackendWrapper.rawDataUpdateSliderPatchData3D(Globals.References.pages.rawData.mainArea.tabSurfacePlot3d, sliderIndexSync)
            } else {
                console.debug(`WARNING: unsupported value for rawDataSelectedTabIndex: ${Globals.BackendWrapper.rawDataSelectedTabIndex}.`)
            }
            // turn off the flag to its default value
            Globals.BackendWrapper.rawDataResetTwoThetaSlider = true
        }
    }

    EaElements.RadioButton {
        id: noButton
        checked: !Globals.BackendWrapper.rawDataCalculateViewsAtOnce
        //enabled: false
        text: 'No'
        onClicked: {
            Globals.BackendWrapper.rawDataCalculateViewsAtOnce = false
        }
    }

}

