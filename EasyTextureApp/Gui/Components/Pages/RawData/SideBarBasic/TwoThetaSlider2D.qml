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
    rows: 4
    columnSpacing: EaStyle.Sizes.fontPixelSize
    rowSpacing: EaStyle.Sizes.fontPixelSize * 0.5

    // Location
    Row {

        Grid {
            readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5


            columns: 2
            rowSpacing: 10
            //columnSpacing: commonSpacing

            EaElements.Label {
                //font.bold: true
                text: qsTr("2θ: ")
            }
            EaElements.Label {
                text: slider.value.toFixed(2) + "°"
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
            from: 45
            to: 135
            //value: 50

            // TODO: tool tip:
            // make it an int (not double)
            //onHandleChanged: {slider.handle.update()}
            onValueChanged: {
                Globals.Proxies.main.rawData.twoTheta = value.toFixed(2)
                //slider.handle.ToolTip.text = value.toFixed(2)
            }
            //Component.onCompleted: slider.handle.ToolTip.text ="AAA"
        }

        EaElements.Label {
            id: sliderToLabel
            text: slider.to.toFixed(0)
        }
    }
}
