// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15

import easyApp.Gui.Elements 1.0 as EaElements
import easyApp.Gui.Charts 1.0 as EaCharts

import Gui.Globals 1.0 as ExGlobals

EaCharts.ChartViewSimple1dPlotly {

    xAxisTitle: '2θ (deg)'
    yAxisTitle: 'Icalc'

    xArrayValues: [0, 1, 2]
    yArrayValues: [1.0, 0.0, 0.5]

    Component.onCompleted: ExGlobals.Variables.chartViewSimple1dPlotly = this

    // Logic

    function setXYArraysLength(newLength) {
        xyArraysLength = parseInt(newLength)
    }

    function generateXArrayValues() {
        xArrayValues.length = 0
        for (let i = 0; i < xyArraysLength; i++) {
            xArrayValues[i] = i
        }
        setXArrayValues(yArrayValues)
    }

    function generateYArrayValues() {
        yArrayValues.length = 0
        for (let i = 0; i < xyArraysLength; i++) {
            yArrayValues[i] = Math.random()
        }
        setYArrayValues(yArrayValues)
    }

}
