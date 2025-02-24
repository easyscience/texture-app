// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls
//import QtQuick.XmlListModel 2.15

import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals

EaElements.StatusBar {
    visible: EaGlobals.Vars.appBarCurrentIndex !== 0 && EaGlobals.Vars.appBarCurrentIndex !== 7

    EaElements.StatusBarItem {
        keyIcon: 'archive'
        keyText: qsTr('Project:')
        valueText: Globals.Proxies.main.status.project ?? ''
        ToolTip.text: qsTr('Current project')
    }

    EaElements.StatusBarItem {
        keyIcon: 'database'
        keyText: qsTr('Loaded file:')
        valueText: Globals.Proxies.main.status.selectedRawDataFile ?? ''
        ToolTip.text: qsTr('Selected file')
    }

    EaElements.StatusBarItem {
        keyIcon: 'signal'
        keyText: qsTr('2θ: ')
        valueText: Globals.Proxies.main.status.selectedTwoTheta ?? ''
        ToolTip.text: qsTr('Selected two theta angle')
    }

    EaElements.StatusBarItem {
        keyIcon: 'circle'
        keyText: qsTr('Slice-Width:')
        valueText: Globals.Proxies.main.status.selectedGammaSliceWidth ?? ''
        ToolTip.text: qsTr('Selected gamma slice width')
    }

}


