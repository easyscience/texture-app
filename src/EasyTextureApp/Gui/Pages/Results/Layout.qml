// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.ContentPage {

    defaultInfo: Globals.BackendWrapper.resultsCreated ?
                     '' :
                     qsTr('No Results Generated')

    mainView: EaComponents.MainContent {
        tabs: [
            EaElements.TabButton {
                text: qsTr('d-Spacing Patterns')
                onClicked: {
                    Globals.BackendWrapper.resultsSelectedTabIndex = 0
                }
            },
            EaElements.TabButton {
                text: qsTr('2θ Patterns')
                onClicked: {
                    Globals.BackendWrapper.resultsSelectedTabIndex = 1
                }
            },
            EaElements.TabButton {
                text: qsTr('2θ Integrated Pattern')
                onClicked: {
                    Globals.BackendWrapper.resultsSelectedTabIndex = 2
                }
            }
        ]

        items: [
            Loader { source: 'MainArea/dSpacingTab.qml' },
            Loader { source: 'MainArea/TwoThetaTab.qml' },
            Loader { source: 'MainArea/IntegratedTwoThetaTab.qml' }
        ]
    }

    sideBar: EaComponents.SideBar {
        tabs: [
            EaElements.TabButton { text: qsTr('Basic controls') },
            EaElements.TabButton { text: qsTr('Extra controls') }
        ]

        items: [
            Loader { source: 'Sidebar/Basic/Layout.qml' },
            Loader { source: 'Sidebar/Extra/Layout.qml' }
        ]

        continueButton.visible: false
    }

    Component.onCompleted: console.debug(`Results page loaded ::: ${this}`)
    Component.onDestruction: console.debug(`Results page destroyed ::: ${this}`)

}
