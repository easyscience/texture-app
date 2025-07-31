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
    rows: 1
    columnSpacing: EaStyle.Sizes.fontPixelSize
    //rowSpacing: EaStyle.Sizes.fontPixelSize * 0.5

    // Location
    Row {
        Grid {
            columns: 2
            columnSpacing: EaStyle.Sizes.fontPixelSize

            Column {
                width: 1/2 * EaStyle.Sizes.sideBarContentWidth

                Row {
                    spacing: EaStyle.Sizes.fontPixelSize

                    EaElements.Label {
                        enabled: true
                        text: qsTr('2θ bin size')
                    }

                    ComboBox {
                        id: twoThetaBinWidthIndexSelector2D
                        //values for two_theta_bin_width_2D
                        // currentIndex: 2
                        // model: ['0.1°', '0.25°', '0.5°', '0.75°', '1°', '2°', '5°', '10°']
                        model: ['0.5°', '1°']
                        currentIndex: Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D

                        onCurrentIndexChanged: {
                            if (Globals.BackendWrapper.rawDataNewTab && Globals.BackendWrapper.rawDataSyncTabsSliders) {
                                print('IN GOOD LOoP', Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue)
                                Globals.BackendWrapper.rawDataTwoThetaSliderValue2D = Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue
                                Globals.BackendWrapper.rawDataUpdateTwoThetaSliderData2D(currentIndex, false)

                                print('IN GOOD LOoP2', Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue)
                                Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaSlider.value = Globals.BackendWrapper.rawDataTwoThetaSyncedSliderValue
                            } else {
                                print('IN BAD LOoP')
                                Globals.BackendWrapper.rawDataUpdateTwoThetaSliderData2D(currentIndex, true)
                                Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaSlider.value = Globals.BackendWrapper.rawDataMinTwoThetaCenter2D
                            }
                            Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D = currentIndex
                            print('BIN WIDTH INDX', Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D)
                            if (Globals.BackendWrapper.rawDataSyncTabsBinnings) {
                                Globals.BackendWrapper.rawDataSyncedTwoThetaBinWidthIndex = currentIndex
                                console.debug(`In ${this}: rawDataSyncedTwoThetaBinWidthIndex changed to ${Globals.BackendWrapper.rawDataSyncedTwoThetaBinWidthIndex}`)
                            }
                            console.debug(`In ${this}: rawDataTwoThetaBinWidthIndex2D changed to ${Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D}`)
                        }

                        Component.onCompleted: Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaBinWidthIndex = twoThetaBinWidthIndexSelector2D
                    }
                }
            }

            Column {
                width: 1/2 * EaStyle.Sizes.sideBarContentWidth

                Row {
                    spacing: EaStyle.Sizes.fontPixelSize

                    EaElements.Label {
                        enabled: true
                        text: qsTr('γ bin size')
                    }

                    ComboBox {
                        id: gammaBinWidthIndexSelector2D
                        //values for gamma_bin_width_2D
                        // model: ['1°', '2°', '5°', '10°']
                        model: ['1°', '2°']
                        currentIndex: Globals.BackendWrapper.rawDataGammaBinWidthIndex2D

                        onCurrentIndexChanged: {
                            Globals.BackendWrapper.rawDataUpdateGammaBinWidth2D(currentIndex)
                            Globals.BackendWrapper.rawDataGammaBinWidthIndex2D = currentIndex
                            if (Globals.BackendWrapper.rawDataSyncTabsBinnings) {
                                Globals.BackendWrapper.rawDataSyncedGammaBinWidthIndex = currentIndex
                                console.debug(`In ${this}: rawDataSyncedGammaBinWidthIndex changed to ${Globals.BackendWrapper.rawDataSyncedGammaBinWidthIndex}`)
                            }
                            console.debug(`In ${this}: rawDataGammaBinWidthIndex2D changed to ${Globals.BackendWrapper.rawDataGammaBinWidthIndex2D}`)

                        }

                        Component.onCompleted: Globals.References.pages.rawData.sidebar.basic.groups.binning2d.gammaBinWidthIndex = gammaBinWidthIndexSelector2D
                    }
                }
            }
        }
    }
}
