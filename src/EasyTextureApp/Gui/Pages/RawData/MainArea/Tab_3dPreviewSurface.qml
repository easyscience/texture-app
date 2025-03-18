// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Charts as Charts
import Gui.Globals as Globals

EaCharts.Plotly3dSurfaceNew {
    id: surface3d

    xAxisCoord: 'voxel_x [mm]'
    yAxisCoord: 'voxel_y [mm]'
    zAxisCoord: 'voxel_z [mm]'

    xCustomAxisCoord: 'user gamma [deg]'
    yCustomAxisCoord: 'two_theta [deg]'
    zCustomAxisCoord: 'proj_count'

    scene: {
        'xaxis': {
            'title': { 'text': 'x, mm', 'font': { 'size': 14 } },
            'autorange': true,
            'zeroline': false,
            'showticklabels': true,
        },
        'yaxis': {
            'title': { 'text': 'y, mm', 'font': { 'size': 14 } },
            'autorange': true,
            'zeroline': false,
            'showticklabels': true,
        },
        'zaxis': {
            'title': {'text': 'z, mm', 'font': { 'size': 14 } },
            'autorange': true,
            'zeroline': false,
            'showticklabels': true,
          },
        'camera': {
            'center': { 'x': 0, 'y': 0, 'z': 0 },
            'eye': { 'x': 0.25, 'y': 0.75, 'z': -1.75 },
            'up': { 'x': 0, 'y': 1, 'z': 0 }
        }
    }

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
                // callback is used to wait until surface3d.getDataFromJson() executed
                surface3d.getDataFromJson(Qt.resolvedUrl(Globals.BackendWrapper.rawDataPlot3dFilepath), function(){
                    surface3d.getPlotData()
                    surface3d.setScene()
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
