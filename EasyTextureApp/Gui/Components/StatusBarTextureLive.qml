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
    id: liveviewbar
    visible: EaGlobals.Vars.appBarCurrentIndex == 7

    Elements.StatusBarItem {
        //keyIcon: 'archive'
        keyText: qsTr('Project:')
        valueText: 'Live1' //Globals.Proxies.main.status.project ?? ''
        //ToolTip.text: qsTr('Current project')
    }

    Elements.StatusBarItem {
        //keyIcon: 'layer-group'
        keyText: qsTr('Loaded file:')
        valueText: 'Live2' //Globals.Proxies.main.status.selectedRawDataFile ?? ''
        //ToolTip.text: qsTr('Number of models added')
    }

}
