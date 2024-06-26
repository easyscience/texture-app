// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls
//import QtQuick.XmlListModel 2.15

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals
import Gui.Components as Components


EaComponents.ContentPage {
    defaultInfo: (Globals.Proxies.main.corrections.isCreated || !Globals.Proxies.main.corrections.applyDataCorrection) ?
                     "" :
                     qsTr("No analysis done")

    mainView: EaComponents.MainContent {
        tabs: [
            EaElements.TabButton { text: qsTr("2θ Rings") }
            //EaElements.TabButton { text: qsTr("3D View") }
        ]

        items: [
            Loader { source: 'MainContent/ExploreTab2DTwoThetaRings.qml' }
            //Loader { source: 'MainContent/Tab_3d.qml' }
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

        continueButton.onClicked: {
            Globals.Vars.resultsPageEnabled = true
            Globals.Refs.app.appbar.resultsButton.toggle()
        }

        Component.onCompleted: Globals.Refs.app.explorePage.continueButton = continueButton
    }

    Component.onCompleted: {
        print("Explore page loaded:", this)
        Globals.Proxies.main.explore.gammaSliceWidth = 1
    }

    Component.onDestruction: print("Explore page destroyed:", this)
}
