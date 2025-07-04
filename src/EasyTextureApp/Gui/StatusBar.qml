// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaElements.StatusBar {

    visible: EaGlobals.Vars.appBarCurrentIndex !== 0

    EaElements.StatusBarItem {
        keyIcon: 'archive'
        keyText: qsTr('Project')
        valueText: Globals.BackendWrapper.statusProject
        visible: Globals.BackendWrapper.statusProjectVisible
        ToolTip.text: qsTr('Current project')
    }

    EaElements.StatusBarItem {
        keyIcon: 'layer-group'
        keyText: qsTr('Loaded file')
        valueText: Globals.BackendWrapper.statusRawDataFile
        visible: Globals.BackendWrapper.statusRawDataFileVisible
        ToolTip.text: qsTr('Selected datafile with raw data')
    }

    EaElements.StatusBarItem {
        keyIcon: 'microscope'
        keyText: qsTr('γ-slice width')
        valueText: Globals.BackendWrapper.statusGammaSliceWidth + '°'
        visible: Globals.BackendWrapper.statusGammaSliceWidthVisible
        ToolTip.text: qsTr('Selected gamma slice width for generating d- and 2θ-patterns')
    }

}
