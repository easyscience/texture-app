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
    property int currentPageIndex: EaGlobals.Variables.appBarCurrentIndex

    visible: {
        // default
        currentPageIndex !== 0
    }

    model: EaComponents.JsonListModel {
        id: statusBarModel
        json: ""
        query: "$[*]"
    }

    onCurrentPageIndexChanged: {
        if (currentPageIndex == 7){
            statusBarModel.json = JSON.stringify(Globals.Proxies.main.status.liveViewStatusBar)
        }
        else if (currentPageIndex > 3){
            statusBarModel.json = JSON.stringify(Globals.Proxies.main.status.twoThetaRingsStatusBar)
        }
        else
        {
            statusBarModel.json = JSON.stringify(Globals.Proxies.main.status.projectStatusBar)
        }
    }
}
