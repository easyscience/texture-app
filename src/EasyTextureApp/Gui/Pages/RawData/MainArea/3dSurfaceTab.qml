// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals


EaCharts.Plotly3dSurface {
    id: surface3dRawData

    colorbarTitle: 'Counts'

    property string xColumn: 'voxel_x [mm]'
    property string yColumn: 'voxel_y [mm]'
    property string customDataColumn: 'custom_data'

    property string plotFilepath: Globals.BackendWrapper.rawDataPlotFilepath3D
    property real twoThetaBinWidthValue: Globals.BackendWrapper.rawDataTwoThetaBinWidth3D
    property real gammaBinWidthValue: Globals.BackendWrapper.rawDataGammaBinWidth3D
    property real sliderIndxValue: Globals.BackendWrapper.rawDataTwoThetaSliderIndex3D
    property bool resetSlider: Globals.BackendWrapper.rawDataResetTwoThetaSlider

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
            Globals.BackendWrapper.rawDataGenerateSurfacePlot3D(surface3dRawData, plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, 0)
            setScene()
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
                Globals.BackendWrapper.rawDataTwoThetaSliderIndex3D = 0
                Globals.BackendWrapper.rawDataTwoThetaSliderIndexSync = 0
            }
            Globals.BackendWrapper.rawDataUpdateSurfacePlotTwoThetaBinWidth3D(surface3dRawData, twoThetaBinWidthValue, gammaBinWidthValue, sliderIndxValue)
            setColorbarTitle()

            if (Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex1D = Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex3D
            }
        }
    }

    onGammaBinWidthValueChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataUpdateSurfacePlotGammaBinWidth3D(surface3dRawData, twoThetaBinWidthValue, gammaBinWidthValue, sliderIndxValue)
            setColorbarTitle()
            if (Globals.BackendWrapper.rawDataCalculateViewsAtOnce) {
                Globals.BackendWrapper.rawDataGammaBinWidthIndex1D = Globals.BackendWrapper.rawDataGammaBinWidthIndex3D
                //Globals.BackendWrapper.rawDataUpdateSliceData1D(Globals.References.pages.rawData.mainArea.tabLinePlot1d, sliderIndxValue)
                //Globals.References.pages.rawData.sidebar.basic.groups.binning1d.twoThetaSlider.value = Globals.BackendWrapper.rawDataTwoThetaSliderValue3D
            }
        }
    }

    onPlotFilepathChanged: {
        if (loadSucceededStatus) {
            Globals.BackendWrapper.rawDataGenerateSurfacePlot3D(surface3dRawData, plotFilepath, twoThetaBinWidthValue, gammaBinWidthValue, 0)
            setColorbarTitle()
        }
    }


    function getData3DFromJson(jsonFilename, sliderIndx, callback) {
        runJavaScript(`getDataFromJson(${JSON.stringify(jsonFilename)})`, function(result){
            let xData = result[xColumn]
            let yData = result[yColumn]
            //customData: [0]: two_theta, [1]: gamma, [2]: z, [3]: counts
            let customData = result[customDataColumn]
            let zData = extractCustomColumnByIndex(customData, 2)
            let countsData = extractCustomColumnByIndex(customData, 3)

            // sends values to your callback to wait for full completion of runJavaScript
            callback(xData, yData, zData, countsData, customData)
        })
    }

    function extractCustomColumnByIndex(customData, i) {
      // extract the i-th element from each sub-array in customData
      let extractedCustomColumn = customData.map(row => row.map(arr => arr[i]));
      // reshape the array to match the expected structure (transpose the 2D array)
      let customColumn = extractedCustomColumn[0].map((_, colIndex) => extractedCustomColumn.map(row => row[colIndex]))
      return customColumn
    }

    Component.onCompleted: Globals.References.pages.rawData.mainArea.tabSurfacePlot3d = surface3dRawData

}
