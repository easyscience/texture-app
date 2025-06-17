// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals

EaCharts.Plotly1dLineNew {
    id: line1d

    xAxisTitle: '\u03b3, deg'
    yAxisTitle: 'Counts'

    property string gammaColumn:  'user gamma [deg]'
    property string twoThetaColumn: 'two_theta [deg]'
    property string customDataColumn: 'custom_data'

    property string plotFilepath: Globals.BackendWrapper.explorePlotFilepath
    property real minTwoTheta: Globals.BackendWrapper.exploreMinTwoThetaCenter
    property real sliderValue: Globals.BackendWrapper.exploreTwoThetaSliderValue
    property real gammaBinWidthValue: Globals.BackendWrapper.exploreGammaBinWidth
    property real twoThetaBinWidthValue: 0.5

    function generateLinePlot(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        Globals.BackendWrapper.exploreGenerate1dLinePlot(twoThetaBinWidth, gammaBinWidth, currentTwoTheta)
        if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
            getData1DFromJson(Qt.resolvedUrl(plotFilepath), currentTwoTheta)
            line1d.setXAxisTitle()
            line1d.setYAxisTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
        }
    }

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now generating visualizations...')
            generateLinePlot(twoThetaBinWidthValue, gammaBinWidthValue, minTwoTheta)
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            generateLinePlot(twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
        }
    }

    onSliderValueChanged: {
        if (loadSucceededStatus) {
            generateLinePlot(twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
        }
    }

    function getData1DFromJson(jsonFilename, sliderValue) {
        console.debug(`${this} getData1DFromJson from file ${jsonFilename} for two theta=${sliderValue}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let uniqueTwoTheta = result[twoThetaColumn]
            let uniqueGamma = result[gammaColumn]
            let customData = result[customDataColumn]

            let countsData = extractCustomColumnByIndex(customData, 2)
            let sliderIndx = getIndxByValue(uniqueTwoTheta, sliderValue)

            let twoThetaArray = Array(uniqueGamma.length).fill(uniqueTwoTheta[sliderIndx])

            plotData = {
                'x': uniqueGamma,
                'y': countsData[sliderIndx],
                'customData': twoThetaArray,
                'hoverTemplate': '2\u03b8: %{customdata}\u00B0<br>'+
                                 '\u03b3: %{x}\u00B0<br>'+
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
