// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents


EaComponents.SideBarColumn {

    EaElements.GroupBox {
        title: qsTr("Select 2-theta Ring")
        collapsible: false

        Loader { source: 'SideBarBasic/Sub01.qml' }
    }

    EaElements.GroupBox {
        title: qsTr("Select gamma-Slice Width")
        collapsible: false

        Loader { source: 'SideBarBasic/Sub03.qml' }
    }

}
