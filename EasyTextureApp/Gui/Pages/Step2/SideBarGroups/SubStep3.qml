// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15

import easyApp.Gui.Style 1.0 as EaStyle
import easyApp.Gui.Elements 1.0 as EaElements
import easyApp.Gui.Logic 1.0 as EaLogic

import Gui.Globals 1.0 as ExGlobals

Grid {
    columns: 2
    columnSpacing: EaStyle.Sizes.fontPixelSize

    Column {
        EaElements.Label {
            enabled: false
            text: qsTr("Number of points")
        }

        EaElements.Parameter {
            width: inputFieldWidth()
            Component.onCompleted: text = ExGlobals.Variables.chartViewSimple1dPlotly.xyArraysLength
            onEditingFinished: {
                ExGlobals.Variables.chartViewSimple1dPlotly.setXYArraysLength(text)
                ExGlobals.Variables.chartViewSimple1dPlotly.generateXArrayValues()
                ExGlobals.Variables.chartViewSimple1dPlotly.generateYArrayValues()
                ExGlobals.Variables.chartViewSimple1dPlotly.redrawPlot()
            }
        }
    }

    Column {
        EaElements.Label {
            enabled: false
            text: " "
        }

        EaElements.SideBarButton {
            width: inputFieldWidth()
            text: "Click to regenerate data"
            onClicked: {
                ExGlobals.Variables.chartViewSimple1dPlotly.generateYArrayValues()
                ExGlobals.Variables.chartViewSimple1dPlotly.redrawPlotWithYAnimation()
            }
        }
    }

    // Logic

    function inputFieldWidth() {
        return (EaStyle.Sizes.sideBarContentWidth - columnSpacing * (columns - 1)) / columns
    }

}


