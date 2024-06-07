// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


Grid{
    rows: 3
    rowSpacing: 30
    property alias sliderValue: slider.value

    Row {

        Grid {
            readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5


            columns: 2
            rowSpacing: 10
            //columnSpacing: commonSpacing

            EaElements.Label {
                //font.bold: true
                text: qsTr("2θ = ")
            }
            EaElements.Label {
                text: slider.value.toFixed(2)
            }
        }

    }

    Row {
        id: slideRow

        width: EaStyle.Sizes.sideBarContentWidth
        height: 50 //parent.height

        spacing: 10


        EaElements.Label {
            id: sliderFromLabel
            text: slider.from.toFixed(2)
        }

        // Slider
        EaElements.Slider {
            id: slider
            width: EaStyle.Sizes.sideBarContentWidth
                   - EaStyle.Sizes.fontPixelSize * 0.5 - 100
            height: parent.height
            from: 45.5
            to: 134.5
            stepSize: Globals.Proxies.main.explore.twoThetaSliderStep
            //value: 90

            // TODO: tool tip:
            // make it an int (not double)

            onValueChanged: Globals.Proxies.main.explore.twoThetaSliderValue = value.toFixed(1)
        }

        EaElements.Label {
            id: sliderToLabel
            text: slider.to.toFixed(2)
        }

    }


    Row {


        Grid {
            columns: 2
            columnSpacing: EaStyle.Sizes.fontPixelSize

            Column {
                width: 1/2 * EaStyle.Sizes.sideBarContentWidth

                EaElements.Label {
                    enabled: true
                    font.bold: true
                    text: qsTr("Statistics")
                }

                EaElements.Label {
                    enabled: false
                    text: qsTr("Current 2-theta Ring")
                }

                //Grid
                Grid {
                    readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5

                    columns: 2
                    rowSpacing: 0
                    columnSpacing: commonSpacing

                    EaElements.Label {
                        font.bold: true
                        text: qsTr("Count Max:")
                    }
                    EaElements.Label {
                        text: "xxx"
                    }

                    EaElements.Label {
                        visible: Globals.Proxies.main.project.location !== '--- EXAMPLE ---'
                        font.bold: true
                        text: qsTr("Count Min:")
                    }
                    EaElements.Label {
                        text: "xxx"
                    }


                    EaElements.Label {
                        font.bold: true
                        text: qsTr("Count Sum:")
                    }
                    EaElements.Label {
                        text: "xxx"
                    }

                } // Grid


            }

            Column {
                EaElements.Label {
                    enabled: false
                    text: qsTr(" ")
                }

                EaElements.Label {
                    enabled: false
                    text: qsTr("Total")
                }

                //Grid
                Grid {
                    readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5

                    columns: 2
                    rowSpacing: 0
                    columnSpacing: commonSpacing

                    EaElements.Label {
                        font.bold: true
                        text: qsTr("Count Max:")
                    }
                    EaElements.Label {
                        text: "xxx"
                    }

                    EaElements.Label {
                        visible: Globals.Proxies.main.project.location !== '--- EXAMPLE ---'
                        font.bold: true
                        text: qsTr("Count Min:")
                    }
                    EaElements.Label {
                        text: "xxx"
                    }


                    EaElements.Label {
                        font.bold: true
                        text: qsTr("Count Sum:")
                    }
                    EaElements.Label {
                        text: "xxx"
                    }

                } // Grid close
            }

            // Logic

            function inputFieldWidth() {
                return (EaStyle.Sizes.sideBarContentWidth - columnSpacing * (columns - 1)) / columns
            }

        }


    }

}



