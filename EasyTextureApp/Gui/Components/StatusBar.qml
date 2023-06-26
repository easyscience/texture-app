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
    visible: {
        // default:
        // EaGlobals.Variables.appBarCurrentIndex !== 0

        // define which pages show the status bar:
        EaGlobals.Variables.appBarCurrentIndex === EaGlobals.Variables.AppBarIndexEnum.ExplorePageIndex
        || EaGlobals.Variables.appBarCurrentIndex === EaGlobals.Variables.AppBarIndexEnum.ResultsPageIndex
    }


    model: EaComponents.JsonListModel {
        json: JSON.stringify(Globals.Proxies.main.status.asJson)
        query: "$[*]"
    }

}


