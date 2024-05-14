// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals
import Gui.Components as Components


EaComponents.ContentPage {
    defaultInfo: Globals.Proxies.main.corrections.isCreated ?
                     "" :
                     qsTr("Correction file to be loaded")

    sideBar: EaComponents.SideBar {
        tabs: [
            EaElements.TabButton { text: qsTr("Basic controls") },
            EaElements.TabButton { text: qsTr("Advanced controls") }
        ]

        items: [
            Loader { source: 'SideBarBasic.qml' },
            Loader { source: 'SideBarAdvanced.qml' }
        ]

        continueButton.enabled: !Globals.Proxies.main.corrections.applyDataCorrection
                                || (Globals.Proxies.main.corrections.applyDataCorrection && Globals.Proxies.main.corrections.isCreated)

        continueButton.onClicked: {
            Globals.Vars.explorePageEnabled = true
            Globals.Refs.app.appbar.exploreButton.toggle()
        }

        Component.onCompleted: Globals.Refs.app.correctionsPage.continueButton = continueButton
    }

    Component.onCompleted: print("Corrections page loaded:", this)
    Component.onDestruction: print("Corrections page destroyed:", this)
}
