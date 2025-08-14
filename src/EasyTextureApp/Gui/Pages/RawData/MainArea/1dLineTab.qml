// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals

EaCharts.Plotly1dLine {
    id: line1dRawData

    xAxisTitle: '\u03b3, deg'
    yAxisTitle: 'Counts'

    property string gammaColumn:  'user gamma [deg]'
    property string twoThetaColumn: 'two_theta [deg]'
    property string customDataColumn: 'custom_data'

    property string plotFilepath: Globals.BackendWrapper.rawDataPlotFilepath1D
    property real minTwoTheta: Globals.BackendWrapper.rawDataMinTwoThetaCenter1D
    property real sliderValue: Globals.BackendWrapper.rawDataTwoThetaSliderValue1D
    property real sliderIndxValue: (Globals.BackendWrapper.rawDataTwoThetaSliderValue1D - Globals.BackendWrapper.rawDataMinTwoThetaCenter1D) / Globals.BackendWrapper.rawDataTwoThetaBinWidth1D

    property real twoThetaBinWidthValue: Globals.BackendWrapper.rawDataTwoThetaBinWidth1D
    property real gammaBinWidthValue: Globals.BackendWrapper.rawDataGammaBinWidth1D

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            Globals.BackendWrapper.rawDataGenerateLinePlot1D(line1dRawData, plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, sliderIndxValue)
            setXAxisTitle()
            setYAxisTitle()
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onTwoThetaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataUpdateLinePlotTwoThetaBinWidth1D(line1dRawData, twoThetaBinWidthValue)
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataUpdateLinePlotGammaBinWidth1D(line1dRawData, gammaBinWidthValue)
        }
    }

    onPlotFilepathChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataGenerateLinePlot1D(line1dRawData, plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, sliderIndxValue)
        }
    }

    onSliderIndxValueChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataUpdateLinePlotSliderIndex1D(line1dRawData, sliderIndxValue)
        }
    }

    function getData1DFromJson(jsonFilename, sliderIndx, callback) {
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let uniqueTwoTheta = result[twoThetaColumn]
            let uniqueGamma = result[gammaColumn]
            let customData = result[customDataColumn]
            let countsData = extractCustomColumnByIndex(customData, 2)
            //let sliderIndxValue = getIndxByValue(uniqueTwoTheta, sliderValue)
            let twoThetaArray = Array(uniqueGamma.length).fill(uniqueTwoTheta[sliderIndx])

            // sends values to your callback to wait for full completion of runJavaScript
            callback(uniqueGamma, countsData, twoThetaArray, customData)
        })
    }

    function extractCustomColumnByIndex(customData, i) {
        // extract the i-th element from each sub-array in customData
        let extractedCustomColumn = customData.map(row => row.map(arr => arr[i]))
        // reshape the array to match the expected structure (transpose the 2D array)
        let customColumn = extractedCustomColumn[0].map((_, colIndex) => extractedCustomColumn.map(row => row[colIndex]))
        return customColumn
    }

    // function getIndxByValue(object, value) {
    //     return Object.keys(object).filter(indx => object[indx] === value)
    // }

}
