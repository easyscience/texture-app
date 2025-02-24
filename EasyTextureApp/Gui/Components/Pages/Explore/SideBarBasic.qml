// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals

EaComponents.SideBarColumn {

    EaElements.GroupBox {
        title: qsTr("Select 2θ Ring")
        collapsible: false

        Loader { source: 'SideBarBasic/TwoThetaSlider.qml' }
    }

    EaElements.GroupBox {
        title: qsTr("Select γ-Slice Width")
        collapsible: false

        Loader { source: 'SideBarBasic/GammaSliceSelector.qml' }

    }

    Component.onCompleted: {
        // setting default gamma-width value
        Globals.Proxies.main.explore.setGammaWidth(1)
    }
}
