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
        title: qsTr('Measurements')
        icon: 'layer-group'
        collapsible: false

        Loader { source: 'Groups/MeasurementFile.qml' }
    }

    EaElements.GroupBox {
        title: qsTr('Bin widths 3D')
        icon: 'arrows-alt'
        collapsible: false
        visible: Globals.BackendWrapper.rawDataLoaded && Globals.BackendWrapper.rawDataSelectedTabIndex == 0
        last: false

        Loader { source: 'Groups/Binning3D.qml' }
    }

    EaElements.GroupBox {
        id: slider3D
        title: qsTr('2θ slider 3D')
        icon: 'microscope'
        collapsible: false
        visible: Globals.BackendWrapper.rawDataLoaded && Globals.BackendWrapper.rawDataSelectedTabIndex == 0
        last: true

        Loader {
            id: slider3DGroupBoxLoader
            source: 'Groups/TwoThetaSlider3D.qml'
        }
    }

    EaElements.GroupBox {
        //id: binning2DGroupBox
        title: qsTr('Bin widths 2D')
        icon: 'arrows-alt'
        collapsible: false
        visible: Globals.BackendWrapper.rawDataLoaded && (Globals.BackendWrapper.rawDataSelectedTabIndex == 1 || Globals.BackendWrapper.rawDataSelectedTabIndex == 2)

        Loader {
            id: binning2DGroupBoxLoader
            source: 'Groups/Binning2D.qml'
        }
    }

    EaElements.GroupBox {
        id: slider2D
        title: qsTr('2θ slider 2D')
        icon: 'microscope'
        collapsible: false
        visible: Globals.BackendWrapper.rawDataLoaded && (Globals.BackendWrapper.rawDataSelectedTabIndex == 1 || Globals.BackendWrapper.rawDataSelectedTabIndex == 2)
        last: true

        Loader {
            id: slider2DGroupBoxLoader
            source: 'Groups/TwoThetaSlider2D.qml'
        }
    }

    EaElements.GroupBox {
        id: binning1DGroupBox
        title: qsTr('Bin widths 1D')
        icon: 'arrows-alt'
        collapsible: false
        visible: Globals.BackendWrapper.rawDataLoaded && Globals.BackendWrapper.rawDataSelectedTabIndex == 3

        Loader {
            id: binning1DGroupBoxLoader
            source: 'Groups/Binning1D.qml'
        }
    }

    EaElements.GroupBox {
        id: slider1D
        title: qsTr('2θ slider 1D')
        icon: 'microscope'
        collapsible: false
        visible: Globals.BackendWrapper.rawDataLoaded && Globals.BackendWrapper.rawDataSelectedTabIndex == 3
        last: true

        Loader {
            id: slider1DGroupBoxLoader
            source: 'Groups/TwoThetaSlider1D.qml'
        }
    }

}
