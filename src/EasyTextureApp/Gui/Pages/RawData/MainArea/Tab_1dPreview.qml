// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals
import Gui.Charts as Charts

EaCharts.Plotly1dLineNew {
    id: line1d

    xAxisTitle: '\u03b3, deg'
    yAxisTitle: 'Counts'

    property string gammaColumn:  'user gamma [deg]'
    property string twoThetaColumn: 'two_theta [deg]'
    property string customDataColumn: 'custom_data'
    property string plot1dFilepath: Globals.BackendWrapper.rawDataPlot1dFilepath
    property real minTT: Globals.BackendWrapper.rawDataMinTwoThetaCenter1D
    property real sliderValue: Globals.BackendWrapper.rawDataTwoThetaSliderValue1D
    //property string sliderValue: Globals.BackendWrapper.rawDataMinTwoThetaCenter

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
                //console.debug('SLIDERV', sliderValue)
                getData1DFromJson(Qt.resolvedUrl(plot1dFilepath), minTT)
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
            //console.debug('SLIDERV2', minTT)
            //sliderValue = minTT
            //print('HERE', minTT)
            getData1DFromJson(Qt.resolvedUrl(plot1dFilepath), minTT)
            //surface3d.setScene()
        }
    }

    onSliderValueChanged: {
        if (loadSucceededStatus) {
            getData1DFromJson(Qt.resolvedUrl(plot1dFilepath), sliderValue)
        }
    }

    function getData1DFromJson(jsonFilename, sld){
        console.debug(`${this} getData1DFromJson from file ${jsonFilename}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let uniqueTwoTheta = result[twoThetaColumn]
            //print('TT', uniqueTwoTheta)
            let uniqueGamma = result[gammaColumn]
            //print('gg', uniqueGamma)
            let customData = result[customDataColumn]

            let countsData = extractCustomColumnByIndex(customData, 2)
            //print('counts', countsData)
            //let minTT
            let sliderIndx = getIndxByValue(uniqueTwoTheta, sld)
            //print('sliderIndx', sliderIndx, 'sl value', sld)

            let twoThetaArray = Array(uniqueGamma.length).fill(uniqueTwoTheta[sliderIndx])
            //print('tt array', twoThetaArray)

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

    /*function getSliderValues(){
        return twoThetaData.filter(onlyUnique)
    }*/

}
