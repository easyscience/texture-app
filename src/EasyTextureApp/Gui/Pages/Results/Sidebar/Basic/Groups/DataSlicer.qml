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
    rowSpacing: 20
    property alias sliderItem: slider

    Row {

        Grid {
            columns: 2
            readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5

            EaElements.Label {
                text: qsTr('γ-Slice Range: ')
            }

            EaElements.Label {
                text: Globals.BackendWrapper.getGammaSliceRange(Globals.BackendWrapper.resultsRingIndexSliderValue)
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
            text: slider.from
        }

        // Slider
        EaElements.Slider {
            id: slider
            width: EaStyle.Sizes.sideBarContentWidth
                   - EaStyle.Sizes.fontPixelSize * 0.5 - 100
            height: parent.height
            from: Globals.BackendWrapper.resultsMinSliderValue
            to: Globals.BackendWrapper.resultsMaxSliderValue
            stepSize: 1
            toolTipText: slider.value
            //value: Globals.References.pages.results.sidebar.basic.groups.slicer.sliderValue

            onValueChanged: {
                Globals.BackendWrapper.resultsRingIndexSliderValue = slider.value
            }

            Component.onCompleted: Globals.References.pages.results.sidebar.basic.groups.slicer = slider
        }

        EaElements.Label {
            id: sliderToLabel
            text: slider.to
        }
    }
}

