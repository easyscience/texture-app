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
        title: qsTr('Select 2θ ring')
        icon: 'microscope'
        collapsible: false

        Loader { source: 'Groups/TwoThetaSlider.qml' }
    }

    EaElements.GroupBox {
        title: qsTr('Statistics')
        icon: 'microscope'
        collapsible: false

        Loader { source: 'Groups/Statistics.qml' }
    }

    EaElements.GroupBox {
        title: qsTr('Select γ-slice width')
        icon: 'arrows-alt'
        collapsible: false

        Loader { source: 'Groups/GammaSliceSelector.qml' }
    }

}
