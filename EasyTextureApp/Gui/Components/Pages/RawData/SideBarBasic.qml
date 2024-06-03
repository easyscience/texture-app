// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.SideBarColumn {

    // from EasyAppExample:
    EaElements.GroupBox {
        title: qsTr("Measurement File")
        collapsible: false
        last: !Globals.Proxies.main.corrections.isCreated

        Loader {source: 'SideBarBasic/MeasurementsExplorerGroup.qml'}
    }

    EaElements.GroupBox {
        title: qsTr("3D Binning Parameters")
        collapsible: false
        visible: Globals.Proxies.main.rawData.is3DtabSelected && Globals.Proxies.main.rawData.isCreated

        Loader {source: 'SideBarBasic/Binning3D.qml'}
    }

    EaElements.GroupBox {
        id: binning2DGroupBox
        title: qsTr("2D Binning Parameters")
        collapsible: false
        visible: (Globals.Proxies.main.rawData.is2DtabSelected || Globals.Proxies.main.rawData.is2DthetaRingsTabSelected) && Globals.Proxies.main.rawData.isCreated

        Loader {
            id: binning2DGroupBoxLoader
            source: 'SideBarBasic/Binning2D.qml'
        }

        Connections {
            target: binning2DGroupBoxLoader.item
            // once indxChanged signal from groupbox is received -> change slider value in slider1D group box
            function onIndxChanged() {
                slider2DGroupBoxLoader.item.sliderValue = 45.5
            }
        }
    }

    EaElements.GroupBox {
        id: slider2D
        title: qsTr("2θ Rings Slider")
        collapsible: false
        visible: Globals.Proxies.main.rawData.is2DthetaRingsTabSelected && Globals.Proxies.main.rawData.isCreated

        Loader {
            id: slider2DGroupBoxLoader
            source: 'SideBarBasic/TwoThetaSlider2D.qml'
        }
    }

    EaElements.GroupBox {
        id: binning1DGroupBox
        title: qsTr("1D Binning Parameters")
        collapsible: false
        visible: Globals.Proxies.main.rawData.is1DtabSelected && Globals.Proxies.main.rawData.isCreated

        Loader {
            id: binning1DGroupBoxLoader
            source: 'SideBarBasic/Binning1D.qml'
        }

        Connections {
            target: binning1DGroupBoxLoader.item
            // once indxChanged signal from groupbox is received -> change slider value in slider1D group box
            function onIndxChanged() {
                slider1DGroupBoxLoader.item.sliderValue = 45.5
            }
        }
    }

    EaElements.GroupBox {
        id: slider1D
        title: qsTr("2θ Slider 1D")
        collapsible: false
        visible: Globals.Proxies.main.rawData.is1DtabSelected && Globals.Proxies.main.rawData.isCreated

        Loader {
            id: slider1DGroupBoxLoader
            source: 'SideBarBasic/TwoThetaSlider1D.qml'
        }
    }
}
