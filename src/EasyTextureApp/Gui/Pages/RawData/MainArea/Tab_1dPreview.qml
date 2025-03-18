// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals
import Gui.Charts as Charts

EaCharts.Plotly1dLineNew {
    id: line1d

    xAxisTitle: '\u03b3, deg'
    yAxisTitle: 'Counts'

    xAxisCoord:  'user gamma [deg]'
    yAxisCoord:  'proj_count'
    sliderCoord: 'two_theta [deg]'

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
                // callback is used to wait until line1d.getDataFromJson() executed
                line1d.getDataFromJson(Qt.resolvedUrl(Globals.BackendWrapper.rawDataPlot1dFilepath), function(){
                    line1d.getPlotData(Globals.BackendWrapper.rawDataTwoThetaMin)
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
