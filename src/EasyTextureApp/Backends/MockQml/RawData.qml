// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {
    property bool loaded: false
    readonly property bool syncTabsBinnings: true

    //readonly property real minTwoTheta: 45
    //readonly property real maxTwoTheta: 135
    //readonly property real gammaHoleLow: 225.0
    //readonly property real gammaHoleHigh: 315.0

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
    property string plot2dFilepath: '../../../../../../examples/RawData/user_voxels_2D_1.json'
    property string plot1dFilepath: '../../../../../../examples/RawData/user_voxels_2D_1.json'

    onPlot3dFilepathChanged: {
        generate3dSurfacePlot(plot3dFilepath, twoThetaBinWidth, gammaBinWidth)
    }
    onPlot2dFilepathChanged: {
        generate2dHeatmapPlot(plot2dFilepath, twoThetaBinWidth, gammaBinWidth)
        generate2dPolarHeatmapPlot(plot2dFilepath, twoThetaBinWidth, gammaBinWidth)
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
    }

    function generate2dHeatmapPlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`QML backend for generate2dHeatmapPlot. Load ${plot2dFilepath} with (twoThetaBinWidth, gammaBinWidth): (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    function generate2dPolarHeatmapPlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`QML backend for generate2dPolarHeatmapPlot. Load ${plot2dFilepath} with (twoThetaBinWidth, gammaBinWidth): (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    function generate1dLinePlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`QML backend for generate1dLinePlot. Load ${plot1dFilepath} with (twoThetaBinWidth, gammaBinWidth): (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    function setCurrentMeasurementIndex(value) {
        console.debug(`setCurrentMeasurementIndex ${value}: NOT IMPLEMENTED`)
    }

    function setSelectedFilename(path, name) {
        console.debug(`setSelectedFileName to ${name}`)

        // Check if the path already exists in the measurements array
        var pathExists = measurements.some(function(entry) {
            return entry.path === path
        })

        if (!pathExists) {
            var newEntry = {
                'indx': measurements.length + 1,
                'path':  path,
                'name':  name
            }
            measurements = measurements.concat([newEntry])
        } else {
            console.debug(`Path ${path} already exists.`)
        }
    }

    function removeFilename(text) {
        measurements = measurements.filter(item => item.name !== text)
        console.debug(`removeFilename with name ${text}`)
    }

    //Binning Group
    property int selectedTabIndex: 0

    property int twoThetaBinWidthIndexMD: 0
    property int gammaBinWidthIndexMD: 0
    property real twoThetaBinWidth: 0.5
    property real gammaBinWidth: 1.0


    // Binning 3D
    property int twoThetaBinWidthIndex3D: 0
    property int gammaBinWidthIndex3D: 0

    function update3DTwoThetaBinningData(selectedBinWidthIndexValue){
        console.debug(`Starting to update 3DTwoThetaBinningData...`)
        let currentGammaBinWidthIndex = getCurrentGammaBinWidthIndex3D()
        update3DTwoThetaBinWidthIndex(selectedBinWidthIndexValue)
        update3DPlotFilepath(selectedBinWidthIndexValue, currentGammaBinWidthIndex)
        console.debug(`Finished updating 3DTwoThetaBinningData...`)
    }

    function getCurrentGammaBinWidthIndex3D(){
        if (syncTabsBinnings) {
            return gammaBinWidthIndexMD
        } else {
            return gammaBinWidthIndex3D
        }
    }
    function update3DTwoThetaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update3DTwoThetaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            twoThetaBinWidthIndexMD = selectedBinWidthIndexValue
        } else {
            twoThetaBinWidthIndex3D = selectedBinWidthIndexValue
        }
    }

    function update3DPlotFilepath(twoThetaBinWidthIndx, gammaBinWidthIndx) {
        let mockBinningIndex = 2 * twoThetaBinWidthIndx + gammaBinWidthIndx + 1
        plot3dFilepath = '../../../../../../examples/RawData/user_voxels_3D_%1.json'.arg(mockBinningIndex)
        console.debug(`update3DPlotFilepath to ${plot3dFilepath}`)
    }

    function update3DGammaBinningData(selectedBinWidthIndexValue){
        console.debug(`Starting to update3DGammaBinningData...`)
        let currentTwoThetaBinWidthIndex = getCurrentTwoThetaBinWidthIndex3D()
        update3DGammaBinWidthIndex(selectedBinWidthIndexValue)
        update3DPlotFilepath(currentTwoThetaBinWidthIndex, selectedBinWidthIndexValue)
        console.debug(`Finished updating 3DGammaBinningData...`)
    }

    function getCurrentTwoThetaBinWidthIndex3D(){
        if (syncTabsBinnings) {
            return twoThetaBinWidthIndexMD
        } else {
            return twoThetaBinWidthIndex3D
        }
    }

    function update3DGammaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update3DGammaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            gammaBinWidthIndexMD = selectedBinWidthIndexValue
        } else {
            gammaBinWidthIndex3D = selectedBinWidthIndexValue
        }
    }

    // Binning 2D
    property int twoThetaBinWidthIndex2D: 0
    property real minTwoThetaCenter2D: 45.25
    property real maxTwoThetaCenter2D: 134.75
    property real twoThetaBinWidth2D: 0.5
    property real twoThetaRingsSliderValue2D: minTwoThetaCenter2D

    property int gammaBinWidthIndex2D: 0
    property real gammaBinWidth2D: 1.0

    function update2DTwoThetaBinningData(selectedBinWidthIndexValue){
        console.debug(`Starting to update 2DTwoThetaBinningData...`)
        let currentGammaBinWidthIndex = getCurrentGammaBinWidthIndex2D()
        update2DTwoThetaBinWidthIndex(selectedBinWidthIndexValue)
        update2DTwoThetaSliderData(selectedBinWidthIndexValue)
        update2DPlotFilepath(selectedBinWidthIndexValue, currentGammaBinWidthIndex)
        console.debug(`Finished updating 2DTwoThetaBinningData...`)
    }

    function getCurrentGammaBinWidthIndex2D(){
        if (syncTabsBinnings) {
            return gammaBinWidthIndexMD
        } else {
            return gammaBinWidthIndex2D
        }
    }

    function update2DTwoThetaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update2DTwoThetaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            twoThetaBinWidthIndexMD = selectedBinWidthIndexValue
        } else {
            twoThetaBinWidthIndex2D = selectedBinWidthIndexValue
        }
    }

    function update2DTwoThetaSliderData(twoThetaBinWidthIndx) {
        if (twoThetaBinWidthIndx === 0) {
            twoThetaBinWidth2D = 0.5
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter2D = 45.25 //centers[0]
            maxTwoThetaCenter2D = 134.75 //centers[-1]
            console.debug(`update2DTwoThetaSliderData to bin_width=${twoThetaBinWidth2D}, and slider edges to (min=${minTwoThetaCenter2D}, max=${maxTwoThetaCenter2D})`)
        } else if (twoThetaBinWidthIndx === 1) {
            twoThetaBinWidth2D = 1
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter2D = 45.5 //centers[0]
            maxTwoThetaCenter2D = 134.5 //centers[-1]
            console.debug(`update2DTwoThetaSliderData to bin_width=${twoThetaBinWidth2D}, and slider edges to (min=${minTwoThetaCenter2D}, max=${maxTwoThetaCenter2D})`)
        } else {
            console.debug(`WARNING: update2DTwoThetaSliderData for two theta bin width index ${twoThetaBinWidthIndx} is not implemented.`)
        }
        twoThetaRingsSliderValue2D = minTwoThetaCenter2D
        console.debug(`twoThetaRingsSliderValue2D is changed to ${twoThetaRingsSliderValue2D}`)
    }

    function update2DPlotFilepath(twoThetaBinWidthIndx, gammaBinWidthIndx) {
        let mockBinningIndex = 2 * twoThetaBinWidthIndx + gammaBinWidthIndx + 1
        plot2dFilepath = '../../../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        console.debug(`update2DPlotFilepath to ${plot2dFilepath}`)
    }

    function update2DGammaBinningData(selectedBinWidthIndexValue){
        console.debug(`Starting to update 2DGammaBinningData...`)
        let currentTwoThetaBinWidthIndex = getCurrentTwoThetaBinWidthIndex2D()
        update2DGammaBinWidthIndex(selectedBinWidthIndexValue)
        update2DPlotFilepath(currentTwoThetaBinWidthIndex, selectedBinWidthIndexValue)
        console.debug(`Finished updating 2DGammaBinningData...`)
    }

    function getCurrentTwoThetaBinWidthIndex2D(){
        if (syncTabsBinnings) {
            return twoThetaBinWidthIndexMD
        } else {
            return twoThetaBinWidthIndex2D
        }
    }

    function update2DGammaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update2DGammaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            gammaBinWidthIndexMD = selectedBinWidthIndexValue
        } else {
            gammaBinWidthIndex2D = selectedBinWidthIndexValue
        }
    }

    // Binning 1D
    property int twoThetaBinWidthIndex1D: 0
    property real minTwoThetaCenter1D: 45.25
    property real maxTwoThetaCenter1D: 134.75
    property real twoThetaBinWidth1D: 0.5
    property real twoThetaSliderValue1D: minTwoThetaCenter1D
    property bool resetTwoThetaSlider1D: false

    property int gammaBinWidthIndex1D: 0
    property real gammaBinWidth1D: 1.0

    function update1DTwoThetaBinningData(twoThetaBinWidthIndx){
        console.debug(`Starting to update 1DTwoThetaBinningData...`)
        let currentGammaBinWidthIndex = getCurrentGammaBinWidthIndex1D()
        update1DTwoThetaBinWidthIndex(twoThetaBinWidthIndx)
        update1DTwoThetaSliderData(twoThetaBinWidthIndx)
        update1DTwoThetaSliderResetFlag(true)
        update1DPlotFilepath(twoThetaBinWidthIndx, currentGammaBinWidthIndex)
        console.debug(`Finished updating 1DTwoThetaBinningData...`)
    }

    function getCurrentGammaBinWidthIndex1D(){
        if (syncTabsBinnings) {
            return gammaBinWidthIndexMD
        } else {
            return gammaBinWidthIndex1D
        }
    }

    function update1DTwoThetaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update1DTwoThetaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            twoThetaBinWidthIndexMD = selectedBinWidthIndexValue
        } else {
            twoThetaBinWidthIndex1D = selectedBinWidthIndexValue
        }
    }

    function update1DTwoThetaSliderData(twoThetaBinWidthIndx) {
        if (twoThetaBinWidthIndx === 0) {
            twoThetaBinWidth1D = 0.5
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter1D = 45.25 //centers[0]
            maxTwoThetaCenter1D = 134.75 //centers[-1]
            console.debug(`update1DTwoThetaSliderData to bin_width=${twoThetaBinWidth1D}, and slider edges to (min=${minTwoThetaCenter1D}, max=${maxTwoThetaCenter1D})`)
        } else if (twoThetaBinWidthIndx === 1) {
            twoThetaBinWidth1D = 1
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter1D = 45.5 //centers[0]
            maxTwoThetaCenter1D = 134.5 //centers[-1]
            console.debug(`update1DTwoThetaSliderData to bin_width=${twoThetaBinWidth1D}, and slider edges to (min=${minTwoThetaCenter1D}, max=${maxTwoThetaCenter1D})`)
        } else {
            console.debug(`WARNING: update1DTwoThetaSliderData for two theta bin width index ${twoThetaBinWidthIndx} is not implemented.`)
        }
        twoThetaSliderValue1D = minTwoThetaCenter1D
        console.debug(`twoThetaSliderValue1D is changed to ${twoThetaSliderValue1D}`)
    }

    function update1DPlotFilepath(twoThetaBinWidthIndx, gammaBinWidthIndx) {
        let mockBinningIndex = 2 * twoThetaBinWidthIndx + gammaBinWidthIndx + 1
        plot1dFilepath = '../../../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        console.debug(`update1DPlotFilepath to ${plot1dFilepath}`)
    }

    function update1DTwoThetaSliderResetFlag(flagValue){
        resetTwoThetaSlider1D = flagValue
        console.debug(`update1DTwoThetaSliderResetFlag to ${flagValue}`)
    }

    function update1DGammaBinningData(selectedBinWidthIndexValue){
        console.debug(`Starting to update 1DGammaBinningData...`)
        let currentTwoThetaBinWidthIndex = getCurrentTwoThetaBinWidthIndex1D()
        update1DGammaBinWidthIndex(selectedBinWidthIndexValue)
        update1DTwoThetaSliderResetFlag(false)
        update1DPlotFilepath(currentTwoThetaBinWidthIndex, selectedBinWidthIndexValue)
        console.debug(`Finished updating 1DGammaBinningData...`)
    }

    function getCurrentTwoThetaBinWidthIndex1D(){
        if (syncTabsBinnings) {
            return twoThetaBinWidthIndexMD
        } else {
            return twoThetaBinWidthIndex1D
        }
    }

    function update1DGammaBinWidthIndex(selectedBinWidthIndexValue){
        console.debug(`update1DGammaBinWidthIndex to ${selectedBinWidthIndexValue}`)
        if (syncTabsBinnings) {
            gammaBinWidthIndexMD = selectedBinWidthIndexValue
        } else {
            gammaBinWidthIndex1D = selectedBinWidthIndexValue
        }
    }

    // bins generating functions

    function generateBinEdgesGamma(holeLow, holeHigh, binStep, dropIncomplete) {
        let range1 = generateBinEdges(0, holeLow, binStep, dropIncomplete)
        let range2 = generateBinEdgesReverse(360, holeHigh, binStep, dropIncomplete)
        let finalRange = [...range2, ...range1]

        let bins = []
        for (let i = 0; i < finalRange.length - 1; i++) {
            bins.push([finalRange[i], finalRange[i + 1]])
        }

        return bins
    }

    function generateBinEdgesReverse(maxVal, minVal, binStep, dropIncomplete) {
        let numBins = Math.floor((maxVal - minVal) / binStep)
        let binEdges = linspace(maxVal - binStep, maxVal - numBins * binStep, numBins)

        if (dropIncomplete && binEdges[binEdges.length - 1] < minVal) {
            binEdges = binEdges.slice(0, -1)
        } else if (!dropIncomplete && binEdges[binEdges.length - 1] > minVal) {
            binEdges.push(minVal)
        }

        return binEdges.reverse()
    }

    function generateBinEdges(minVal, maxVal, binStep, dropIncomplete) {
        let numBins = Math.floor((maxVal - minVal) / binStep) + 1
        let binEdges = linspace(minVal, minVal + (numBins - 1) * binStep, numBins)

        if (dropIncomplete && binEdges[binEdges.length - 1] > maxVal) {
            binEdges = binEdges.slice(0, -1)
        } else if (!dropIncomplete && binEdges[binEdges.length - 1] < maxVal) {
            binEdges.push(maxVal)
        }

        return binEdges
    }

    function linspace(start, stop, num) {
        let step = (stop - start) / (num - 1)
        return Array.from({ length: num }, (_, i) => start + i * step)
    }
}
