// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.SideBarColumn {

    EaElements.GroupBox {
        id: slicerGroupBox
        title: qsTr('Slicer')
        collapsible: false
        visible: !(Globals.BackendWrapper.resultsSelectedTabIndex === 2)
        icon: 'microscope'

        Loader { source: 'Groups/DataSlicer.qml' }
    }

    EaElements.GroupBox {
        title: qsTr('Export data')
        icon: 'download'
        last: true

        Loader { source: 'Groups/ExportData.qml' }
    }

}
