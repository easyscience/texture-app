// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Charts as Charts
import Gui.Globals as Globals

EaCharts.Plotly2dPolarHeatmapNew {
    id: polarheatmap2d

    property string gammaColumn: 'user gamma [deg]'
    property string countsColumn: 'proj_count'
    property string twoThetaColumn: 'two_theta [deg]'

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
                getTwoThetaRingDataFromJson(Qt.resolvedUrl(Globals.BackendWrapper.rawDataPlot2dHeatmapFilepath), 45.5)
            }
            else {
                console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
            }
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    function getTwoThetaRingDataFromJson(jsonFilename, sliderValue){
        console.debug(`${this} getDataFromJson from file ${jsonFilename}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let gammaData = Object.values(result[gammaColumn])
            let countsData = Object.values(result[countsColumn])
            let twoThetaData = Object.values(result[twoThetaColumn])

            // Null indices are present in the 2d dataset to ensure the hole is properly
            // dislayed in the gamma-two_theta view. Not needed for the purposes of the polar heatmap.
            let countsWithNullIndices = findNullIndices(countsData)
            gammaData = removeElementsByIndices(gammaData, countsWithNullIndices)
            countsData = removeElementsByIndices(countsData, countsWithNullIndices)
            twoThetaData = removeElementsByIndices(twoThetaData, countsWithNullIndices)

            let animationTwoThetaIndices = getIndxByValue(twoThetaData, sliderValue)
            let animationTwoThetaArray = getValueByIndex(twoThetaData, animationTwoThetaIndices)
            let animationCounts = getValueByIndex(countsData, animationTwoThetaIndices)
            let animationGamma = getValueByIndex(gammaData, animationTwoThetaIndices)
            let animationR = Array(animationGamma.length).fill(800)

            let customArray = [animationTwoThetaArray, animationGamma, animationCounts]
            let customData = customArray[0].map((_, colIndex) => customArray.map(row => row[colIndex]))

            plotData = {
                'r': animationR,
                'theta': animationGamma,
                'z': animationCounts,
                'customData': customData,
                'hoverTemplate': '2\u03b8: %{customdata[0]}\u00B0<br>'+
                                 '\u03b3: %{customdata[1]}\u00B0<br>'+
                                 'Counts: %{customdata[2]}',
            }
        })
    }

    function onlyUnique(value, index, array) {
        return array.indexOf(value) === index;
    }

    function getIndxByValue(object, value) {
        return Object.keys(object).filter(indx => object[indx] === value);
    }

    function getValueByIndex(valueArray, indxArray) {
        return indxArray.map(indx => valueArray[indx]);
    }

    function findNullIndices(array) {
        // Map each element to its index if it's null, otherwise map to -1
        let indexMap = array.map((value, index) => value === null ? index : -1);
        // Filter out the -1 values to get only the indices of nulls
        let nullIndices = indexMap.filter(index => index !== -1);
        return nullIndices;
    }

    function removeElementsByIndices(array, indices) {
        let temp = array.slice()
        return array.filter((_, index) => !indices.includes(index));
    }
}
