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
    property real twoThetaBinWidthValue: Globals.BackendWrapper.rawDataTwoThetaBinWidth1D
    property real gammaBinWidthValue: Globals.BackendWrapper.rawDataGammaBinWidth1D
    property real sliderIndxValue: Globals.BackendWrapper.rawDataTwoThetaSliderIndex1D
    property bool resetSlider: Globals.BackendWrapper.rawDataResetTwoThetaSlider

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            Globals.BackendWrapper.rawDataGenerateLinePlot1D(line1dRawData, plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, 0)
            setXAxisTitle()
            setYAxisTitle()
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onTwoThetaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            // slider not-reset flag is needed when the calculation is activated on tab change and then
            // the reset of slider on bin width is not necessary
            if (resetSlider) {
                Globals.BackendWrapper.rawDataTwoThetaSliderIndex1D = 0
                Globals.BackendWrapper.rawDataTwoThetaSliderIndexSync = 0
            }
            Globals.BackendWrapper.rawDataUpdateLinePlotTwoThetaBinWidth1D(line1dRawData, twoThetaBinWidthValue, gammaBinWidthValue, sliderIndxValue)

            if (Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex3D = Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex1D
            }
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataUpdateLinePlotGammaBinWidth1D(line1dRawData, twoThetaBinWidthValue, gammaBinWidthValue, sliderIndxValue)
            if (Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                Globals.BackendWrapper.rawDataGammaBinWidthIndex3D = Globals.BackendWrapper.rawDataGammaBinWidthIndex1D
                //Globals.BackendWrapper.rawDataUpdateSliceData3D(Globals.References.pages.rawData.mainArea.tabSurfacePlot3d, sliderIndxValue)
                //Globals.References.pages.rawData.sidebar.basic.groups.binning3d.twoThetaSlider.value = Globals.BackendWrapper.rawDataTwoThetaSliderValue1D
            }
        }
    }

    onPlotFilepathChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataGenerateLinePlot1D(line1dRawData, plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, 0)
        }
    }


    function getData1DFromJson(jsonFilename, sliderIndx, callback) {
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let uniqueTwoTheta = result[twoThetaColumn]
            let uniqueGamma = result[gammaColumn]
            let customData = result[customDataColumn]
            let countsData = extractCustomColumnByIndex(customData, 2)

            // sends values to your callback to wait for full completion of runJavaScript
            callback(uniqueTwoTheta, uniqueGamma, countsData)
        })
    }

    function extractCustomColumnByIndex(customData, i) {
        // extract the i-th element from each sub-array in customData
        let extractedCustomColumn = customData.map(row => row.map(arr => arr[i]))
        // reshape the array to match the expected structure (transpose the 2D array)
        let customColumn = extractedCustomColumn[0].map((_, colIndex) => extractedCustomColumn.map(row => row[colIndex]))
        return customColumn
    }

    Component.onCompleted: {
        Globals.References.pages.rawData.mainArea.tabLinePlot1d = line1dRawData
    }

}
