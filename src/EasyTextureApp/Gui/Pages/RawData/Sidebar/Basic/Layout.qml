// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.SideBarColumn {

    EaElements.GroupBox {
        title: qsTr('Measurement File')
        icon: 'rocket'
        collapsible: false

        Loader { source: 'Groups/MeasurementFile.qml' }
    }

    EaElements.GroupBox {
        title: qsTr('3D Binning Parameters')
        icon: 'database'
        collapsible: false
        visible: Globals.BackendWrapper.rawDataLoaded && Globals.BackendWrapper.rawDataSelectedTabIndex == 0

        Loader { source: 'Groups/Binning3D.qml' }
    }

    EaElements.GroupBox {
        //id: binning2DGroupBox
        title: qsTr('2D Binning Parameters')
        icon: 'archive'
        collapsible: false
        visible: Globals.BackendWrapper.rawDataLoaded && (Globals.BackendWrapper.rawDataSelectedTabIndex == 1 || Globals.BackendWrapper.rawDataSelectedTabIndex == 2)

        Loader {
            id: binning2DGroupBoxLoader
            source: 'Groups/Binning2D.qml'
        }

        Connections {
            target: binning2DGroupBoxLoader.item
            // once indxChanged signal from groupbox is received -> reset slider value
            // in slider2D group box to the smalest (default) value
            function onIndxChanged() {
                slider2DGroupBoxLoader.item.sliderValue2D = Globals.BackendWrapper.rawDataMinTwoThetaCenter2D
            }
        }
    }

    EaElements.GroupBox {
        id: slider2D
        title: qsTr('2θ Rings Slider')
        collapsible: false
        visible: Globals.BackendWrapper.rawDataLoaded && Globals.BackendWrapper.rawDataSelectedTabIndex == 2

        Loader {
            id: slider2DGroupBoxLoader
            source: 'Groups/TwoThetaSlider2D.qml'
        }
    }

    EaElements.GroupBox {
        id: binning1DGroupBox
        title: qsTr('1D Binning Parameters')
        collapsible: false
        visible: Globals.BackendWrapper.rawDataLoaded && Globals.BackendWrapper.rawDataSelectedTabIndex == 3

        Loader {
            id: binning1DGroupBoxLoader
            source: 'Groups/Binning1D.qml'
        }

        Connections {
            target: binning1DGroupBoxLoader.item
            // once indxChanged signal from groupbox is received -> reset slider value
            // in slider1D group box to the smalest (default) value
            function onIndxChanged() {
                slider1DGroupBoxLoader.item.sliderValue1D = Globals.BackendWrapper.rawDataMinTwoThetaCenter1D
            }
        }
    }

    EaElements.GroupBox {
        id: slider1D
        title: qsTr('2θ Slider')
        collapsible: false
        visible: Globals.BackendWrapper.rawDataLoaded && Globals.BackendWrapper.rawDataSelectedTabIndex == 3

        Loader {
            id: slider1DGroupBoxLoader
            source: 'Groups/TwoThetaSlider1D.qml'
        }
    }

}
