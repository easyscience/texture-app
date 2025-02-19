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
    //columns: 2
    rows: 3
    columnSpacing: EaStyle.Sizes.fontPixelSize
    rowSpacing: EaStyle.Sizes.fontPixelSize //* 0.5

        // EasyApp RadioButton not working
        RadioButton {
            topPadding: 0
            checked: !Globals.Proxies.main.corrections.applyDataCorrection
            text: qsTr("Use raw data without correction")
            ToolTip.text: qsTr("Checking this box will continue without applying data correction to the measurement data")

        }
        // EasyApp RadioButton not working
        RadioButton {
            id: applyDataCorrection
            topPadding: 0
            text: qsTr("Apply data correction")
            ToolTip.text: qsTr("Checking this box will apply data correction to the measurement data")
            enabled: false
            contentItem: Text {
                text: applyDataCorrection.text
                color: "grey"
                leftPadding: applyDataCorrection.indicator.width + applyDataCorrection.spacing
                verticalAlignment: Text.AlignVCenter
            }
            onCheckedChanged: Globals.Proxies.main.corrections.applyDataCorrection = checked
        }


    // Location
    Row {
        spacing: EaStyle.Sizes.fontPixelSize * 0.5
        topPadding: 0

        visible: Globals.Proxies.main.corrections.applyDataCorrection


        EaElements.Label {
            id: locationLabel

            enabled: false
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("File")
        }

        EaElements.TextField {
            id: reportLocationField

            width: EaStyle.Sizes.sideBarContentWidth - locationLabel.width - EaStyle.Sizes.fontPixelSize * 0.5
            rightPadding: chooseButton.width
            horizontalAlignment: TextInput.AlignLeft

            placeholderText: qsTr("Enter Vanadium file here")
            text: Globals.Proxies.main.corrections.correctionFileName

            EaElements.ToolButton {
                id: chooseButton

                anchors.right: parent.right

                showBackground: false
                fontIcon: "folder-open"
                ToolTip.text: qsTr("Choose Vanadium file here")

                onClicked: vanadiumFileDialog.open()
            }
        }
    }


    // Vanadium File dialog
    FileDialog {
        id: vanadiumFileDialog

        title: qsTr("Choose File as Vanadium Standard")

        //folder: Globals.Constants.proxy.project.currentProjectPath

        onAccepted: {
            //Globals.Proxies.main.corrections.isCreated = true
            Globals.Proxies.main.corrections.isCorrectionFileAssigned = true
            Globals.Proxies.main.corrections.correctionFileName = selectedFile
        }

        onRejected: {
            Globals.Proxies.main.corrections.isCorrectionFileAssigned = false
            Globals.Proxies.main.corrections.correctionFileName = ""
        }
    }


}
