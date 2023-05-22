// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals

Grid {
    rows: 2
    rowSpacing: 30

    Row {
        Grid {
            columns: 4
            columnSpacing: EaStyle.Sizes.fontPixelSize


            RadioButton {
                topPadding: 0
                checked: true
                text: "1°"
                ToolTip.text: qsTr("Select 1° slice")

                onCheckedChanged: {
                    setRadioStatus(1, text)
                }
            }

            RadioButton {
                topPadding: 0
                text: "2°"
                ToolTip.text: qsTr("Select 2° slice")

                onCheckedChanged: {
                    setRadioStatus(2, text)
                }
            }

            RadioButton {
                topPadding: 0
                text: "5°"
                ToolTip.text: qsTr("Select 5° slice")

                onCheckedChanged: {
                    setRadioStatus(5, text)
                }

            }

            RadioButton {
                topPadding: 0
                text: "10°"
                ToolTip.text: qsTr("Select 10° slice")

                onCheckedChanged: {
                    setRadioStatus(10, text)
                }

            }

        }

    }

    Row {

        Grid {
            readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5

            columns: 2
            rowSpacing: 0
            columnSpacing: commonSpacing

            EaElements.Label {
                enabled: true
                font.bold: true
                text: qsTr("Statistics")
            }

            EaElements.Label {
                enabled: false
                text: qsTr(" ")
            }

            EaElements.Label {
                text: qsTr("Number of Slices (= Number of Patterns):")
            }
            EaElements.Label {
                id: numOfSlices
                text: "xxx"
            }

            EaElements.Label {
                text: qsTr("Intensity Width (in gamma-Degree):")
            }
            EaElements.Label {
                id: intensityWidth
                text: "xxx"
            }

            EaElements.Label {
                text: qsTr("...:")
            }
            EaElements.Label {
                text: "xxx"
            }

        }


    }

    // Logic for Radio Buttons
    function setRadioStatus(id, labelText) {
        print("Explore page: setRadioStatus: ", id, " : ", this)
        numOfSlices.text = labelText

        Globals.Proxies.main.explore.sliceWidth = id

        /*
        Globals.Proxies.main.status.asJson =
                [
                    {
                        name: '2-theta',
                        value: 'CrysPy' // use global variable e.g in Vars, Proxies
                    },
                    {
                        name: 'Slice-Width',
                        value: labelText
                    }
                ]
                */
    }
}



