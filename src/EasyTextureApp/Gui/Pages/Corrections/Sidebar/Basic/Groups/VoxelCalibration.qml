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


Grid {
    rows: 2
    rowSpacing: 15

    Row {
        EaElements.RadioButton {
            id: noCalibration
            text: qsTr('No voxel calibration')
            width: EaStyle.Sizes.fontPixelSize * 15
            checked: true

            onClicked: {
                Globals.BackendWrapper.correctionsLoadCalibration = false
            }
        }

        EaElements.RadioButton {
            id: calibration
            text: qsTr('Use voxel calibration')
            width: EaStyle.Sizes.fontPixelSize * 15

            onClicked: {
                Globals.BackendWrapper.correctionsLoadCalibration = true
            }
        }
    }

    // Location
    Row {
        spacing: EaStyle.Sizes.fontPixelSize * 0.5

        EaElements.Label {
            id: locationLabel
            text: qsTr('File')
            enabled: Globals.BackendWrapper.correctionsLoadCalibration
            anchors.verticalCenter: parent.verticalCenter
        }

        EaElements.TextField {
            id: reportLocationField
            placeholderText: qsTr('Enter calibration filename here')
            enabled: Globals.BackendWrapper.correctionsLoadCalibration

            width: EaStyle.Sizes.sideBarContentWidth - locationLabel.width - EaStyle.Sizes.fontPixelSize * 0.5
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

}
