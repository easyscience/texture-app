// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Charts as Charts
import Gui.Globals as Globals

EaCharts.Plotly2dPolarHeatmapNew {
    id: polarheatmap2d

    colorbarTitle: 'Counts'

    property string gammaColumn: 'user gamma [deg]'
    property string twoThetaColumn: 'two_theta [deg]'
    property string customDataColumn: 'custom_data'

    property string plotFilepath: Globals.BackendWrapper.explorePlotFilepath
    property real minTwoTheta: Globals.BackendWrapper.exploreMinTwoThetaCenter
    property real sliderValue: Globals.BackendWrapper.exploreTwoThetaSliderValue
    property real gammaBinWidthValue: Globals.BackendWrapper.exploreGammaBinWidth
    property real twoThetaBinWidthValue: 0.5

    function generatePolarHeatmap(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        Globals.BackendWrapper.exploreGenerate2dPolarHeatmapPlot(twoThetaBinWidth, gammaBinWidth)
        if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
            getTwoThetaRingDataFromJson(Qt.resolvedUrl(plotFilepath), currentTwoTheta)
            polarheatmap2d.setColorbarTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
        }
    }

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now generating visualizations...')
            generatePolarHeatmap(twoThetaBinWidthValue, gammaBinWidthValue, minTwoTheta)
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus){
            generatePolarHeatmap(twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
        }
    }

    onSliderValueChanged: {
        if (loadSucceededStatus) {
            generatePolarHeatmap(twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
        }
    }

    function getTwoThetaRingDataFromJson(jsonFilename, sliderValue){
        console.debug(`In ${this}: Getting data from json: ${jsonFilename} for twoTheta=${sliderValue}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let uniqueTwoTheta = result[twoThetaColumn]
            let uniqueGamma = result[gammaColumn]
            let customData = result[customDataColumn]

            let ringsGamma = cleanUpGamma(uniqueGamma, 270) //removes 270 and 2 neighbors
            let ringsR = Array(ringsGamma.length).fill(800)
            let countsData = extractCustomColumnByIndex(customData, 2)
            let ringsCountsMesh = cleanUpCounts(countsData)

            let sliderIndx = getIndxByValue(uniqueTwoTheta, sliderValue)
            let twoThetaArray = Array(ringsCountsMesh[sliderIndx].length).fill(uniqueTwoTheta[sliderIndx])

            plotData = {
                'r': ringsR,
                'theta': ringsGamma,
                'z': ringsCountsMesh[sliderIndx],
                'customData': twoThetaArray,
                'hoverTemplate': '2\u03b8: %{customdata}\u00B0<br>'+
                                 '\u03b3: %{theta}<br>'+
                                 'Counts: %{marker.color}',
            }
        })
    }

    function getIndxByValue(object, value) {
        return Object.keys(object).filter(indx => object[indx] === value)
    }

    function cleanUpGamma(gammaArray, target) {
        let index = gammaArray.indexOf(target);
        // Only proceed if the target is found
        if (index > -1) {
            // Check if there are neighbors to remove (both before and after the target)
            if (index > 0 && index < gammaArray.length - 1) {
                // Remove the target and its two neighbors (one before and one after)
                gammaArray.splice(index - 1, 3)
            } else if (index === 0) {
                // Special case: target is at the start of the array (remove target and next element)
                gammaArray.splice(index, 2) // Remove the target and its neighbor
            } else if (index === gammaArray.length - 1) {
                // Special case: target is at the end of the array (remove previous element and target)
                gammaArray.splice(index - 1, 2) // Remove the previous element and target
            }
        }
        return gammaArray
    }

    function extractCustomColumnByIndex(customData, i) {
        // extract the i-th element from each sub-array in customData
        let extractedCustomColumn = customData.map(row => row.map(arr => arr[i]))
        // reshape the array to match the expected structure (transpose the 2D array)
        let customColumn = extractedCustomColumn[0].map((_, colIndex) => extractedCustomColumn.map(row => row[colIndex]))
        return customColumn
    }

    function cleanUpCounts(arr) {
        return arr.map(row => row.filter(value => value !== undefined))
    }
}
