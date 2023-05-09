// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals



Grid {
    columns: 2
    columnSpacing: EaStyle.Sizes.fontPixelSize

    Column {
        width: 1/2 * EaStyle.Sizes.sideBarContentWidth

        EaElements.Label {
            enabled: false
            text: qsTr("Current 2-theta Ring")
        }

        //Grid
        Grid {
            readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5

            columns: 2
            rowSpacing: 0
            columnSpacing: commonSpacing

            EaElements.Label {
                font.bold: true
                text: qsTr("Count Max:")
            }
            EaElements.Label {
                text: "xxx"
            }

            EaElements.Label {
                visible: Globals.Proxies.main.project.location !== '--- EXAMPLE ---'
                font.bold: true
                text: qsTr("Count Min:")
            }
            EaElements.Label {
                text: "xxx"
            }


            EaElements.Label {
                font.bold: true
                text: qsTr("Count Sum:")
            }
            EaElements.Label {
                text: "xxx"
            }

        } // Grid


    }

    Column {
        EaElements.Label {
            enabled: false
            text: qsTr("Total")
        }

        //Grid
        Grid {
            readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5

            columns: 2
            rowSpacing: 0
            columnSpacing: commonSpacing

            EaElements.Label {
                font.bold: true
                text: qsTr("Count Max:")
            }
            EaElements.Label {
                text: "xxx"
            }

            EaElements.Label {
                visible: Globals.Proxies.main.project.location !== '--- EXAMPLE ---'
                font.bold: true
                text: qsTr("Count Min:")
            }
            EaElements.Label {
                text: "xxx"
            }


            EaElements.Label {
                font.bold: true
                text: qsTr("Count Sum:")
            }
            EaElements.Label {
                text: "xxx"
            }

        } // Grid close
    }

    // Logic

    function inputFieldWidth() {
        return (EaStyle.Sizes.sideBarContentWidth - columnSpacing * (columns - 1)) / columns
    }

}
