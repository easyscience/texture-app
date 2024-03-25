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
            EaElements.TabButton {
                text: qsTr("3D View: Detector Inner Surface")
                onClicked: {
                    Globals.Proxies.main.rawData.is3DtabSelected = true
                    Globals.Proxies.main.rawData.is2DtabSelected = false
                    Globals.Proxies.main.rawData.is1DtabSelected = false
                }
            },
            EaElements.TabButton {
                text: qsTr("2D View: γ-2θ")
                onClicked: {
                    Globals.Proxies.main.rawData.is2DtabSelected = true
                    Globals.Proxies.main.rawData.is3DtabSelected = false
                    Globals.Proxies.main.rawData.is1DtabSelected = false
                }
            },
            EaElements.TabButton {
                text: qsTr("2D View: 2θ Rings")
                onClicked: {
                    Globals.Proxies.main.rawData.is2DtabSelected = true
                    Globals.Proxies.main.rawData.is3DtabSelected = false
                    Globals.Proxies.main.rawData.is1DtabSelected = false
                }
            },
            EaElements.TabButton {
                text: qsTr("1D View: γ(2θ)")
                onClicked: {
                    Globals.Proxies.main.rawData.is1DtabSelected = true
                    Globals.Proxies.main.rawData.is2DtabSelected = false
                    Globals.Proxies.main.rawData.is3DtabSelected = false
                }
            }
        ]

        items: [
            Loader { source: 'MainContent/Tab_3dPreviewScatter.qml' },
            Loader { source: 'MainContent/Tab_2dPreviewGammaTwoTheta.qml' },
            Loader { source: 'MainContent/Tab_2dPreviewTwoThetaRings.qml' },
            Loader { source: 'MainContent/Tab_1dPreview.qml' }
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
