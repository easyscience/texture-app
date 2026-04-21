// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


Column {
    property int radioButtonWidth: (EaStyle.Sizes.sideBarContentWidth - spacing) / 2

    spacing: EaStyle.Sizes.fontPixelSize / 2

    Row {
        EaElements.RadioButton {
            text: qsTr('No voxel calibration')
            width: radioButtonWidth
            checked: true

            onClicked: Globals.BackendWrapper.correctionsLoadCalibration = false
        }

        EaElements.RadioButton {
            text: qsTr('Use voxel calibration')
            width: radioButtonWidth

            onClicked: Globals.BackendWrapper.correctionsLoadCalibration = true
        }
    }


    EaElements.TextField {
        placeholderText: qsTr('Enter calibration filename here')
        enabled: Globals.BackendWrapper.correctionsLoadCalibration

        width: EaStyle.Sizes.sideBarContentWidth
        rightPadding: chooseButton.width
        horizontalAlignment: TextInput.AlignLeft

        EaElements.ToolButton {
            id: chooseButton

            anchors.right: parent.right

            showBackground: false
            fontIcon: 'folder-open'
            ToolTip.text: qsTr('Choose calibration file here')

            onClicked: {
                console.debug(`Clicking load calibration file button ::: ${this}`)
                Globals.References.pages.corrections.sidebar.basic.popups.loadVortexCalibrationFile.open()
            }

            Loader {
                source: '../Popups/LoadVortexCalibrationFile.qml'
            }
        }
    }

}


