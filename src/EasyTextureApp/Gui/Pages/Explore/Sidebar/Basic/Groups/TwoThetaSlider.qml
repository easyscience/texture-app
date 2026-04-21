// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


Row {
    width: EaStyle.Sizes.sideBarContentWidth
    spacing: EaStyle.Sizes.fontPixelSize

    // Left label
    EaElements.Label {
        text: slider.from.toFixed(2) + '°'
    }

    // Slider
    EaElements.Slider {
        id: slider
        width: EaStyle.Sizes.sideBarContentWidth
               - EaStyle.Sizes.fontPixelSize * 0.5 - 100
        height: parent.height
        from: Globals.BackendWrapper.exploreMinTwoThetaCenter
        to: Globals.BackendWrapper.exploreMaxTwoThetaCenter
        stepSize: Globals.BackendWrapper.exploreTwoThetaBinWidth
        toolTipText: slider.value + '°'
        // updates slider value only on release
        live: false
        // live update of slider tooltip value
        onPositionChanged: {
            let rawToolTipValue = from + visualPosition * (to - from)
            let toolTipValue = from + Math.round((rawToolTipValue - from) / stepSize) * stepSize
            toolTipText = toolTipValue.toString() + '°'
        }

        onValueChanged: {
            Globals.BackendWrapper.exploreTwoThetaSliderValue = slider.value.toFixed(2)
        }
    }

    // Right label
    EaElements.Label {
        text: slider.to.toFixed(2) + '°'
    }

}
