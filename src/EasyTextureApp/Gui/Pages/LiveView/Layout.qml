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

    defaultInfo: Globals.BackendWrapper.liveViewConnected ?
                 '' :
                 qsTr('Live view disconnected')

    mainView: EaComponents.MainContent {
        tabs: [
            EaElements.TabButton {
                text: qsTr('3D Live View')
                onClicked: {
                    Globals.BackendWrapper.liveViewSelectedTabIndex = 0
                    console.debug(`3D view tab of LiveView is selected ::: ${this}. Selected tab index changed to ${Globals.BackendWrapper.rawDataSelectedTabIndex}`)
                }
            },
            EaElements.TabButton {
                text: qsTr('2D Live View: 2θ Rings')
                onClicked: {
                    Globals.BackendWrapper.liveViewSelectedTabIndex = 1
                    console.debug(`2D view tab of LiveView is selected ::: ${this}. Selected tab index changed to ${Globals.BackendWrapper.rawDataSelectedTabIndex}`)
                }
            }
        ]

        items: [
            Loader {
                source: 'MainArea/3dSurfaceLive.qml'
            },
            Loader {
                source: 'MainArea/2dPolarHeatmapLive.qml'
            }
        ]
    }

    sideBar: EaComponents.SideBar {
        tabs: [
            EaElements.TabButton { text: qsTr('Basic controls') },
            EaElements.TabButton { text: qsTr('Extra controls') },
            EaElements.TabButton { text: qsTr('Text mode controls'); enabled: false }
        ]

        items: [
            Loader { source: 'Sidebar/Basic/Layout.qml' },
            Loader { source: 'Sidebar/Extra/Layout.qml' },
            Loader { source: 'Sidebar/Text/Layout.qml' }
        ]

        continueButton.enabled: true //Globals.BackendWrapper.rawDataLoaded
        continueButton.text: 'Back to offline data processing'

        continueButton.onClicked: {
            console.debug(`Clicking '${continueButton.text}' button ::: ${this}`)
            Globals.References.applicationWindow.appBarCentralTabs.homeButton.enabled = true
            Globals.References.applicationWindow.appBarCentralTabs.liveViewButton.enabled = false
            Globals.References.applicationWindow.appBarCentralTabs.homeButton.toggle()
            Globals.BackendWrapper.liveViewConnected = false
        }
    }

    Component.onCompleted: console.debug(`LiveView page loaded ::: ${this}`)
    Component.onDestruction: console.debug(`LiveView page destroyed ::: ${this}`)

}
