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
                    Globals.BackendWrapper.rawDataNewTab = true
                    Globals.BackendWrapper.rawDataSelectedTabIndex = 0
                    if (Globals.BackendWrapper.rawDataSyncTabsSliders) {
                        Globals.References.pages.rawData.sidebar.basic.groups.binning3d.twoThetaSlider.value = Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue
                        Globals.BackendWrapper.rawDataTwoThetaSliderValue3D = Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue
                    }
                    if (Globals.BackendWrapper.rawDataSyncTabsBinnings) {
                        //Globals.References.pages.rawData.sidebar.basic.groups.binning3d.twoThetaBinWidthIndex.currentIndex = Globals.BackendWrapper.rawDataSyncedTwoThetaBinWidthIndex
                        Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex3D = Globals.BackendWrapper.rawDataSyncedTwoThetaBinWidthIndex
                        //Globals.References.pages.rawData.sidebar.basic.groups.binning3d.gammaBinWidthIndex.currentIndex = Globals.BackendWrapper.rawDataSyncedGammaBinWidthIndex
                        Globals.BackendWrapper.rawDataGammaBinWidthIndex3D = Globals.BackendWrapper.rawDataSyncedGammaBinWidthIndex
                    }
                    Globals.BackendWrapper.rawDataNewTab = false
                    console.debug(`3D View tab is selected ::: ${this}. Selected tab index changed to ${Globals.BackendWrapper.rawDataSelectedTabIndex}`)
                }
            },
            EaElements.TabButton {
                text: qsTr('2D View: γ-2θ')
                onClicked: {
                    console.debug(`2D View tab (γ-2θ) is clicked`)
                    Globals.BackendWrapper.rawDataNewTab = true
                    Globals.BackendWrapper.rawDataSelectedTabIndex = 1
                    print('Clicked0')
                    if (Globals.BackendWrapper.rawDataSyncTabsSliders) {
                        print('Clicked1', Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue)
                        Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaSlider.value = Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue
                        print('Clicked2')
                        Globals.BackendWrapper.rawDataTwoThetaSliderValue2D = Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue
                        print('Clicked3', Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D)
                    }
                    //let sv = Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue
                    if (Globals.BackendWrapper.rawDataSyncTabsBinnings) {
                        print('Clicked4', Globals.BackendWrapper.rawDataSyncedTwoThetaBinWidthIndex)
                        //Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaBinWidthIndex.currentIndex = Globals.BackendWrapper.rawDataSyncedTwoThetaBinWidthIndex
                        Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D = Globals.BackendWrapper.rawDataSyncedTwoThetaBinWidthIndex
                        print('Clicked5', Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D)
                        //Globals.References.pages.rawData.sidebar.basic.groups.binning2d.gammaBinWidthIndex.currentIndex = Globals.BackendWrapper.rawDataSyncedGammaBinWidthIndex
                        Globals.BackendWrapper.rawDataGammaBinWidthIndex2D = Globals.BackendWrapper.rawDataSyncedGammaBinWidthIndex
                        print('Clicked6')
                    }

                    Globals.BackendWrapper.rawDataNewTab = false
                    console.debug(`2D View tab (γ-2θ) is selected ::: ${this}. Selected tab index changed to ${Globals.BackendWrapper.rawDataSelectedTabIndex}`)
                }
            },
            EaElements.TabButton {
                text: qsTr('2D View: 2θ Rings')
                onClicked: {
                    Globals.BackendWrapper.rawDataSelectedTabIndex = 2
                    if (Globals.BackendWrapper.rawDataSyncTabsSliders) {
                        Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaSlider.value = Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue
                        Globals.BackendWrapper.rawDataTwoThetaSliderValue2D = Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue
                    }
                    if (Globals.BackendWrapper.rawDataSyncTabsBinnings) {
                        //Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaBinWidthIndex.currentIndex = Globals.BackendWrapper.rawDataSyncedTwoThetaBinWidthIndex
                        Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D = Globals.BackendWrapper.rawDataSyncedTwoThetaBinWidthIndex
                        //Globals.References.pages.rawData.sidebar.basic.groups.binning2d.gammaBinWidthIndex.currentIndex = Globals.BackendWrapper.rawDataSyncedGammaBinWidthIndex
                        Globals.BackendWrapper.rawDataGammaBinWidthIndex2D = Globals.BackendWrapper.rawDataSyncedGammaBinWidthIndex
                    }

                    console.debug(`2D View tab (2θ rings) is selected ::: ${this}. Selected tab index changed to ${Globals.BackendWrapper.rawDataSelectedTabIndex}`)
                }
            },
            EaElements.TabButton {
                text: qsTr('1D View: γ(2θ)')
                onClicked: {
                    Globals.BackendWrapper.rawDataSelectedTabIndex = 3
                    if (Globals.BackendWrapper.rawDataSyncTabsSliders) {
                        Globals.References.pages.rawData.sidebar.basic.groups.binning1d.twoThetaSlider.value = Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue
                        Globals.BackendWrapper.rawDataTwoThetaSliderValue1D = Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue
                    }
                    if (Globals.BackendWrapper.rawDataSyncTabsBinnings) {
                       // Globals.References.pages.rawData.sidebar.basic.groups.binning1d.twoThetaBinWidthIndex.currentIndex = Globals.BackendWrapper.rawDataSyncedTwoThetaBinWidthIndex
                        Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex1D = Globals.BackendWrapper.rawDataSyncedTwoThetaBinWidthIndex
                        //Globals.References.pages.rawData.sidebar.basic.groups.binning1d.gammaBinWidthIndex.currentIndex = Globals.BackendWrapper.rawDataSyncedGammaBinWidthIndex
                        Globals.BackendWrapper.rawDataGammaBinWidthIndex1D = Globals.BackendWrapper.rawDataSyncedGammaBinWidthIndex
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
            EaElements.TabButton { text: qsTr('Basic controls') },
            EaElements.TabButton {
                text: qsTr('Extra controls')
                //enabled: false
            },
            EaElements.TabButton { text: qsTr('Text mode controls'); enabled: false }
        ]

        items: [
            Loader { source: 'Sidebar/Basic/Layout.qml' },
            Loader { source: 'Sidebar/Extra/Layout.qml' },
            Loader { source: 'Sidebar/Text/Layout.qml' }
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
