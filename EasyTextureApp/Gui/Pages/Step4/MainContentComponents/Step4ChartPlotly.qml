// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15

import easyApp.Gui.Charts 1.0 as EaCharts

import Gui.Globals 1.0 as ExGlobals

EaCharts.ChartViewHeatmap2dPlotly {

    Component.onCompleted: ExGlobals.Variables.chartViewHeatmap2dPlotly = this

    // Logic

    function generateZ3dValues() {
        const N = 501
        const M = 501
        z3dValues = []
        for (let i = 0; i < N; i++) {
            let row = []
            for (let j = 0; j < M; j++) {
                row[j] = Math.random()
            }
            z3dValues[i] = row
        }
        setZ3dValues(z3dValues)
    }

}
