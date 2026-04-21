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

    EaElements.RadioButton {
        id: oneDegreeButton

        checked: true
        text: '1°'

        onClicked: {
            Globals.BackendWrapper.exploreGammaBinWidth = 1.0
            //Globals.References.pages.results.sidebar.basic.groups.slicer.value = 1
            console.debug(`In ${this}: gamma bin width 1 selected`)
        }

    }

    EaElements.RadioButton {
        id: twoDegreeButton

        text: '2°'

        onClicked: {
            Globals.BackendWrapper.exploreGammaBinWidth = 2.0
            //Globals.References.pages.results.sidebar.basic.groups.slicer.value = 1
            console.debug(`In ${this}: gamma bin width 2 selected`)
        }

    }

    EaElements.RadioButton {
        id: fiveDegreeButton

        enabled: false
        text: '5°'

        contentItem: Text {
            text: fiveDegreeButton.text
            color: 'grey'
            leftPadding: fiveDegreeButton.indicator.width + fiveDegreeButton.spacing
        }

        onClicked: {
            Globals.BackendWrapper.exploreGammaBinWidth = 5.0
            //Globals.References.pages.results.sidebar.basic.groups.slicer.value = 1
            console.debug(`In ${this}: gamma bin width 5 selected`)
        }

    }

    EaElements.RadioButton {
        id: tenDegreeButton

        enabled: false
        text: '10°'

        contentItem: Text {
            text: tenDegreeButton.text
            color: 'grey'
            leftPadding: tenDegreeButton.indicator.width + tenDegreeButton.spacing
        }

        onClicked: {
            Globals.BackendWrapper.exploreGammaBinWidth = 10.0
            //Globals.References.pages.results.sidebar.basic.groups.slicer.value = 1
            console.debug(`In ${this}: gamma bin width 10 selected`)
        }
    }
}

