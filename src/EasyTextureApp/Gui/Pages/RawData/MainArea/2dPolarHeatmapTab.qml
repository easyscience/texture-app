// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals

EaCharts.Plotly2dPolarHeatmap {
    id: polarHeatmap2dRawData

    colorbarTitle: 'Counts'

    property string gammaColumn: 'user gamma [deg]'
    property string twoThetaColumn: 'two_theta [deg]'
    property string customDataColumn: 'custom_data'

    property string plotFilepath: Globals.BackendWrapper.rawDataPlotFilepath2D
    property real twoThetaBinWidthValue: Globals.BackendWrapper.rawDataTwoThetaBinWidth2D
    property real gammaBinWidthValue: Globals.BackendWrapper.rawDataGammaBinWidth2D
    property real sliderIndxValue: Globals.BackendWrapper.rawDataTwoThetaSliderIndex2D
    property bool resetSlider: Globals.BackendWrapper.rawDataResetTwoThetaSlider

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            Globals.BackendWrapper.rawDataGeneratePolarHeatmap2D(plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, 0)
            setColorbarTitle()
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onTwoThetaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            // slider not-reset flag is needed when the calculation is activated on tab change and then
            // the reset of slider on bin width is not necessary
            if (resetSlider) {
                Globals.BackendWrapper.rawDataTwoThetaSliderIndex2D = 0
                Globals.BackendWrapper.rawDataTwoThetaSliderIndexSync = 0
            }
            Globals.BackendWrapper.rawDataUpdatePolarHeatmapTwoThetaBinWidth2D(twoThetaBinWidthValue, gammaBinWidthValue, sliderIndxValue)
            setColorbarTitle()
            if (Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex3D = Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D
                Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex1D = Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex2D
            }
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataUpdatePolarHeatmapGammaBinWidth2D(twoThetaBinWidthValue, gammaBinWidthValue, sliderIndxValue)
            setColorbarTitle()
            if (Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                Globals.BackendWrapper.rawDataGammaBinWidthIndex3D = Globals.BackendWrapper.rawDataGammaBinWidthIndex2D
                Globals.BackendWrapper.rawDataGammaBinWidthIndex1D = Globals.BackendWrapper.rawDataGammaBinWidthIndex2D
            }
        }
    }

    // to be tested with python backend
    onPlotFilepathChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataGeneratePolarHeatmap2D(plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, 0)
            setColorbarTitle()
        }
    }

    function getData2DFromJson(jsonFilename, sliderIndx, callback) {
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result) {
            let uniqueTwoTheta = result[twoThetaColumn]
            let uniqueGamma = result[gammaColumn]
            let customData = result[customDataColumn]

            let ringsGamma = cleanUpGamma(uniqueGamma, 270) //removes 270 and 2 neighbors
            let ringsR = Array(ringsGamma.length).fill(800)
            let countsData = extractCustomColumnByIndex(customData, 2)
            let ringsCountsMesh = cleanUpCounts(countsData)

            // sends values to your callback to wait for full completion of runJavaScript
            callback(ringsR, uniqueTwoTheta, ringsGamma, ringsCountsMesh)
        })
    }

    function cleanUpGamma(gammaArray, target) {
        let index = gammaArray.indexOf(target)
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

    Component.onCompleted: {
        Globals.References.pages.rawData.mainArea.tabPolarHeatmapPlot2d = polarHeatmap2dRawData
    }

}
