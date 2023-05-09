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
    columns: 4
    columnSpacing: EaStyle.Sizes.fontPixelSize


    // EasyApp RadioButton not working
    RadioButton {
        topPadding: 0
        checked: true
        text: "1°"
        ToolTip.text: qsTr("Select 1° slice")
    }

    // EasyApp RadioButton not working
    RadioButton {
        topPadding: 0
        text: "2°"
        ToolTip.text: qsTr("Select 2° slice")
    }

    // EasyApp RadioButton not working
    RadioButton {
        topPadding: 0
        text: "5°"
        ToolTip.text: qsTr("Select 5° slice")
    }

    // EasyApp RadioButton not working
    RadioButton {
        topPadding: 0
        text: "10°"
        ToolTip.text: qsTr("Select 10° slice")
    }

}
