// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals

EaCharts.Plotly1dBarPlot {
    id: twoThetaIntegratedBarPlot

    xAxisTitle: '2\u03b8, deg'
    yAxisTitle: 'Counts'

    property string gammaColumn:  'user gamma [deg]'
    property string twoThetaColumn: 'two_theta [deg]'
    property string customDataColumn: 'custom_data'
    property string plotFilepath: Globals.BackendWrapper.resultsTwoThetaPlotFilepath

    property real gammaBinWidthValue: Globals.BackendWrapper.exploreGammaBinWidth
    property real twoThetaBinWidthValue: 0.5

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            getBarPlotData(twoThetaBinWidthValue, gammaBinWidthValue)
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            getBarPlotData(twoThetaBinWidthValue, gammaBinWidthValue)
        }
    }

    function getBarPlotData(twoThetaBinWidth, gammaBinWidth){
        Globals.BackendWrapper.resultsGenerateIntegratedTwoThetaBarPlot(twoThetaBinWidth, gammaBinWidth)
        if (Object.values(Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE"))) {
            getBarPlotDataFromJson(Qt.resolvedUrl(plotFilepath))
            twoThetaIntegratedBarPlot.setXAxisTitle()
            twoThetaIntegratedBarPlot.setYAxisTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
        }
    }

    function getBarPlotDataFromJson(jsonFilename){
        console.debug(`${this} getBarPlotDataFromJson from file ${jsonFilename}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let uniqueTwoTheta = result[twoThetaColumn]
            let uniqueGamma = result[gammaColumn]
            // [0]: twotheta, [1]: gamma, [2]: counts
            let customData = result[customDataColumn]

            let countsData = extractCustomColumnByIndex(customData, 2)
            let countsSum = a => a[0].map((_, i) => a.reduce((acc, row) => acc + row[i], 0))

            plotData = {
                'x': uniqueTwoTheta,
                'y': countsSum(countsData),
                'hoverTemplate': '2\u03b8: %{x:.2f}\u00B0<br>'+
                                 'Counts: %{y}'
            }
        })
    }

    function extractCustomColumnByIndex(customData, i) {
        // extract the i-th element from each sub-array in customData
        let extractedCustomColumn = customData.map(row => row.map(arr => arr[i]))
        // reshape the array to match the expected structure (transpose the 2D array)
        let customColumn = extractedCustomColumn[0].map((_, colIndex) => extractedCustomColumn.map(row => row[colIndex]))
        return customColumn
    }

    function getIndxByValue(object, value) {
        return Object.keys(object).filter(indx => object[indx] === value);
    }

}
