// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals

Row {

    EaElements.RadioButton {
        id: yesButton
        checked: Globals.BackendWrapper.rawDataSyncTabsBinningsSliders
        //enabled: false
        text: 'Yes'
        onClicked: {
            Globals.BackendWrapper.rawDataSyncTabsBinningsSliders = true
        }
    }

    EaElements.RadioButton {
        id: noButton
        checked: !Globals.BackendWrapper.rawDataSyncTabsBinningsSliders
        //enabled: false
        text: 'No'
        onClicked: {
            Globals.BackendWrapper.rawDataSyncTabsBinningsSliders = false
        }
    }

}

