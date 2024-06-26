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
import Gui.Elements as Elements


Elements.StatusBar {
    visible: EaGlobals.Variables.appBarCurrentIndex !== 0 && EaGlobals.Variables.appBarCurrentIndex !== 7


    Elements.StatusBarItem {
        //keyIcon: 'archive'
        keyText: qsTr('Project:')
        valueText: Globals.Proxies.main.status.project ?? ''
        //ToolTip.text: qsTr('Current project')
    }

    Elements.StatusBarItem {
        //keyIcon: 'layer-group'
        keyText: qsTr('Loaded file:')
        valueText: Globals.Proxies.main.status.selectedRawDataFile ?? ''
        //ToolTip.text: qsTr('Number of models added')
    }

    Elements.StatusBarItem {
        //keyIcon: 'microscope'
        keyText: qsTr('2θ: ')
        valueText: Globals.Proxies.main.status.selectedTwoTheta ?? ''
        //ToolTip.text: qsTr('Number of experiments added')
    }

    Elements.StatusBarItem {
        //keyIcon: 'calculator'
        keyText: qsTr('Slice-Width:')
        valueText: Globals.Proxies.main.status.selectedGammaSliceWidth ?? ''
        //ToolTip.text: qsTr('Current calculation engine')
    }

}


