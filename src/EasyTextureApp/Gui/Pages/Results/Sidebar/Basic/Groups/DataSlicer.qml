// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


Column {
    spacing: EaStyle.Sizes.fontPixelSize


    EaElements.Label {
        text: qsTr('γ-slice range: ') + Globals.BackendWrapper.getGammaSliceRange(Globals.BackendWrapper.resultsRingIndexSliderValue)
    }


    Row {
        width: EaStyle.Sizes.sideBarContentWidth
        spacing: EaStyle.Sizes.fontPixelSize

        // Left label
        EaElements.Label {
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
            // updates slider value only on release
            live: false
            // live update of slider tooltip value
            onPositionChanged: {
                let rawToolTipValue = from + visualPosition * (to - from)
                let toolTipValue = from + Math.round((rawToolTipValue - from) / stepSize) * stepSize
                toolTipText = toolTipValue.toString()
            }

            onValueChanged: {
                Globals.BackendWrapper.resultsRingIndexSliderValue = slider.value
            }

            Component.onCompleted: Globals.References.pages.results.sidebar.basic.groups.slicer = slider
        }

        // Right label
        EaElements.Label {
            text: slider.to
        }
    }
}

