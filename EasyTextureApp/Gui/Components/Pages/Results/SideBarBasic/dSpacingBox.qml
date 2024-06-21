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
    rows: 2
    rowSpacing: 30
    property alias sliderValue: slider.value

    Row {

        Grid {
            readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5


            columns: 2
            rowSpacing: 10
            //columnSpacing: commonSpacing

            EaElements.Label {
                text: qsTr("γ-Slice Range: ")
            }

            EaElements.Label {
                text: getGammaSliceRange()
            }

            EaElements.Label {
                //font.bold: true
                text: qsTr("Slice/Pattern Number: ")
            }
            EaElements.Label {
                text: slider.value.toFixed(0)
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
            text: slider.from.toFixed(0)
        }

        // Slider
        EaElements.Slider {
            id: slider
            width: EaStyle.Sizes.sideBarContentWidth
                   - EaStyle.Sizes.fontPixelSize * 0.5 - 100
            height: parent.height
            from: 1
            to: Globals.Proxies.main.results.sliderMaxValue
            stepSize: 1

            //value: (360 / Globals.Proxies.main.explore.gammaSliceWidth ) / 2

            // TODO: tool tip:
            // make it an int (not double)

            onValueChanged: Globals.Proxies.main.results.sliderValue = value.toFixed(0)
        }

        EaElements.Label {
            id: sliderToLabel
            text: slider.to.toFixed(0)
        }

    }


    // Logic for Radio Buttons
    function getGammaSliceRange() {

        var currSliceNo = slider.value.toFixed(0)  - 1

        var gammaSliceWidth = 360 / Globals.Proxies.main.results.sliderMaxValue

        var gammaSliceA = currSliceNo * gammaSliceWidth
        var gammaSliceB = gammaSliceA + gammaSliceWidth

        var gammaRange = gammaSliceA.toString() + "° - " + gammaSliceB.toString() + "°"
        return gammaRange

    }

}
