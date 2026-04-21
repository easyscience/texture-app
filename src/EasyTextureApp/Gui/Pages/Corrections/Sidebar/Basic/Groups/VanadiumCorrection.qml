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
            text: qsTr('No vanadium correction')
            width: radioButtonWidth
            checked: true

            onClicked: {
                Globals.BackendWrapper.correctionsLoadVanadium = false
            }
        }

        EaElements.RadioButton {
            id: calibration
            text: qsTr('Use vanadium measurement')
            width: radioButtonWidth

            onClicked: {
                Globals.BackendWrapper.correctionsLoadVanadium = true
            }
        }
    }


    EaElements.TextField {
        id: reportLocationField
        placeholderText: qsTr('Enter vanadium measurement filename here')
        enabled: Globals.BackendWrapper.correctionsLoadVanadium

        width: EaStyle.Sizes.sideBarContentWidth
        rightPadding: chooseButton.width
        horizontalAlignment: TextInput.AlignLeft

        EaElements.ToolButton {
            id: chooseButton

            anchors.right: parent.right

            showBackground: false
            fontIcon: 'folder-open'
            ToolTip.text: qsTr('Choose vanadium measurement file here')

            onClicked: {
                console.debug(`Clicking load vanadium measurement file button ::: ${this}`)
                Globals.References.pages.corrections.sidebar.basic.popups.loadVanadiumMeasurementFile.open()
            }

            Loader {
                source: '../Popups/LoadVanadiumMeasurementFile.qml'
            }
        }
    }


}
