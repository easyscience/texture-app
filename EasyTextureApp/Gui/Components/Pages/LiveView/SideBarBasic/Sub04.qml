// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

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
            text: slider.from.toFixed(1)
        }

        // Slider
        EaElements.Slider {
            id: slider
            width: EaStyle.Sizes.sideBarContentWidth
                   - EaStyle.Sizes.fontPixelSize * 0.5 - 100
            height: parent.height
            from: 45.5
            to: 134.5
            stepSize: Globals.Proxies.main.liveView.sliderStep

            // TODO: tool tip:
            // make it an int (not double)
            //onHandleChanged: {slider.handle.update()}
            onValueChanged: {
                Globals.Proxies.main.liveView.twoThetaSliderValue = slider.value.toFixed(1)
                //slider.handle.ToolTip.text = value.toFixed(2)
            }
            //value: 90

            // TODO: tool tip:
            // make it an int (not double)

            onPressedChanged: {

            }
        }

        EaElements.Label {
            id: sliderToLabel
            text: slider.to.toFixed(1)
        }

    }

}

