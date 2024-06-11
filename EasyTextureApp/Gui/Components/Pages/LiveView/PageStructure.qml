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
    //defaultInfo: Globals.Proxies.main.liveView.isCreated ? // TODO
    //                 "" :
    //                 qsTr("No Project Created/Opened")

    mainView: EaComponents.MainContent {
        tabs: [
            EaElements.TabButton {
                text: qsTr("3D View")
                onClicked: {
                    Globals.Proxies.main.liveView.is3DTabSelected = true
                }

            },
            EaElements.TabButton {
                text: qsTr("2D View: 2θ Rings")
                onClicked: {
                    Globals.Proxies.main.liveView.is3DTabSelected = false
                }
            }
        ]

        items: [
            Loader { source: 'MainContent/LiveTab3D.qml' },
            Loader { source: 'MainContent/LiveTab2DTwoThetaRings.qml' }
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

        continueButton.visible: false
    }

    Component.onCompleted: print("LiveView page loaded:", this)
    Component.onDestruction: print("LiveView page destroyed:", this)
}
