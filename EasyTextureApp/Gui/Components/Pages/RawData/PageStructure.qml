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
    defaultInfo: Globals.Proxies.main.rawData.isCreated ?
                     "" :
                     qsTr("No measurement files loaded")

    mainView: EaComponents.MainContent {
        tabs: [
            EaElements.TabButton { text: qsTr("Preview: Detector 1D") },
            EaElements.TabButton { text: qsTr("Preview: Detector 2D") },
            EaElements.TabButton { text: qsTr("Preview: Detector 3D Scatter Plot") },
            EaElements.TabButton { text: qsTr("Preview: Detector 3D Surface Plot") }
        ]

        items: [
            Loader { source: 'MainContent/Tab_1dPreview.qml' },
            Loader { source: 'MainContent/Tab_2dPreview.qml' },
            Loader { source: 'MainContent/Tab_3dPreviewScatter.qml' },
            Loader { source: 'MainContent/Tab_3dPreviewSurface.qml' }
        ]
    }

    sideBar: EaComponents.SideBar {
        tabs: [
            EaElements.TabButton { text: qsTr("Basic controls") },
            EaElements.TabButton { text: qsTr("Advanced controls") }
        ]

        items: [
            Loader { source: 'SideBarBasic.qml' },
            Loader { source: 'SideBarAdvanced.qml' }
        ]

        // debug:
        //continueButton.text: Globals.Proxies.main.rawData.isCreated ?
        //                         qsTr("Continue") :
        //                         qsTr("Continue (rawData isCreated == false)")
        continueButton.enabled: Globals.Proxies.main.rawData.isCreated

        continueButton.onClicked: {
            Globals.Vars.correctionsPageEnabled = true
            Globals.Refs.app.appbar.correctionsButton.toggle()
        }

        Component.onCompleted: Globals.Refs.app.rawDataPage.continueButton = continueButton
    }

    Component.onCompleted: print("RawData page loaded:", this)
    Component.onDestruction: print("RawData page destroyed:", this)
}
