// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals

EaCharts.Plotly1dBarPlotNew {
    id: dspacingBarPlot

    xAxisTitle: 'd-spacing, Å'
    yAxisTitle: 'Counts'

    property string gammaColumn:  'user gamma [deg]'
    property string dSpacingColumn: 'd-spacing [A]'
    property string customDataColumn: 'custom_data'

    property string plotFilepath: Globals.BackendWrapper.resultsDPatternPlotFilepath
    property int minSliderValue: Globals.BackendWrapper.resultsMinSliderValue
    property real sliderValue: Globals.BackendWrapper.resultsRingIndexSliderValue

    property real gammaBinWidthValue: Globals.BackendWrapper.exploreGammaBinWidth
    property real dSpacingBinWidthValue: 0.02

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            getBarPlotData(dSpacingBinWidthValue, gammaBinWidthValue, minSliderValue)
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onSliderValueChanged: {
        if (loadSucceededStatus) {
            getBarPlotData(dSpacingBinWidthValue, gammaBinWidthValue, sliderValue)
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            getBarPlotData(dSpacingBinWidthValue, gammaBinWidthValue, minSliderValue)
        }
    }

    function getBarPlotData(dSpacingBinWidth, gammaBinWidth, currentGammaSliceIndx){
        Globals.BackendWrapper.resultsGenerateDSpacingBarPlot(dSpacingBinWidth, gammaBinWidth, currentGammaSliceIndx)
        if (Object.values(Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE"))) {
            getBarPlotDataFromJson(Qt.resolvedUrl(plotFilepath), currentGammaSliceIndx)
            dspacingBarPlot.setXAxisTitle()
            dspacingBarPlot.setYAxisTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
        }
    }

    function getBarPlotDataFromJson(jsonFilename, sliderValue){
        console.debug(`${this} getBarPlotDataFromJson from file ${jsonFilename} for slice: ${sliderValue}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let uniqueDSpacing = result[dSpacingColumn]
            let uniqueGamma = result[gammaColumn]
            // [0]: d-spacing, [1]: gamma, [2]: counts
            let customData = result[customDataColumn]

            let countsData = extractCustomColumnByIndex(customData, 2)

            plotData = {
                'x': uniqueDSpacing,
                'y': countsData[sliderValue-1],
                'hoverTemplate': 'd: %{x:.2f}\u00C5<br>'+
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
