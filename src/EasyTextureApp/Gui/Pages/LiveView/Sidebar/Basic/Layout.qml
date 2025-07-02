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
        title: qsTr('Connection controls')
        collapsible: false

        Loader { source: 'Groups/LiveConnection.qml' }
    }

    EaElements.GroupBox {
        title: qsTr('Statistics')
        collapsible: true
        collapsed: false

        Loader { source: 'Groups/LiveStatistics.qml' }
    }

    /*EaElements.GroupBox {
        title: qsTr('3D Preview Features')
        collapsible: false
        visible: Globals.BackendWrapper.liveViewConnected && Globals.BackendWrapper.liveViewSelectedTabIndex === 0

        Loader { source: 'Groups/LiveFeatures3D.qml' }
    }*/

    EaElements.GroupBox {
        title: qsTr('2D Preview Features: 2θ Rings')
        collapsible: false
        visible: Globals.BackendWrapper.liveViewConnected && Globals.BackendWrapper.liveViewSelectedTabIndex === 1

        Loader { source: 'Groups/LiveFeatures2D.qml' }
    }

}
