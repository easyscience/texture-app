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
    id: slideRow

    width: EaStyle.Sizes.sideBarContentWidth
    height: 50 //parent.height

    spacing: 10


    EaElements.Label {
        id: sliderFromLabel
        text: slider.from.toFixed(2)  + '°'
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
        onValueChanged: {
            Globals.BackendWrapper.exploreTwoThetaSliderValue = slider.value.toFixed(2)
        }
    }

    EaElements.Label {
        id: sliderToLabel
        text: slider.to.toFixed(2) + '°'
    }

}
