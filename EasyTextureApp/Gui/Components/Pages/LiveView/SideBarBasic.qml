// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.SideBarColumn {

    EaElements.GroupBox {
        title: qsTr("Connect to Measurement Data")
        collapsible: false

        Loader { source: 'SideBarBasic/Sub01.qml' }
    }

    EaElements.GroupBox {
        title: qsTr("Statistics")
        collapsible: true


        Loader { source: 'SideBarBasic/Sub02.qml' }
    }

    EaElements.GroupBox {
        title: qsTr("Explore Detector 3D Preview")
        collapsible: false

        Loader { source: 'SideBarBasic/Sub03.qml' }
    }

    EaElements.GroupBox {
        title: qsTr("Explore 2-theta Rings Preview")
        collapsible: false
        last: true

        Loader { source: 'SideBarBasic/Sub04.qml' }
    }


}



