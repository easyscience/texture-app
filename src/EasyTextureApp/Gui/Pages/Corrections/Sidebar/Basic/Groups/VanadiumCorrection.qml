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
    rows: 3
    rowSpacing: 1

    // button 1
    Row {
        EaElements.RadioButton {
            //topPadding: 0
            checked: true
            text: qsTr('Use raw data without correction')
        }
    }

    // button 2
    Row {
        EaElements.RadioButton {
            id: applyDataCorrection
            //topPadding: 0
            text: qsTr('Apply data correction ')
            checked: false
            enabled: false
            //onCheckedChanged: Globals.Proxies.main.corrections.applyDataCorrection = checked
        }
    }

    // Location
    Row {
        spacing: EaStyle.Sizes.fontPixelSize * 0.5
        topPadding: 0
        visible: applyDataCorrection.checked


        EaElements.Label {
            id: locationLabel

            enabled: false
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr('File')
        }

        EaElements.TextField {
            id: reportLocationField

            width: EaStyle.Sizes.sideBarContentWidth - locationLabel.width - EaStyle.Sizes.fontPixelSize * 0.5
            rightPadding: chooseButton.width
            horizontalAlignment: TextInput.AlignLeft

            placeholderText: qsTr('Enter vanadium filename here')
            //text: Globals.Proxies.main.corrections.correctionFileName

            EaElements.ToolButton {
                id: chooseButton

                anchors.right: parent.right

                showBackground: false
                fontIcon: 'folder-open'
                ToolTip.text: qsTr('Choose vanadium file here')

                onClicked: {
                    console.debug(`Clicking load vanadium button ::: ${this}`)
                    Globals.References.pages.corrections.sidebar.basic.popups.openVanadiumJsonFile.open()
                }

                Loader {
                    source: '../Popups/OpenVanadiumJsonFile.qml'
                }
            }
        }
    }

}
