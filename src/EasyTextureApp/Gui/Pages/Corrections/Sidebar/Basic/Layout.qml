// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

import QtQuick

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents
import EasyApp.Gui.Style as EaStyle

import Gui.Globals as Globals


EaComponents.SideBarColumn {

    EaElements.GroupBox {
        //enabled: false
        title: qsTr('Voxel calibration using ?diamond? standard')
        icon: 'hammer'
        collapsed: false

        Loader { source: 'Groups/VoxelCalibration.qml' }
    }

    EaElements.GroupBox {
        //enabled: false
        title: qsTr('Background correction using empty can measurement')
        icon: 'hammer'
        collapsed: false

        Loader { source: 'Groups/EmptyCorrection.qml' }
    }

    EaElements.GroupBox {
        //enabled: false
        title: qsTr('Detector efficiency correction using vanadium standard')
        icon: 'hammer'
        collapsed: false

        Loader { source: 'Groups/VanadiumCorrection.qml' }
    }

    // Apply corrections button
    Row {
        spacing: EaStyle.Sizes.fontPixelSize

        EaElements.SideBarButton {
            id: applyCorrectionsButton
            text: qsTr('Apply selected corrections')
            wide: true
            fontIcon: 'download'
            onClicked: {
                console.debug(`In ${this}: Apply corrections clicked.`)
            }
        }
    }
}
