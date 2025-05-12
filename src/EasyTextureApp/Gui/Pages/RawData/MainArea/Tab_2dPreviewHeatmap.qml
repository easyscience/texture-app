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
    property string customDataColumn: 'custom_data'
    property string plot2dFilepath: Globals.BackendWrapper.rawDataPlot2dFilepath //rawDataPlot2dFilepath

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
                getData2DFromJson(Qt.resolvedUrl(plot2dFilepath))
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

    onPlot2dFilepathChanged: {
        if (loadSucceededStatus) {
            getData2DFromJson(Qt.resolvedUrl(plot2dFilepath))
            heatmap2d.setXAxisTitle()
            heatmap2d.setYAxisTitle()
        }
    }

    function getData2DFromJson(jsonFilename){
        console.debug(`${this} getDataFromJson from file ${jsonFilename}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let uniqueTwoTheta = result[twoThetaColumn]
            let uniqueGamma = result[gammaColumn]
            // replace undefined by null
            uniqueGamma = uniqueGamma.map(value => value === undefined ? null : value);
            //customData: [0]: two_theta, [1]: gamma, [2]: counts
            let customData = result[customDataColumn]
            let countsData = extractCustomColumnByIndex(customData, 2)
            // replace undefined by null
            countsData = countsData.map(row => row.map(value => value === undefined ? null : value));;

            plotData = {
                'x': uniqueTwoTheta,
                'y': uniqueGamma,
                'z': countsData,
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

    function extractCustomColumnByIndex(customData, i) {
      // extract the i-th element from each sub-array in customData
      let extractedCustomColumn = customData.map(row => row.map(arr => arr[i]))
      return extractedCustomColumn
    }

}
