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
            text: qsTr('No background correction')
            width: EaStyle.Sizes.fontPixelSize * 15
            checked: true

            onClicked: {
                Globals.BackendWrapper.correctionsLoadEmpty = false
            }
        }

        EaElements.RadioButton {
            id: calibration
            text: qsTr('Use empty can measurement')
            width: EaStyle.Sizes.fontPixelSize * 15

            onClicked: {
                Globals.BackendWrapper.correctionsLoadEmpty = true
            }
        }
    }

    // Location
    Row {
        spacing: EaStyle.Sizes.fontPixelSize * 0.5

        EaElements.Label {
            id: locationLabel
            text: qsTr('File')
            enabled: Globals.BackendWrapper.correctionsLoadEmpty
            anchors.verticalCenter: parent.verticalCenter
        }

        EaElements.TextField {
            id: reportLocationField
            placeholderText: qsTr('Enter empty can measurement filename here')
            enabled: Globals.BackendWrapper.correctionsLoadEmpty

            width: EaStyle.Sizes.sideBarContentWidth - locationLabel.width - EaStyle.Sizes.fontPixelSize * 0.5
            rightPadding: chooseButton.width
            horizontalAlignment: TextInput.AlignLeft

            EaElements.ToolButton {
                id: chooseButton

                anchors.right: parent.right

                showBackground: false
                fontIcon: 'folder-open'
                ToolTip.text: qsTr('Choose empty can measurement file here')

                onClicked: {
                    console.debug(`Clicking load empty can measurement file button ::: ${this}`)
                    Globals.References.pages.corrections.sidebar.basic.popups.loadEmptyMeasurementFile.open()
                }

                Loader {
                    source: '../Popups/LoadEmptyMeasurementFile.qml'
                }
            }
        }
    }

}
