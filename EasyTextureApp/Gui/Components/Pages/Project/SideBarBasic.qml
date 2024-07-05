// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.SideBarColumn {

    EaElements.GroupBox {
        title: qsTr("Get started")
        //collapsible: false
        collapsed: false

        Loader { source: 'SideBarBasic/GetStartedGroup.qml' }
    }

    EaElements.GroupBox {
        title: qsTr("Examples")
        collapsed: false
        last: true

        Loader { source: 'SideBarBasic/Examples.qml' }
    }

    EaElements.GroupBox {
        title: qsTr("Recent Projects")
        collapsed: true
        last: true

        Loader { source: 'SideBarBasic/RecentProjects.qml' }
    }

}

