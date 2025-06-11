// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.SideBarColumn {

    EaElements.GroupBox {
        title: Globals.BackendWrapper.resultsSelectedTabIndex === 0 ? qsTr("d-Spacing Patterns") : qsTr("2\u03b8 Patterns")
        collapsible: false
        visible: !(Globals.BackendWrapper.resultsSelectedTabIndex === 2)
        icon: 'database'

        Loader { source: 'Groups/dSpacingPatterns.qml' }
    }

    EaElements.GroupBox {
        //enabled: Globals.Proxies.main.project.isCreated
        title: qsTr('Export Data')
        collapsible: false
        icon: 'download'
        last: true

        Loader { source: 'Groups/ExportData.qml' }
    }
}
