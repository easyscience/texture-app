// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.SideBarColumn {

    EaElements.GroupBox {
        enabled: Globals.Proxies.main.project.isCreated
        title: qsTr("gamma-Slice Width")
        collapsible: false

        Loader { source: 'SideBarBasic/Sub01.qml' }
    }

    EaElements.GroupBox {
        enabled: Globals.Proxies.main.project.isCreated
        title: qsTr("d-Spacing Patterns")
        collapsible: false

        Loader { source: 'SideBarBasic/Sub02.qml' }
    }

    EaElements.GroupBox {
        enabled: Globals.Proxies.main.project.isCreated
        title: qsTr("Export d-Spacing Data")
        collapsible: false
        last: true

        Loader { source: 'SideBarBasic/ExportReportGroup.qml' }
    }

}
