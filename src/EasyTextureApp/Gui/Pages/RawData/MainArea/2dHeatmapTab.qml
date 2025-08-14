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
    property real sliderValue: Globals.BackendWrapper.rawDataTwoThetaRingsSliderValue2D
    property real sliderIndxValue: (Globals.BackendWrapper.rawDataTwoThetaRingsSliderValue2D - Globals.BackendWrapper.rawDataMinTwoThetaCenter2D) / Globals.BackendWrapper.rawDataTwoThetaBinWidth2D
    property real twoThetaBinWidthValue: Globals.BackendWrapper.rawDataTwoThetaBinWidth2D
    property real gammaBinWidthValue: Globals.BackendWrapper.rawDataGammaBinWidth2D

    shapes: [{
        'type': 'rect',
        'x0': sliderIndxValue - 0.5,
        'x1': sliderIndxValue + 0.5,
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
            Globals.BackendWrapper.rawDataGenerateHeatmap2D(heatmap2dRawData, plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, sliderIndxValue)
            setShape()
            setXAxisTitle()
            setYAxisTitle()
            setColorbarTitle()
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onPlotFilepathChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataGenerateHeatmap2D(heatmap2dRawData, plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, sliderIndxValue)
            setXAxisTitle()
            setYAxisTitle()
            setColorbarTitle()
        }
    }

    onTwoThetaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataUpdateHeatmapTwoThetaBinWidth2D(heatmap2dRawData, twoThetaBinWidthValue)
            setXAxisTitle()
            setColorbarTitle()
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataUpdateHeatmapGammaBinWidth2D(heatmap2dRawData, gammaBinWidthValue)
            setYAxisTitle()
            setColorbarTitle()
        }
    }

    function getData2DFromJson(jsonFilename, callback) {
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

            // sends values to your callback to wait for full completion of runJavaScript
            callback(uniqueTwoTheta, uniqueGamma, countsData, customData)
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
