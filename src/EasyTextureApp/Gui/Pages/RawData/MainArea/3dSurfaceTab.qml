// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals


// EaCharts.Plotly3dSurface {
//     onLoadSucceededStatusChanged: {
//         plot()
//         plotPatch(1, plotData)
//     }

//     function plot() {
//         let angles = [45, 90, 135, 180, 225, 270, 315, 360]
//         plotData = {
//             'x': [angles.map(angle => Math.sin(angle * (Math.PI / 180))), angles.map(angle => Math.sin(angle * (Math.PI / 180))),angles.map(angle => Math.sin(angle * (Math.PI / 180)))],
//             'y': [angles.map(angle => Math.cos(angle * (Math.PI / 180))), angles.map(angle => Math.cos(angle * (Math.PI / 180))),angles.map(angle => Math.cos(angle * (Math.PI / 180)))],
//             'z': [Array(angles.length).fill(1), Array(angles.length).fill(2),Array(angles.length).fill(3)],
//             'surfaceColor': [Array(angles.length).fill(10.5), Array(angles.length).fill(11.5),Array(angles.length).fill(12.5)]
//         }
//     }

//     function plotPatch(indx, surfaceData) {
//         let zLow = indx
//         let zHigh = indx + 1
//         //print('SDX', surfaceData.x)
//         //print('SDZ', surfaceData.z)
//         let topX = surfaceData.x[indx + 1]
//         let topY = surfaceData.y[indx + 1]
//         let topZ = surfaceData.z[indx + 1]

//         let bottomX = surfaceData.x[indx]
//         let bottomY = surfaceData.y[indx]
//         let bottomZ = surfaceData.z[indx]

//         // Choose vertical connector points (2 edges)
//         let connectorX = [topX[0], bottomX[0], null, topX[topX.length - 1], bottomX[bottomX.length - 1]]
//         let connectorY = [topY[0], bottomY[0], null, topY[topY.length - 1], bottomY[bottomY.length - 1]]
//         let connectorZ = [topZ[0], bottomZ[0], null, topZ[topZ.length - 1], bottomZ[bottomZ.length - 1]]

//         let patchX = [...topX, null, ...bottomX, null, ...connectorX]
//         let patchY = [...topY, null, ...bottomY, null, ...connectorY]
//         let patchZ = [...topZ, null, ...bottomZ, null, ...connectorZ]

//         patchData = {
//           'x': patchX,
//           'y': patchY,
//           'z': patchZ
//         }
//     }

// }

EaCharts.Plotly3dSurface {
    id: surface3dRawData

    colorbarTitle: 'Counts'

    property string xColumn: 'voxel_x [mm]'
    property string yColumn: 'voxel_y [mm]'
    property string customDataColumn: 'custom_data'

    property string plotFilepath: Globals.BackendWrapper.rawDataPlotFilepath3D
    property real minTwoTheta: Globals.BackendWrapper.rawDataMinTwoThetaCenter3D
    property real sliderValue: Globals.BackendWrapper.rawDataTwoThetaSliderValue3D
    property real sliderIndx: (Globals.BackendWrapper.rawDataTwoThetaSliderValue3D - Globals.BackendWrapper.rawDataMinTwoThetaCenter3D) / Globals.BackendWrapper.rawDataTwoThetaBinWidth3D
    property real twoThetaBinWidthValue: Globals.BackendWrapper.rawDataTwoThetaBinWidth3D
    property real gammaBinWidthValue: Globals.BackendWrapper.rawDataGammaBinWidth3D

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
            surface3dRawData.setScene()
            surface3dRawData.setColorbarTitle()
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

    function generateSurfacePlot(filepath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: generateSurfacePlot started...`)
        Globals.BackendWrapper.rawDataGenerateSurfacePlot3D(filepath, twoThetaBinWidth, gammaBinWidth)
        if (Object.values(Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE"))) {
            getData3DFromJson(Qt.resolvedUrl(plotFilepath), sliderIndx)
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
            getData3DFromJson(Qt.resolvedUrl(plotFilepath), sliderIndx)
            surface3dRawData.setColorbarTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
        }
        console.debug(`In ${this}: updateSurfacePlot finished.`)
    }

    function getData3DFromJson(jsonFilename, indx) {
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

            plotPatch(indx, plotData)
        })
    }

    function extractCustomColumnByIndex(customData, i) {
      // extract the i-th element from each sub-array in customData
      let extractedCustomColumn = customData.map(row => row.map(arr => arr[i]));
      // reshape the array to match the expected structure (transpose the 2D array)
      let customColumn = extractedCustomColumn[0].map((_, colIndex) => extractedCustomColumn.map(row => row[colIndex]))
      return customColumn
    }

    function plotPatch(indx, surfaceData) {
        let zLow = indx
        let zHigh = indx + 1

        let topX = surfaceData.x[indx + 1]
        let topY = surfaceData.y[indx + 1]
        let topZ = surfaceData.z[indx + 1]

        let bottomX = surfaceData.x[indx]
        let bottomY = surfaceData.y[indx]
        let bottomZ = surfaceData.z[indx]

        // Choose vertical connector points (2 edges)
        let connectorX = [topX[0], bottomX[0], null, topX[topX.length - 1], bottomX[bottomX.length - 1]]
        let connectorY = [topY[0], bottomY[0], null, topY[topY.length - 1], bottomY[bottomY.length - 1]]
        let connectorZ = [topZ[0], bottomZ[0], null, topZ[topZ.length - 1], bottomZ[bottomZ.length - 1]]

        let patchX = [...topX, null, ...bottomX, null, ...connectorX]
        let patchY = [...topY, null, ...bottomY, null, ...connectorY]
        let patchZ = [...topZ, null, ...bottomZ, null, ...connectorZ]

        patchData = {
          'x': patchX,
          'y': patchY,
          'z': patchZ
        }
    }
}
