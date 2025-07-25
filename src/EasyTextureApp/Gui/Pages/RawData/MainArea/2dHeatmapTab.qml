// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals

EaCharts.Plotly2dHeatmap {
    id: heatmap2dRawData

    xAxisTitle: '2\u03b8, deg'
    yAxisTitle: '\u03b3, deg'
    colorbarTitle: 'Counts'

    property string twoThetaColumn: 'two_theta [deg]'
    property string gammaColumn: 'user gamma [deg]'
    property string countsColumn: 'proj_count'
    property string customDataColumn: 'custom_data'

    property string plotFilepath: Globals.BackendWrapper.rawDataPlotFilepath2D
    property real minTwoTheta: Globals.BackendWrapper.rawDataMinTwoThetaCenter2D
    property real sliderValue: Globals.BackendWrapper.rawDataTwoThetaSliderValue2D
    property real sliderIndx: (Globals.BackendWrapper.rawDataTwoThetaSliderValue2D - Globals.BackendWrapper.rawDataMinTwoThetaCenter2D) / Globals.BackendWrapper.rawDataTwoThetaBinWidth2D
    property real twoThetaBinWidthValue: Globals.BackendWrapper.rawDataTwoThetaBinWidth2D
    property real gammaBinWidthValue: Globals.BackendWrapper.rawDataGammaBinWidth2D

    shapes: [{
        'type': 'rect',
        'x0': sliderIndx - 0.5,
        'x1': sliderIndx + 0.5,
        'y0': 0,
        'y1': 360,
        'fillcolor': 'rgba(0, 0, 0, 0)',
        'line': {
            'color': 'black',
            'width': 2,
            'dash': 'dash'
        }
    }]

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            generateHeatmap(plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue)
            heatmap2dRawData.setShape()
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onPlotFilepathChanged: {
        if (loadSucceededStatus) {
            generateHeatmap(plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue)
        }
    }

    onTwoThetaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            updateHeatmap(twoThetaBinWidthValue, gammaBinWidthValue)
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            updateHeatmap(twoThetaBinWidthValue, gammaBinWidthValue)
        }
    }


    function generateHeatmap(filepath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: generateHeatmap started...`)
        Globals.BackendWrapper.rawDataGenerateHeatmapPlot2D(filepath, twoThetaBinWidth, gammaBinWidth)
        if (Object.values(Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE"))) {
            getData2DFromJson(Qt.resolvedUrl(plotFilepath))
            heatmap2dRawData.setXAxisTitle()
            heatmap2dRawData.setYAxisTitle()
            heatmap2dRawData.setColorbarTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data processing is not implemented yet.')
        }
        console.debug(`In ${this}: generateHeatmap finished.`)
    }

    function updateHeatmap(twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: updateHeatmap started...`)
        Globals.BackendWrapper.rawDataUpdateHeatmapPlot2D(twoThetaBinWidth, gammaBinWidth)
        if (Object.values(Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE"))) {
            getData2DFromJson(Qt.resolvedUrl(plotFilepath))
            heatmap2dRawData.setColorbarTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data processing is not implemented yet.')
        }
        console.debug(`In ${this}: updateHeatmap finished.`)
    }

    function getData2DFromJson(jsonFilename) {
        console.debug(`${this} getDataFromJson from file ${jsonFilename}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result) {
            let uniqueTwoTheta = result[twoThetaColumn]
            let uniqueGamma = result[gammaColumn]
            // replace undefined by null
            uniqueGamma = uniqueGamma.map(value => value === undefined ? null : value);
            //customData: [0]: two_theta, [1]: gamma, [2]: counts
            let customData = result[customDataColumn]
            let countsData = extractCustomColumnByIndex(customData, 2)
            // replace undefined by null
            countsData = countsData.map(row => row.map(value => value === undefined ? null : value));;

            plotData = {
                'x': uniqueTwoTheta,
                'y': uniqueGamma,
                'z': countsData,
                'hoverTemplate': '2\u03b8: %{x}\u00B0<br>'+
                                 '\u03b3: %{y}\u00B0<br>'+
                                 'Counts: %{z}',
            }

        })
    }

    function onlyUnique(value, index, array) {
        return array.indexOf(value) === index
    }

    function getIndxByValue(object, value) {
        return Object.keys(object).filter(indx => object[indx] === value)
    }

    function getValueByIndex(valueArray, indxArray) {
        return indxArray.map(indx => valueArray[indx])
    }

    function extractCustomColumnByIndex(customData, i) {
        // extract the i-th element from each sub-array in customData
        let extractedCustomColumn = customData.map(row => row.map(arr => arr[i]))
        return extractedCustomColumn
    }

}
