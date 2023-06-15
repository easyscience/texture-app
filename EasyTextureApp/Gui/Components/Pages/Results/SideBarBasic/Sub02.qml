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

    Row {

        Grid {
            readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5


            columns: 2
            rowSpacing: 10
            //columnSpacing: commonSpacing

            EaElements.Label {
                //font.bold: true
                text: qsTr("Slice/Pattern Number: ")
            }
            EaElements.Label {
                text: slider.value.toFixed(0) // TODO: putthis info on the TAB
            }

            EaElements.Label {
                text: qsTr("gamma-Slice Range: ")
            }

            EaElements.Label {
                text: getGammaSliceRange()
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
            to: 360 / Globals.Proxies.main.explore.sliceWidth
            value: (360 / Globals.Proxies.main.explore.sliceWidth ) / 2
            // TODO: tool tip: make it an int (not double)
            onPressedChanged: {

            }
        }

        EaElements.Label {
            id: sliderToLabel
            text: slider.to.toFixed(0)
        }

    }


    // Logic for Radio Buttons
    function getGammaSliceRange() {

        var currSliceNo = slider.value.toFixed(0) - 1

        var sliceWidth = Globals.Proxies.main.explore.sliceWidth

        var gammaSliceA = currSliceNo * sliceWidth
        var gammaSliceB = gammaSliceA + sliceWidth

        var gammaRange = gammaSliceA.toString() + "° - " + gammaSliceB.toString() + "°"
        return gammaRange

    }

}
