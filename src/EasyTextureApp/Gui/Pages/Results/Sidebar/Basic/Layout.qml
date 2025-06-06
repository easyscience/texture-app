// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.SideBarColumn {

    EaElements.GroupBox {
        //enabled: Globals.Proxies.main.project.isCreated
        //title: (Globals.Proxies.main.results.isTwoThetaSelected) ? qsTr("2\u03b8 Patterns") : qsTr("d-Spacing Patterns")
        collapsible: false
        //visible: !Globals.Proxies.main.results.isIntegratedTwoThetaSelected

        Loader { source: 'Groups/dSpacingPatterns.qml' }

    }

    EaElements.GroupBox {
        //enabled: Globals.Proxies.main.project.isCreated
        title: qsTr('Export Data')
        collapsible: false
        last: true

        Loader { source: 'Groups/ExportData.qml' }
    }

    /*EaElements.GroupBox {
        enabled: false
        title: qsTr('Export summary')
        icon: 'download'
        collapsed: false

        Loader { source: 'Groups/Export.qml' }
    }*/

}
