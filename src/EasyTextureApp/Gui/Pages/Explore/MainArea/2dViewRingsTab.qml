// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals

EaCharts.Plotly2dPolarHeatmap {
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

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now generating visualizations...')
            generatePolarHeatmap(twoThetaBinWidthValue, gammaBinWidthValue, minTwoTheta)
            setTotalStatistics(twoThetaBinWidthValue, gammaBinWidthValue)
            setRingStatistics(twoThetaBinWidthValue, gammaBinWidthValue, minTwoTheta)
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus){
            generatePolarHeatmap(twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
            setTotalStatistics(twoThetaBinWidthValue, gammaBinWidthValue)
            setRingStatistics(twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
        }
    }

    onSliderValueChanged: {
        if (loadSucceededStatus) {
            generatePolarHeatmap(twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
            setRingStatistics(twoThetaBinWidthValue, gammaBinWidthValue, sliderValue)
        }
    }

    function generatePolarHeatmap(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        console.debug(`In ${this}: generatePolarHeatmap started`)
        Globals.BackendWrapper.exploreGenerate2dPolarHeatmapPlot(twoThetaBinWidth, gammaBinWidth, currentTwoTheta)
        if (Object.values(Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE"))) {
            getTwoThetaRingDataFromJson(Qt.resolvedUrl(plotFilepath), currentTwoTheta)
            polarheatmap2d.setColorbarTitle()
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
        }
        console.debug(`In ${this}: generatePolarHeatmap finished`)
    }

    function setTotalStatistics(twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: setTotalStatistics started`)
        Globals.BackendWrapper.exploreSetTotalStatistics(twoThetaBinWidth, gammaBinWidth)
        if (Object.values(Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE"))) {
            runJavaScript(`getDataFromJson(${JSON.stringify(Qt.resolvedUrl(plotFilepath))})`, function(result){
                let customData = result[customDataColumn]
                let countsData = extractCustomColumnByIndex(customData, 2)
                let countsDataClean = cleanUpCounts(countsData)
                let totalCountsMin = countsDataClean.reduce((min, row) => Math.min(min, ...row), Infinity)
                let totalCountsMax = countsDataClean.reduce((max, row) => Math.max(max, ...row), -Infinity)
                let totalCountsSum = countsDataClean.reduce((sum, row) => sum + row.reduce((rSum, val) => rSum + val, 0), 0)
                Globals.BackendWrapper.exploreTotalCountsMin = totalCountsMin
                Globals.BackendWrapper.exploreTotalCountsMax = totalCountsMax
                Globals.BackendWrapper.exploreTotalCountsSum = totalCountsSum
            })
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for setTotalStatistics() is not implemented yet.')
        }
        console.debug(`In ${this}: setTotalStatistics finished`)
    }

    function setRingStatistics(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        console.debug(`In ${this}: setRingStatistics started. WARNING: ringMaxIntensityWidth determination is not implemented. Random value is used instead.`)
        Globals.BackendWrapper.exploreSetRingStatistics(twoThetaBinWidth, gammaBinWidth, currentTwoTheta)
        if (Object.values(Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE"))) {
            runJavaScript(`getDataFromJson(${JSON.stringify(Qt.resolvedUrl(plotFilepath))})`, function(result){
                let uniqueTwoTheta = result[twoThetaColumn]

                let customData = result[customDataColumn]
                let countsData = extractCustomColumnByIndex(customData, 2)
                let countsDataClean = cleanUpCounts(countsData)

                let sliderIndx = getIndxByValue(uniqueTwoTheta, currentTwoTheta)
                let countsDataRing = countsDataClean[sliderIndx]

                let ringCountsMin = Math.min(...countsDataRing)
                let ringCountsMax = Math.max(...countsDataRing)
                let ringCountsSum = countsDataRing.reduce((total, num) => total + num, 0)
                let ringMaxIntensityWidth = Math.round((1 + Math.random() * 14) * 100) / 100;
                Globals.BackendWrapper.exploreRingCountsMin = ringCountsMin
                Globals.BackendWrapper.exploreRingCountsMax = ringCountsMax
                Globals.BackendWrapper.exploreRingCountsSum = ringCountsSum
                Globals.BackendWrapper.exploreRingMaxIntensityWidth = ringMaxIntensityWidth

            })
        }
        else {
            console.debug('NOT IMPLEMENTED: python backend for setRingStatistics() is not implemented yet.')
        }
        console.debug(`In ${this}: setRingStatistics finished`)
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
