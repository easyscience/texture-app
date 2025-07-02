// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals

EaCharts.Plotly3dSurfaceNew {
    id: surface3dRawData

    colorbarTitle: 'Counts'

    property string xColumn: 'voxel_x [mm]'
    property string yColumn: 'voxel_y [mm]'
    property string customDataColumn: 'custom_data'

    property string plotFilepath: Globals.BackendWrapper.liveViewPlotFilepath3D
    property real twoThetaBinWidthValue: Globals.BackendWrapper.liveViewTwoThetaBinWidth3D
    property real gammaBinWidthValue: Globals.BackendWrapper.liveViewGammaBinWidth3D

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
            generateSurfacePlot(plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue)
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onTwoThetaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            updateSurfacePlot(twoThetaBinWidthValue, gammaBinWidthValue)
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            updateSurfacePlot(twoThetaBinWidthValue, gammaBinWidthValue)
        }
    }

    onPlotFilepathChanged: {
        if (loadSucceededStatus) {
            generateSurfacePlot(plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue)
        }
    }

    Timer {
        interval: 3000  // 3 seconds
        repeat: true
        running: Globals.BackendWrapper.liveViewConnected && Globals.BackendWrapper.liveViewSelectedTabIndex === 0
        onTriggered: {
            Globals.BackendWrapper.liveViewUpdatePlotFilepath3D()
        }
    }

    function generateSurfacePlot(filepath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: generateSurfacePlot started...`)
        Globals.BackendWrapper.rawDataGenerateSurfacePlot3D(filepath, twoThetaBinWidth, gammaBinWidth)
        if (Object.values(Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE"))) {
            getData3DFromJson(Qt.resolvedUrl(plotFilepath))
            surface3dRawData.setScene()
            surface3dRawData.setColorbarTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
        }
        console.debug(`In ${this}: generateSurfacePlot finished.`)
    }

    function updateSurfacePlot(twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: updateSurfacePlot started...`)
        Globals.BackendWrapper.rawDataUpdateSurfacePlot3D(twoThetaBinWidth, gammaBinWidth)
        if (Object.values(Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE"))) {
            getData3DFromJson(Qt.resolvedUrl(plotFilepath))
            surface3dRawData.setColorbarTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
        }
        console.debug(`In ${this}: updateSurfacePlot finished.`)
    }

    function getData3DFromJson(jsonFilename) {
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let xData = result[xColumn]
            let yData = result[yColumn]
            //customData: [0]: two_theta, [1]: gamma, [2]: z, [3]: counts
            let customData = result[customDataColumn]
            let zData = extractCustomColumnByIndex(customData, 2)
            let countsData = extractCustomColumnByIndex(customData, 3)

            let hoverTemplate = '2\u03b8: %{customdata[0]}\u00B0<br>'+
                                '\u03b3: %{customdata[1]}\u00B0<br>'+
                                'z: %{customdata[2]:.3f} mm<br>'+
                                'Counts: %{customdata[3]}'

            plotData = {
                'x': xData,
                'y': yData,
                'z': zData,
                'surfaceColor': countsData,
                'customData': customData,
                'hoverTemplate': hoverTemplate
            }
        })
    }

    function extractCustomColumnByIndex(customData, i) {
      // extract the i-th element from each sub-array in customData
      let extractedCustomColumn = customData.map(row => row.map(arr => arr[i]));
      // reshape the array to match the expected structure (transpose the 2D array)
      let customColumn = extractedCustomColumn[0].map((_, colIndex) => extractedCustomColumn.map(row => row[colIndex]))
      return customColumn
    }
}
