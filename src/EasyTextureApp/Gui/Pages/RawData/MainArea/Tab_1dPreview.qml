// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals
import Gui.Charts as Charts

EaCharts.Plotly1dLineNew {
    id: line1d

    xAxisTitle: '\u03b3, deg'
    yAxisTitle: 'Counts'

    property string gammaColumn:  'user gamma [deg]'
    property string countsColumn:  'proj_count'
    property string twoThetaColumn: 'two_theta [deg]'

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
                getData1DFromJson(Qt.resolvedUrl(Globals.BackendWrapper.rawDataPlot1dFilepath), 45.5)
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

    function getData1DFromJson(jsonFilename, sliderValue){
        console.debug(`${this} getData1DFromJson from file ${jsonFilename} at two theta ${sliderValue}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let gammaData = Object.values(result[gammaColumn])
            let countsData = Object.values(result[countsColumn])
            let twoThetaData = Object.values(result[twoThetaColumn])

            let animationDataIndices = getIndxByValue(twoThetaData, sliderValue)
            let animationGammaData = getValueByIndex(gammaData, animationDataIndices)
            let animationCountsData = getValueByIndex(countsData, animationDataIndices)
            plotData = {
                'x': animationGammaData,
                'y': animationCountsData,
                'hoverTemplate': '\u03b3: %{x}\u00B0<br>'+
                                 'Counts: %{y}'
            }
        })
    }

    function getIndxByValue(object, value) {
        return Object.keys(object).filter(indx => object[indx] === value);
    }

    function getValueByIndex(valueArray, indxArray) {
        return indxArray.map(indx => valueArray[indx]);
    }

    function onlyUnique(value, index, array) {
        return array.indexOf(value) === index;
    }

    /*function getSliderValues(){
        return twoThetaData.filter(onlyUnique)
    }*/

}
