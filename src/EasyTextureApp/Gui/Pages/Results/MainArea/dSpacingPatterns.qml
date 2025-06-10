// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals

EaCharts.Plotly1dBarPlotNew {
    id: bar1d

    xAxisTitle: '\u03b3, deg'
    yAxisTitle: 'Counts'

    property string gammaColumn:  'user gamma [deg]'
    property string dSpacingColumn: 'd-spacing [A]'
    property string customDataColumn: 'custom_data'
    property string plotFilepath: Globals.BackendWrapper.resultsDPatternPlotFilepath
    property int minSliderValue: Globals.BackendWrapper.resultsMinSliderValue
    property real sliderValue: Globals.BackendWrapper.resultsRingIndexSliderValue
    //property bool resetSlider1D: Globals.BackendWrapper.rawDataResetTwoThetaSlider1D

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
                getData1DFromJson(Qt.resolvedUrl(plotFilepath), minSliderValue)
                bar1d.setXAxisTitle()
                bar1d.setYAxisTitle()
            }
            else {
                console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
            }
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onSliderValueChanged: {
        if (loadSucceededStatus) {
            getData1DFromJson(Qt.resolvedUrl(plotFilepath), sliderValue)
        }
    }

    function getData1DFromJson(jsonFilename, sliderValue){
        console.debug(`${this} getData1DFromJson from file ${jsonFilename} for two theta=${sliderValue}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let uniqueDSpacing = result[dSpacingColumn]
            let uniqueGamma = result[gammaColumn]
            // [0]: d-spacing, [1]: gamma, [2]: counts
            let customData = result[customDataColumn]

            //print('DSP', uniqueDSpacing)
            //print('Gamma', uniqueGamma)
            //print('CD', customData[0])

            let countsData = extractCustomColumnByIndex(customData, 2)
            //let sliderIndx = getIndxByValue(uniqueDSpacing, sliderValue)

            //let twoThetaArray = Array(uniqueGamma.length).fill(uniqueDSpacing[sliderIndx])

            plotData = {
                'x': uniqueDSpacing,//uniqueGamma,
                'y': countsData[sliderValue-1],//countsData[sliderIndx],
                //'customData': twoThetaArray,
                //'hoverTemplate': '2\u03b8: %{customdata}\u00B0<br>'+
                //                 '\u03b3: %{x}\u00B0<br>'+
                //                 'Counts: %{y}'
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
/*EaCharts.Plotly1dLineNew {
    id: line1d

    xAxisTitle: '\u03b3, deg'
    yAxisTitle: 'Counts'

    property string gammaColumn:  'user gamma [deg]'
    property string dSpacingColumn: 'two_theta [deg]'
    property string customDataColumn: 'custom_data'
    property string plot1dFilepath: Globals.BackendWrapper.rawDataPlot1dFilepath
    property real minTwoTheta1D: Globals.BackendWrapper.rawDataMinTwoThetaCenter1D
    property real sliderValue1D: Globals.BackendWrapper.rawDataTwoThetaSliderValue1D
    property bool resetSlider1D: Globals.BackendWrapper.rawDataResetTwoThetaSlider1D

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
                getData1DFromJson(Qt.resolvedUrl(plot1dFilepath), minTwoTheta1D)
                line1d.setXAxisTitle()
                line1d.setYAxisTitle()
            }
            else {
                console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
            }
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    onPlot1dFilepathChanged: {
        if (loadSucceededStatus) {
            if (resetSlider1D) {
                getData1DFromJson(Qt.resolvedUrl(plot1dFilepath), minTwoTheta1D)
            } else {
                getData1DFromJson(Qt.resolvedUrl(plot1dFilepath), sliderValue1D)
            }
        }
    }

    onSliderValue1DChanged: {
        if (loadSucceededStatus) {
            getData1DFromJson(Qt.resolvedUrl(plot1dFilepath), sliderValue1D)
        }
    }

    function getData1DFromJson(jsonFilename, sliderValue){
        console.debug(`${this} getData1DFromJson from file ${jsonFilename} for two theta=${sliderValue}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let uniqueDSpacing = result[dSpacingColumn]
            let uniqueGamma = result[gammaColumn]
            let customData = result[customDataColumn]

            let countsData = extractCustomColumnByIndex(customData, 2)
            let sliderIndx = getIndxByValue(uniqueDSpacing, sliderValue)

            let twoThetaArray = Array(uniqueGamma.length).fill(uniqueDSpacing[sliderIndx])

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



}
*/
