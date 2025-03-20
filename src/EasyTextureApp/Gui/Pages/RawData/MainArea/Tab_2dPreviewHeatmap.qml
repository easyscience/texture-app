// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Charts as Charts
import Gui.Globals as Globals

EaCharts.Plotly2dHeatmapNew {
    id: heatmap2d

    xAxisTitle: '2\u03b8, deg'
    yAxisTitle: '\u03b3, deg'

    property string twoThetaColumn: 'two_theta [deg]'
    property string gammaColumn: 'user gamma [deg]'
    property string countsColumn: 'proj_count'

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
                getData2DFromJson(Qt.resolvedUrl(Globals.BackendWrapper.rawDataPlot2dHeatmapFilepath))
                heatmap2d.setXAxisTitle()
                heatmap2d.setYAxisTitle()
            }
            else {
                console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
            }
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }


    function getData2DFromJson(jsonFilename){
        console.debug(`${this} getDataFromJson from file ${jsonFilename}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let twoThetaData = Object.values(result[twoThetaColumn])
            let gammaData = Object.values(result[gammaColumn])
            let countsData = Object.values(result[countsColumn])

            let uniqueTwoTheta = twoThetaData.filter(onlyUnique)
            let uniqueGamma = gammaData.filter(onlyUnique)

            let counts = [];
            for (let i = 0; i < uniqueGamma.length; i++) {
                let indicesAtCurrentGamma = getIndxByValue(gammaData, uniqueGamma[i]);
                let countsAtCurrentGamma = getValueByIndex(countsData, indicesAtCurrentGamma);
                counts.push(countsAtCurrentGamma);
            }

            plotData = {
                'x': uniqueTwoTheta,
                'y': uniqueGamma,
                'z': counts,
                'colorbarTitle': 'Counts',
                'hoverTemplate': '2\u03b8: %{x}\u00B0<br>'+
                                 '\u03b3: %{y}\u00B0<br>'+
                                 'Counts: %{z}',
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

}
