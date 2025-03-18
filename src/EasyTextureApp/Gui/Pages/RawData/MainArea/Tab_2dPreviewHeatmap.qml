// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Charts as Charts
import Gui.Globals as Globals

EaCharts.Plotly2dHeatmapNew {
    id: heatmap2d
    //url: Qt.resolvedUrl(Globals.BackendWrapper.rawDataPlot2dHeatmapFilepath)

    xAxisTitle: '2\u03b8, deg'
    yAxisTitle: '\u03b3, deg'

    xAxisCoord: 'two_theta [deg]'
    yAxisCoord: 'user gamma [deg]'
    zAxisCoord: 'proj_count'

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
                // callback is used to wait until heatmap2d.getDataFromJson() executed
                heatmap2d.getDataFromJson(Qt.resolvedUrl(Globals.BackendWrapper.rawDataPlot2dHeatmapFilepath), function(){
                    heatmap2d.getPlotData2D()
                })
            }
            else {
                console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
            }
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }
}
