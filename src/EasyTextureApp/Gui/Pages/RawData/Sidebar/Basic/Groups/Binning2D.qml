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
                            Globals.BackendWrapper.rawDataUpdateTwoThetaSliderData2D(currentIndex)
                            Globals.References.pages.rawData.sidebar.basic.groups.binning2d.twoThetaSlider.value = Globals.BackendWrapper.rawDataMinTwoThetaCenter2D
                            if (Globals.BackendWrapper.rawDataSyncTabsBinningsSliders) {
                                //Globals.BackendWrapper.rawDataUpdateTwoThetaSliderData1D(currentIndex)
                                //Globals.References.pages.rawData.sidebar.basic.groups.binning1d.twoThetaBinWidthIndex.currentIndex = currentIndex
                                //Globals.BackendWrapper.rawDataUpdateTwoThetaSliderData3D(currentIndex)
                                //Globals.References.pages.rawData.sidebar.basic.groups.binning3d.twoThetaBinWidthIndex.currentIndex = currentIndex
                            }
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
                            if (Globals.BackendWrapper.rawDataSyncTabsBinningsSliders) {
                                //Globals.References.pages.rawData.sidebar.basic.groups.binning1d.gammaBinWidthIndex.currentIndex = currentIndex
                                //Globals.References.pages.rawData.sidebar.basic.groups.binning3d.gammaBinWidthIndex.currentIndex = currentIndex
                            }
                        }

                        Component.onCompleted: Globals.References.pages.rawData.sidebar.basic.groups.binning2d.gammaBinWidthIndex = gammaBinWidthIndexSelector2D
                    }
                }
            }
        }
    }
}
