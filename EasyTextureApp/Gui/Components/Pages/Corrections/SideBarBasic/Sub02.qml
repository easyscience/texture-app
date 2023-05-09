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
    rows: 2
    rowSpacing: EaStyle.Sizes.fontPixelSize

    // EasyApp RadioButton not working
    RadioButton {
        topPadding: 0
        checked: true
        text: qsTr("Apply data correction")
        ToolTip.text: qsTr("Checking this box will apply data correction to the measurement data")
    }

    // EasyApp RadioButton not working
    RadioButton {
        topPadding: 0
        text: qsTr("Use raw data without correction")
        ToolTip.text: qsTr("Checking this box will continue without applying data correction to the measurement data")
    }

}
