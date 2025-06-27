// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals

EaCharts.Plotly1dLineNew {
    id: line1dRawData

    xAxisTitle: '\u03b3, deg'
    yAxisTitle: 'Counts'

    property string gammaColumn:  'user gamma [deg]'
    property string twoThetaColumn: 'two_theta [deg]'
    property string customDataColumn: 'custom_data'

    property string plotFilepath: Globals.BackendWrapper.rawDataPlotFilepath1D
    property real minTwoTheta: Globals.BackendWrapper.rawDataMinTwoThetaCenter1D
    property real sliderValue: Globals.BackendWrapper.rawDataTwoThetaSliderValue1D
    property real twoThetaBinWidthValue: Globals.BackendWrapper.rawDataTwoThetaBinWidth1D
    property real gammaBinWidthValue: Globals.BackendWrapper.rawDataGammaBinWidth1D

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            generateLinePlot(plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, minTwoTheta)
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onPlotFilepathChanged: {
        if (loadSucceededStatus) {
            generateLinePlot(plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
        }
    }

    onTwoThetaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            updateLinePlot(twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            updateLinePlot(twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
        }
    }

    onSliderValueChanged: {
        if (loadSucceededStatus) {
            updateLinePlot(twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
        }
    }

    function generateLinePlot(filepath, twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        console.debug(`In ${this}: generateLinePlot started...`)
        Globals.BackendWrapper.rawDataGenerateLinePlot1D(filepath, twoThetaBinWidth, gammaBinWidth, currentTwoTheta)
        if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
            getData1DFromJson(Qt.resolvedUrl(plotFilepath), currentTwoTheta)
            line1dRawData.setXAxisTitle()
            line1dRawData.setYAxisTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
        }
        console.debug(`In ${this}: generateLinePlot finished.`)
    }

    function updateLinePlot(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        console.debug(`In ${this}: updateLinePlot started...`)
        Globals.BackendWrapper.rawDataUpdateLinePlot1D(twoThetaBinWidth, gammaBinWidth, currentTwoTheta)
        if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
            getData1DFromJson(Qt.resolvedUrl(plotFilepath), currentTwoTheta)
            line1dRawData.setXAxisTitle()
            line1dRawData.setYAxisTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
        }
        console.debug(`In ${this}: updateLinePlot finished.`)
    }

    function getData1DFromJson(jsonFilename, sliderValue) {
        console.debug(`${this} getData1DFromJson from file ${jsonFilename} for two theta=${sliderValue}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result) {
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
