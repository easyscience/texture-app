// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {
    property bool loaded: false
    readonly property bool syncTabsBinnings: true

    readonly property real minTwoTheta: 45
    readonly property real maxTwoTheta: 135
    readonly property real gammaHoleLow: 225.0
    readonly property real gammaHoleHigh: 315.0

    property real minTwoThetaCenter: 45.25
    property real maxTwoThetaCenter: 134.75
    property real gammaHoleLowCenter: 225.0
    property real gammaHoleHighCenter: 315.0



    // Load measurements group
    property var measurements: []
    readonly property var measurementNames: measurements.map(function (item) { return item.name })
    property string selectedFilePath: ''
    readonly property int currentMeasurementIndex: -1
    property string plot3dFilepath: '../../../../../../examples/RawData/user_voxels_3D_1.json'
    property string plot2dHeatmapFilepath: '../../../../../../examples/RawData/user_voxels_2D_1.json'
    property string plot2dPolarHeatmapFilepath: '../../../../../../examples/RawData/user_voxels_2D_1.json'
    property string plot1dFilepath: '../../../../../../examples/RawData/user_voxels_2D_1.json'

    onPlot3dFilepathChanged: {
        generate3dSurfacePlot(plot3dFilepath, twoThetaBinWidth, gammaBinWidth)
    }
    onPlot2dHeatmapFilepathChanged: {
        generate2dHeatmapPlot(plot2dHeatmapFilepath, twoThetaBinWidth, gammaBinWidth)
    }
    onPlot2dPolarHeatmapFilepathChanged: {
        generate2dPolarHeatmapPlot(plot2dPolarHeatmapFilepath, twoThetaBinWidth, gammaBinWidth)
    }
    onPlot1dFilepathChanged: {
        generate1dLinePlot(plot1dFilepath, twoThetaBinWidth, gammaBinWidth)
    }

    function loadMeasurement(filePath) {
        console.debug(`QML backend: Loading pre-saved mock-up files instead of the selected file ${filePath}.`)
        generate3dSurfacePlot(filePath, twoThetaBinWidth, gammaBinWidth)
        generate2dHeatmapPlot(filePath, twoThetaBinWidth, gammaBinWidth)
        generate2dPolarHeatmapPlot(filePath, twoThetaBinWidth, gammaBinWidth)
        generate1dLinePlot(filePath, twoThetaBinWidth, gammaBinWidth)
    }

    function generate3dSurfacePlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`QML backend for generate3dSurfacePlot. Load ${plot3dFilepath} with (twoThetaBinWidth, gammaBinWidth): (${twoThetaBinWidth}, ${gammaBinWidth}).`)
        //let twoThetaBinSize = getTwoThetaBinning(twoThetaBinWidthIndex)
        //let gammaBinSize = getGammaBinning(gammaBinWidthIndex)
    }

    function generate2dHeatmapPlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`QML backend for generate2dHeatmapPlot. Load ${plot2dHeatmapFilepath} with (twoThetaBinWidth, gammaBinWidth): (${twoThetaBinWidth}, ${gammaBinWidth}).`)
        //let twoThetaBinSize = getTwoThetaBinning(twoThetaBinWidthIndex)
        //let gammaBinSize = getGammaBinning(gammaBinWidthIndex)
    }

    function generate2dPolarHeatmapPlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`QML backend for generate2dPolarHeatmapPlot. Load ${plot2dPolarHeatmapFilepath} with (twoThetaBinWidth, gammaBinWidth): (${twoThetaBinWidth}, ${gammaBinWidth}).`)
        //let twoThetaBinSize = getTwoThetaBinning(twoThetaBinWidthIndex)
        //let gammaBinSize = getGammaBinning(gammaBinWidthIndex)
    }

    function generate1dLinePlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`QML backend for generate1dLinePlot. Load ${plot1dFilepath} with (twoThetaBinWidth, gammaBinWidth): (${twoThetaBinWidth}, ${gammaBinWidth}).`)
        //let twoThetaBinSize = getTwoThetaBinning(twoThetaBinWidthIndex)
        //let gammaBinSize = getGammaBinning(gammaBinWidthIndex)
    }

    function setCurrentMeasurementIndex(value) {
        console.debug(`setCurrentMeasurementIndex ${value}: NOT IMPLEMENTED`)
    }

    function setSelectedFilename(path, name) {
        console.debug(`setSelectedFileName to ${name}`)

        // Check if the path already exists in the measurements array
        var pathExists = measurements.some(function(entry) {
            return entry.path === path;
        });

        if (!pathExists) {
            var newEntry = {
                'indx': measurements.length + 1,
                'path':  path,
                'name':  name
            };
            measurements = measurements.concat([newEntry])
        } else {
            console.debug(`Path ${path} already exists.`);
        }
    }

    function removeFilename(text) {
        measurements = measurements.filter(item => item.name !== text)
        console.debug(`removeFilename with name ${text}`)
    }

    /*function getTwoThetaBinning(twoThetaBinWidthIndex) {
        console.debug(`getTwoThetaBinning for two theta index ${twoThetaBinWidthIndex}`)
        const twoTheta = [0.5, 1]
        // in final version
        //const twoTheta = [0.1, 0.25, 0.5, 0.75, 1, 2, 5, 10];
        return twoTheta[twoThetaBinWidthIndex]
    }

    function getGammaBinning(gammaBinWidthIndex) {
        console.debug(`getGammaBinning for gamma index ${gammaBinWidthIndex}`)
        const gamma = [1, 2]
        // in final version
        //const gamma = [0.1, 1, 2, 5, 10]
        return gamma[gammaBinWidthIndex]
    }

    function getBinning(twoThetaBinWidthIndex, gammaBinWidthIndex) {
        let twoThetaBinning = getTwoThetaBinning(twoThetaBinWidthIndex)
        let gammaBinning = getGammaBinning(gammaBinWidthIndex)
        console.debug(`getBinning: two_theta_bin_width ${twoThetaBinning} and gamma_bin_width ${gammaBinning}`)
        return [twoThetaBinning, gammaBinning]
    }*/

    //Binning Group
    property int selectedTabIndex: 0
    property int twoThetaBinWidthIndex: 0
    property real twoThetaBinWidth: 0.5
    property int gammaBinWidthIndex: 0
    property real gammaBinWidth: 1.0

    /*function updateFigure(tab_indx) {
        console.debug(`updateFigure for tab ${tab_indx}: NOT IMPLEMENTED`)
        let mockBinningIndex = 2*twoThetaBinWidthIndex + gammaBinWidthIndex + 1
        console.debug('mockBinningIndex: ', mockBinningIndex)
        if (tab_indx === 0) {
            plot3dFilepath = '../../../../../../examples/RawData/user_voxels_3D_%1.json'.arg(mockBinningIndex)
        } else if (tab_indx === 1 || tab_indx === 2 || tab_indx === 3) {
            plot2dHeatmapFilepath = '../../../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
            plot2dPolarHeatmapFilepath = '../../../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
            plot1dFilepath = '../../../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        } else {
            console.debug('updateFigure: Unsupported tab index')
        }
    }*/

    /*function updateTwoThetaBinData(two_theta_bin_width_indx) {
        if (two_theta_bin_width_indx === 0) {
            twoThetaBinWidth = 0.5
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter = 45.25 //centers[0]
            maxTwoThetaCenter = 134.75 //centers[-1]
            console.debug(`updated two theta bin data to bin width: ${twoThetaBinWidth}, and (min, max) two theta to (${minTwoThetaCenter}, ${maxTwoThetaCenter})`)
        } else if (two_theta_bin_width_indx === 1) {
            twoThetaBinWidth = 1
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter = 45.5 //centers[0]
            maxTwoThetaCenter = 134.5 //centers[-1]
            console.debug(`updated two theta bin data to bin width: ${twoThetaBinWidth}, and (min, max) two theta to (${minTwoThetaCenter}, ${maxTwoThetaCenter})`)
        } else {
            console.debug(`updateTwoThetaBinData for two theta index ${two_theta_bin_width_indx}: NOT IMPLEMENTED`)
        }
    }*/

    /*function updateGammaBinData(gamma_bin_width_indx) {
        if (gamma_bin_width_indx === 0) {
            gammaBinWidth = 1
            // centers, edges = bins_gamma(gamma_hole_low, gamma_hole_high, 1, drop_incomplete=True, with_hole=False)
            gammaHoleLowCenter = 224.5 //centers[-1]
            gammaHoleHighCenter = 315.5 //centers[0]
            console.debug(`updateGammaBinData to ${gammaBinWidth}`)
        } else if (gamma_bin_width_indx === 1) {
            gammaBinWidth = 2
            // centers, edges = bins_gamma(gamma_hole_low, gamma_hole_high, 2, drop_incomplete=True, with_hole=False)
            gammaHoleLowCenter = 223 //centers[-1]
            gammaHoleHighCenter = 317 //centers[0]
            console.debug(`updateGammaBinData to ${gammaBinWidth}`)
        } else {
            console.debug(`updateGammaBinData for two theta index ${gamma_bin_width_indx}: NOT IMPLEMENTED`)
        }
    }*/

    // Binning 3D
    property int twoThetaBinWidthIndex3D: 0
    property int gammaBinWidthIndex3D: 0

    function update3DTwoThetaBinningData(selectedBinWidthIndexValue){
        console.debug(`Starting to update3DTwoThetaBinningData...`)
        update3DTwoThetaBinWidthIndex(selectedBinWidthIndexValue)
    }

    function update3DTwoThetaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update3DTwoThetaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            twoThetaBinWidthIndex = selectedBinWidthIndexValue
        } else {
            twoThetaBinWidthIndex3D = selectedBinWidthIndexValue
        }
    }

    function update3DGammaBinningData(selectedBinWidthIndexValue){
        console.debug(`Starting to update3DGammaBinningData...`)
        update3DGammaBinWidthIndex(selectedBinWidthIndexValue)
    }

    function update3DGammaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update3DGammaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            gammaBinWidthIndex = selectedBinWidthIndexValue
        } else {
            gammaBinWidthIndex3D = selectedBinWidthIndexValue
        }
    }

    // Binning 2D
    property int twoThetaBinWidthIndex2D: 0
    property int gammaBinWidthIndex2D: 0

    property real twoThetaRingsSliderValue: minTwoThetaCenter

    function update2DTwoThetaBinningData(selectedBinWidthIndexValue){
        console.debug(`Starting to update2DTwoThetaBinningData...`)
        update2DTwoThetaBinWidthIndex(selectedBinWidthIndexValue)
    }

    function update2DTwoThetaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update2DTwoThetaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            twoThetaBinWidthIndex = selectedBinWidthIndexValue
        } else {
            twoThetaBinWidthIndex2D = selectedBinWidthIndexValue
        }
    }

    function update2DGammaBinningData(selectedBinWidthIndexValue){
        console.debug(`Starting to update2DGammaBinningData...`)
        update2DGammaBinWidthIndex(selectedBinWidthIndexValue)
    }

    function update2DGammaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update2DGammaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            gammaBinWidthIndex = selectedBinWidthIndexValue
        } else {
            gammaBinWidthIndex2D = selectedBinWidthIndexValue
        }
    }

    // Binning 1D
    property int twoThetaBinWidthIndex1D: 0
    property int gammaBinWidthIndex1D: 0
    property real twoThetaSlider1DValue: minTwoThetaCenter

    function update1DTwoThetaBinningData(twoThetaBinWidthIndx){
        console.debug(`Starting to update 1DTwoThetaBinningData...`)
        update1DTwoThetaBinWidthIndex(twoThetaBinWidthIndx)
        update1DTwoThetaSliderData(twoThetaBinWidthIndx)
        update1DPlotFilepath(twoThetaBinWidthIndx, gammaBinWidthIndex1D)
    }

    function update1DPlotFilepath(twoThetaBinWidthIndx, gammaBinWidthIndx) {
        let mockBinningIndex = 2 * twoThetaBinWidthIndx + gammaBinWidthIndx + 1
        plot1dFilepath = '../../../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
    }

    function update1DTwoThetaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update1DTwoThetaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            twoThetaBinWidthIndex = selectedBinWidthIndexValue
        } else {
            twoThetaBinWidthIndex1D = selectedBinWidthIndexValue
        }
    }

    function update1DTwoThetaSliderData(twoThetaBinWidthIndx) {
        if (twoThetaBinWidthIndx === 0) {
            twoThetaBinWidth = 0.5
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter = 45.25 //centers[0]
            maxTwoThetaCenter = 134.75 //centers[-1]
            console.debug(`Updated two theta bin width 1D to ${twoThetaBinWidth}, and slider edges to (min=${minTwoThetaCenter}, max=${maxTwoThetaCenter})`)
        } else if (twoThetaBinWidthIndx === 1) {
            twoThetaBinWidth = 1
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter = 45.5 //centers[0]
            maxTwoThetaCenter = 134.5 //centers[-1]
            console.debug(`Updated two theta bin width 1D to ${twoThetaBinWidth}, and slider edges to (min=${minTwoThetaCenter}, max=${maxTwoThetaCenter})`)
        } else {
            console.debug(`WARNING: update1DTwoThetaSliderData for two theta bin width index ${two_theta_bin_width_indx} is not implemented.`)
        }
        twoThetaSlider1DValue = minTwoThetaCenter
        console.debug(`twoThetaSlider1DValue: ${twoThetaSlider1DValue}`)

    }

    function update1DGammaBinningData(selectedBinWidthIndexValue){
        console.debug(`Starting to update 1DGammaBinningData...`)
        update1DGammaBinWidthIndex(selectedBinWidthIndexValue)
    }

    function update1DGammaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update1DGammaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            gammaBinWidthIndex = selectedBinWidthIndexValue
        } else {
            gammaBinWidthIndex1D = selectedBinWidthIndexValue
        }
    }

}
