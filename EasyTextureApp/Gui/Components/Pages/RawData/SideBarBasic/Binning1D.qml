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
                        text: qsTr("2θ bin size")
                    }


                    ComboBox {
                        //TwoThetaSlider1D {id: test}
                        //signal BinningChanged()
                        id: cb
                        //values for two_theta_bin_width_1D
                        currentIndex: 0
                        model: ["0.5°", "1°"]
                        //signal comboValueChanged(bool ch)
                        onCurrentIndexChanged: {
                            //onBinningChanged:
                            //slider.resetSlider()
                            TwoThetaSlider1D.resetSlider()
                            //TwoThetaSlider1D.sliderValue = 45.5
                            //print("TESTTTT:", TwoThetaSlider1D.sliderValue)
                            //print("TESTTTT:", parseFloat(cb.textAt(cb.currentIndex)))
                            //binningChanged()
                            Globals.Proxies.main.rawData.updateSliderParameters = true
                            //slider.from: 90
                            Globals.Proxies.main.rawData.slider1DStep = parseFloat(cb.textAt(cb.currentIndex))
                        }

                        //    Globals.Proxies.main.rawData.slider1DStep = parseFloat(cb.currentText)}
                        // currentIndex: 2
                        // model: ["0.1°", "0.25°", "0.5°", "0.75°", "1°", "2°", "5°", "10°"] // default value should be 0.5
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
                        //values for gamma_bin_width_1D
                        model: ["1°", "2°"]
                        // model: ["1°", "2°", "5°", "10°"]// default value should be 1
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
