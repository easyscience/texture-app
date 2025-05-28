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

    defaultInfo: Globals.BackendWrapper.exploreCreated ?
                    '' :
                    qsTr('No preview available')

    mainView: EaComponents.MainContent {
        tabs: [
            EaElements.TabButton {
                text: qsTr('2D View: 2θ Rings')
                onClicked: {
                    //Globals.BackendWrapper.rawDataSelectedTabIndex = 0
                    console.debug(`2D View tab is selected in Explore ::: ${this}.`)
                }

            },
            EaElements.TabButton {
                text: qsTr('1D View: γ(2θ)')
                onClicked: {
                    //Globals.BackendWrapper.rawDataSelectedTabIndex = 0
                    console.debug(`1D View tab is selected in Explore ::: ${this}.`)
                }
            }
        ]

        items: [
            Loader {
                source: 'MainArea/ExploreTab2D.qml'
            },
            Loader {
                source: 'MainArea/ExploreTab1D.qml'
            }
        ]
    }

    sideBar: EaComponents.SideBar {
        tabs: [
            EaElements.TabButton { text: qsTr('Basic controls') },
            EaElements.TabButton { text: qsTr('Extra controls') }
            //EaElements.TabButton { text: qsTr('Text mode controls'); enabled: false }
        ]

        items: [
            Loader { source: 'Sidebar/Basic/Layout.qml' },
            Loader { source: 'Sidebar/Extra/Layout.qml' }
            //Loader { source: 'Sidebar/Text/Layout.qml' }
        ]

        continueButton.visible: true

        continueButton.onClicked: {
            console.debug(`Clicking '${continueButton.text}' button ::: ${this}`)
            Globals.References.applicationWindow.appBarCentralTabs.summaryButton.enabled = true
            Globals.References.applicationWindow.appBarCentralTabs.summaryButton.toggle()
        }
    }

    Component.onCompleted: console.debug(`Explore page loaded ::: ${this}`)
    Component.onDestruction: console.debug(`Explore page destroyed ::: ${this}`)

}
