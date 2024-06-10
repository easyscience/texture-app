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
    defaultInfo: Globals.Proxies.main.results.isCreated ?
                     "" :
                     qsTr("No Summary Generated")

    mainView: EaComponents.MainContent {
        tabs: [
            EaElements.TabButton {
                text: qsTr("d-Spacing Patterns")
                onClicked: {
                    Globals.Proxies.main.results.isTwoThetaSelected = false
                }
            },
            EaElements.TabButton {
                text: qsTr("2-theta Patterns")
                onClicked: {
                    Globals.Proxies.main.results.isTwoThetaSelected = true
                }
            }
        ]

        items: [
            Loader { source: 'MainContent/Tab_dSpacingPatterns.qml' },
            Loader { source: 'MainContent/Tab_2thetaPatterns.qml' }
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

    Component.onCompleted: print("Results page loaded:", this)
    Component.onDestruction: print("Results page destroyed:", this)
}
