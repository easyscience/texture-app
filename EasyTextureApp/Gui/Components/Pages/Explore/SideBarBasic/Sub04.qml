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
    readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5

    columns: 2
    rowSpacing: 0
    columnSpacing: commonSpacing

    EaElements.Label {
        text: qsTr("Number of Slices (= Number of Patterns):")
    }
    EaElements.Label {
        text: "xxx"
    }

    EaElements.Label {
        text: qsTr("Intensity Width (in gamma-Degree):")
    }
    EaElements.Label {
        text: "xxx"
    }

    EaElements.Label {
        text: qsTr("...:")
    }
    EaElements.Label {
        text: "xxx"
    }

}
