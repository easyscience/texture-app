// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.ContentPage {

    defaultInfo: Globals.BackendWrapper.rawDataLoaded ?
                    '' :
                    qsTr('No measurement files loaded')

    mainView: EaComponents.MainContent {
        tabs: [
            EaElements.TabButton {
                text: qsTr('3D View: Detector Inner Surface')
                onClicked: {
                    Globals.BackendWrapper.rawDataSelectedTabIndex = 0
                    if (!Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                        // set the flag not to reset the slider on tab change
                        Globals.BackendWrapper.rawDataResetTwoThetaSlider = false

                        // save global data values before they are modified on changing binning data 3D
                        let sliderValueSync = Globals.BackendWrapper.rawDataTwoThetaSliderValueSync
                        let sliderIndexSync = Globals.BackendWrapper.rawDataTwoThetaSliderIndexSync
                        let twoThetaBinWidthIndexSync = Globals.BackendWrapper.rawDataTwoThetaBinWidthIndexSync
                        let gammaBinWidthIndexSync = Globals.BackendWrapper.rawDataGammaBinWidthIndexSync

                        // change selected two theta and gamma bin widths
                        Globals.BackendWrapper.rawDataTwoThetaSliderIndex3D = sliderIndexSync
                        Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex3D = twoThetaBinWidthIndexSync
                        Globals.BackendWrapper.rawDataGammaBinWidthIndex3D = gammaBinWidthIndexSync
                        Globals.References.pages.rawData.sidebar.basic.groups.binning3d.twoThetaSlider.value = sliderValueSync
                        Globals.BackendWrapper.rawDataTwoThetaSliderValue3D = sliderValueSync
                        Globals.BackendWrapper.rawDataUpdateSliderPatchData3D(sliderIndexSync)

                        // turn off the flag to its default value
                        Globals.BackendWrapper.rawDataResetTwoThetaSlider = true
                    }
                    console.debug(`3D View tab is selected ::: ${this}. Selected tab index changed to ${Globals.BackendWrapper.rawDataSelectedTabIndex}`)
                }
            },
            EaElements.TabButton {
                text: qsTr('2D View: γ-2θ')
                onClicked: {
                    Globals.BackendWrapper.rawDataSelectedTabIndex = 1
                    if (!Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                        // set the flag not to reset the slider on tab change
                        Globals.BackendWrapper.rawDataResetTwoThetaSlider = false

                        // save global data values before they are modified on changing binning data 2D
                        let sliderValueSync = Globals.BackendWrapper.rawDataTwoThetaSliderValueSync
                        let sliderIndexSync = Globals.BackendWrapper.rawDataTwoThetaSliderIndexSync
                        let twoThetaBinWidthIndexSync = Globals.BackendWrapper.rawDataTwoThetaBinWidthIndexSync
                        let gammaBinWidthIndexSync = Globals.BackendWrapper.rawDataGammaBinWidthIndexSync

                        // change selected two theta and gamma bin widths
                        Globals.BackendWrapper.rawDataTwoThetaSliderIndex2D = sliderIndexSync
                        Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D = twoThetaBinWidthIndexSync
                        Globals.BackendWrapper.rawDataGammaBinWidthIndex2D = gammaBinWidthIndexSync
                        Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaSlider.value = sliderValueSync
                        Globals.BackendWrapper.rawDataTwoThetaSliderValue2D = sliderValueSync

                        // turn off the flag to its default value
                        Globals.BackendWrapper.rawDataResetTwoThetaSlider = true
                    }
                    console.debug(`2D View tab (γ-2θ) is selected ::: ${this}. Selected tab index changed to ${Globals.BackendWrapper.rawDataSelectedTabIndex}`)
                }
            },
            EaElements.TabButton {
                text: qsTr('2D View: 2θ Rings')
                onClicked: {
                    Globals.BackendWrapper.rawDataSelectedTabIndex = 2
                    if (!Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                        // set the flag not to reset the slider on tab change
                        Globals.BackendWrapper.rawDataResetTwoThetaSlider = false

                        // save global data values before they are modified on changing binning data 2D
                        let sliderValueSync = Globals.BackendWrapper.rawDataTwoThetaSliderValueSync
                        let sliderIndexSync = Globals.BackendWrapper.rawDataTwoThetaSliderIndexSync
                        let twoThetaBinWidthIndexSync = Globals.BackendWrapper.rawDataTwoThetaBinWidthIndexSync
                        let gammaBinWidthIndexSync = Globals.BackendWrapper.rawDataGammaBinWidthIndexSync

                        // change selected two theta and gamma bin widths
                        Globals.BackendWrapper.rawDataTwoThetaSliderIndex2D = sliderIndexSync
                        Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D = twoThetaBinWidthIndexSync
                        Globals.BackendWrapper.rawDataGammaBinWidthIndex2D = gammaBinWidthIndexSync
                        Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaSlider.value = sliderValueSync
                        Globals.BackendWrapper.rawDataTwoThetaSliderValue2D = sliderValueSync
                        Globals.BackendWrapper.rawDataUpdateSliceData2D(sliderIndexSync)

                        // turn off the flag to its default value
                        Globals.BackendWrapper.rawDataResetTwoThetaSlider = true
                    }
                    console.debug(`2D View tab (2θ rings) is selected ::: ${this}. Selected tab index changed to ${Globals.BackendWrapper.rawDataSelectedTabIndex}`)
                }
            },
            EaElements.TabButton {
                text: qsTr('1D View: γ(2θ)')
                onClicked: {
                    Globals.BackendWrapper.rawDataSelectedTabIndex = 3
                    if (!Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                        // set the flag not to reset the slider on tab change
                        Globals.BackendWrapper.rawDataResetTwoThetaSlider = false

                        // save global data values before they are modified on changing binning data 1D
                        let sliderValueSync = Globals.BackendWrapper.rawDataTwoThetaSliderValueSync
                        let sliderIndexSync = Globals.BackendWrapper.rawDataTwoThetaSliderIndexSync
                        let twoThetaBinWidthIndexSync = Globals.BackendWrapper.rawDataTwoThetaBinWidthIndexSync
                        let gammaBinWidthIndexSync = Globals.BackendWrapper.rawDataGammaBinWidthIndexSync

                        // change selected two theta and gamma bin widths
                        Globals.BackendWrapper.rawDataTwoThetaSliderIndex1D = sliderIndexSync
                        Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex1D = twoThetaBinWidthIndexSync
                        Globals.BackendWrapper.rawDataGammaBinWidthIndex1D = gammaBinWidthIndexSync
                        Globals.References.pages.rawData.sidebar.basic.groups.binning1d.twoThetaSlider.value = sliderValueSync
                        Globals.BackendWrapper.rawDataTwoThetaSliderValue1D = sliderValueSync
                        Globals.BackendWrapper.rawDataUpdateSliceData1D(sliderIndexSync)

                        // turn off the flag to its default value
                        Globals.BackendWrapper.rawDataResetTwoThetaSlider = true
                   }
                    console.debug(`1D View tab is selected ::: ${this}. Selected tab index changed to ${Globals.BackendWrapper.rawDataSelectedTabIndex}`)
                }
            }
        ]

        items: [
            Loader {
                source: 'MainArea/3dSurfaceTab.qml'
            },
            Loader {
                source: 'MainArea/2dHeatmapTab.qml'
            },
            Loader {
                source: 'MainArea/2dPolarHeatmapTab.qml'
            },
            Loader {
                source: 'MainArea/1dLineTab.qml'
            }
        ]
    }

    sideBar: EaComponents.SideBar {
        tabs: [
            EaElements.TabButton { text: qsTr('Basic') },
            EaElements.TabButton { text: qsTr('Extra') }
        ]

        items: [
            Loader { source: 'Sidebar/Basic/Layout.qml' },
            Loader { source: 'Sidebar/Extra/Layout.qml' }
        ]

        continueButton.enabled: Globals.BackendWrapper.rawDataLoaded

        continueButton.onClicked: {
            console.debug(`Clicking '${continueButton.text}' button ::: ${this}`)
            Globals.References.applicationWindow.appBarCentralTabs.correctionsButton.enabled = true
            Globals.References.applicationWindow.appBarCentralTabs.correctionsButton.toggle()
        }
    }

    Component.onCompleted: console.debug(`RawData page loaded ::: ${this}`)
    Component.onDestruction: console.debug(`RawData page destroyed ::: ${this}`)

}
