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
    signal indxChanged()

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
                        text: qsTr("2θ bin size")
                    }

                    ComboBox {
                        id: ttBinning2D
                        //values for two_theta_bin_width_2D
                        // currentIndex: 2
                        // model: ["0.1°", "0.25°", "0.5°", "0.75°", "1°", "2°", "5°", "10°"]
                        //currentIndex: 0 //Globals.Proxies.main.rawData.twoThetaIndex
                        currentIndex: Globals.Proxies.main.rawData.twoThetaIndex
                        model: ["0.5°", "1°"]
                        onCurrentIndexChanged: {
                            Globals.Proxies.main.rawData.twoThetaIndex = currentIndex
                            print("CURRENT 2D TT INDX", currentIndex)
                            Globals.Proxies.main.rawData.updateBinned()
                            Globals.Proxies.main.rawData.slider2DStep = parseFloat(ttBinning2D.textAt(ttBinning2D.currentIndex))
                            Globals.Proxies.main.rawData.twoThetaRingsSliderValue = 45.5
                            indxChanged()
                        }
                    }
                }
            }

            Column {
                width: 1/2 * EaStyle.Sizes.sideBarContentWidth

                Row {
                    spacing: EaStyle.Sizes.fontPixelSize

                    EaElements.Label {
                        enabled: true
                        text: qsTr("γ bin size")
                    }

                    ComboBox {
                        //values for gamma_bin_width_2D
                        // model: ["1°", "2°", "5°", "10°"]
                        model: ["1°", "2°"]
                        //currentIndex: 0 // Globals.Proxies.main.rawData.gammaIndex
                        currentIndex: Globals.Proxies.main.rawData.gammaIndex
                        onCurrentIndexChanged: {
                            Globals.Proxies.main.rawData.gammaIndex = currentIndex
                            print("CURRENT 2D GAMMA INDX", currentIndex)
                            Globals.Proxies.main.rawData.updateBinned()
                        }
                    }
                }
            }
        }
    }

    // Select File dialog
    FileDialog {
        id: measurementFileDialog
        title: qsTr("Choose Measurement File")
    }


}
