// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Charts as Charts
import Gui.Globals as Globals

EaCharts.Plotly3dSurfaceNew {
    id: surface3d

    property string xColumn: 'voxel_x [mm]'
    property string yColumn: 'voxel_y [mm]'
    property string zColumn: 'voxel_z [mm]'

    property string gammaColumn: 'user gamma [deg]'
    property string twoThetaColumn: 'two_theta [deg]'
    property string countsColumn: 'proj_count'

    scene: {
        'xaxis': {
            'title': { 'text': 'x, mm', 'font': { 'size': 14 } },
            'autorange': true,
            'zeroline': false,
            'showticklabels': true,
        },
        'yaxis': {
            'title': { 'text': 'y, mm', 'font': { 'size': 14 } },
            'autorange': true,
            'zeroline': false,
            'showticklabels': true,
        },
        'zaxis': {
            'title': {'text': 'z, mm', 'font': { 'size': 14 } },
            'autorange': true,
            'zeroline': false,
            'showticklabels': true,
          },
        'camera': {
            'center': { 'x': 0, 'y': 0, 'z': 0 },
            'eye': { 'x': 0.25, 'y': 0.75, 'z': -1.75 },
            'up': { 'x': 0, 'y': 1, 'z': 0 }
        }
    }

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            console.debug('WebEngineView Loaded! Now loading JSON...')
            if (Globals.BackendWrapper.activeBackend.toString().includes("QMLTYPE")) {
                getData3DFromJson(Qt.resolvedUrl(Globals.BackendWrapper.rawDataPlot3dFilepath))
                surface3d.setScene()
            }
            else {
                console.debug('NOT IMPLEMENTED: python backend for data rpocessing is not implemented yet.')
            }
        } else {
            console.debug('WebEngineView not ready yet.')
        }
    }

    function getData3DFromJson(jsonFilename){
        console.debug(`${this} getDataFromJson from file ${jsonFilename}`)
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let xData = Object.values(result[xColumn])
            let yData = Object.values(result[yColumn])
            let zData = Object.values(result[zColumn])
            let gammaData = Object.values(result[gammaColumn])
            let twoThetaData = Object.values(result[twoThetaColumn])
            let countsData = Object.values(result[countsColumn])

            let uniqueGammaData = gammaData.filter(onlyUnique)
            let cylinderXValues = []
            let cylinderYValues = []
            let cylinderZValues = []
            let cylinderProjectionCounts = []
            let hoverText = []

            //loop over unique values of gamma
            for (let i = 0; i < uniqueGammaData.length; i++) {
                //go through variables at fixed gamma;
                let indicesAtCurrentGamma = getIndxByValue(gammaData, uniqueGammaData[i])
                let xAtCurrentGamma = getValueByIndex(xData, indicesAtCurrentGamma)
                let yAtCurrentGamma = getValueByIndex(yData, indicesAtCurrentGamma)
                let zAtCurrentGamma = getValueByIndex(zData, indicesAtCurrentGamma)
                let customYAtCurrentGamma = getValueByIndex(twoThetaData, indicesAtCurrentGamma)
                let customZAtCurrentGamma = getValueByIndex(countsData, indicesAtCurrentGamma)
                let hoverAtCurrentGamma = []
                // prepare hover data
                for (let j = 0; j < customYAtCurrentGamma.length; j++) {
                hoverAtCurrentGamma.push(`2\u03b8: ${customYAtCurrentGamma[j]}\u00B0,`+
                    `\u03b3: ${uniqueGammaData[i]}\u00B0,`+
                    `z: ${zAtCurrentGamma[j].toFixed(3)} mm,`+
                    `Counts: ${customZAtCurrentGamma[j]}`);
                }
                hoverAtCurrentGamma = formatHover(hoverAtCurrentGamma)
                cylinderXValues.push(xAtCurrentGamma)
                cylinderYValues.push(yAtCurrentGamma)
                cylinderZValues.push(zAtCurrentGamma)
                cylinderProjectionCounts.push(customZAtCurrentGamma)
                hoverText.push(hoverAtCurrentGamma)
            }

            plotData = {
                'x': cylinderXValues,
                'y': cylinderYValues,
                'z': cylinderZValues,
                'surfaceColor': cylinderProjectionCounts,
                'hoverText': hoverText,
                'colorbarTitle': 'Counts'
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

    function formatHover(array) {
        return array.map(element => element.split(',').join('<br>'));
    }

}
