// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {
    property bool loaded: false
    property int selectedTabIndex: 0
    property bool calculateViewsAtOnce: false

    // Load measurements group
    property var measurements: []

    function loadMeasurement(filePath) {
        console.debug(`QML backend: Loading pre-saved mock-up files instead of the selected file ${filePath}.`)
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
    property real minTwoThetaCenter: 45.25
    property real maxTwoThetaCenter: 134.75
    property real gammaHoleLowCenter: 225.0
    property real gammaHoleHighCenter: 315.0

    property real twoThetaBinWidthValueSync: 0.5
    property int twoThetaBinWidthIndexSync: 0
    property real gammaBinWidthValueSync: 1.0
    property int gammaBinWidthIndexSync: 0
    property real twoThetaSliderValueSync: 45.25
    property int twoThetaSliderIndexSync: 0

    property bool resetTwoThetaSlider: true


    // Binning 3D
    property string plotFilepath3D: '../../../../examples/RawData/user_voxels_3D_1.json'

    property int twoThetaBinWidthIndex3D: 0
    property real minTwoThetaCenter3D: 45.25
    property real maxTwoThetaCenter3D: 134.75
    property real twoThetaBinWidth3D: 0.5
    property real twoThetaSliderValue3D: 42.25
    property int twoThetaSliderIndex3D: 0

    property int gammaBinWidthIndex3D: 0
    property real gammaBinWidth3D: 1.0

    property bool runJavaScriptIsOff3D: true

    function updateTwoThetaSliderData3D(twoThetaBinWidthIndx) {
        console.debug(`QML backend for updateTwoThetaSliderData3D`)
        twoThetaBinWidthIndexSync = twoThetaBinWidthIndx
        if (twoThetaBinWidthIndx === 0) {
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter = 45.25 //centers[0]
            maxTwoThetaCenter = 134.75 //centers[-1]
            twoThetaBinWidthValueSync = 0.5
            console.debug(`Updated 3D twoTheta slider data to bin_width=${twoThetaBinWidth3D}, and slider edges to (min=${minTwoThetaCenter3D}, max=${maxTwoThetaCenter3D})`)
        } else if (twoThetaBinWidthIndx === 1) {
            minTwoThetaCenter = 45.5 //centers[0]
            maxTwoThetaCenter = 134.5 //centers[-1]
            twoThetaBinWidthValueSync = 1
            console.debug(`Updated 3D twoTheta slider data to bin_width=${twoThetaBinWidth3D}, and slider edges to (min=${minTwoThetaCenter3D}, max=${maxTwoThetaCenter3D})`)
        } else {
            minTwoThetaCenter = null
            maxTwoThetaCenter = null
            twoThetaBinWidthValueSync = null
            console.debug(`WARNING: Update 3D data for two theta bin width index ${twoThetaBinWidthIndx} is not implemented.`)
        }
        minTwoThetaCenter3D = minTwoThetaCenter
        maxTwoThetaCenter3D = maxTwoThetaCenter
        twoThetaBinWidth3D = twoThetaBinWidthValueSync
    }

    function updateGammaBinWidth3D(gammaBinWidthIndx) {
        console.debug(`QML backend for updateGammaBinWidth3D.`)
        gammaBinWidthIndexSync = gammaBinWidthIndx
        if (gammaBinWidthIndx === 0) {
            gammaBinWidthValueSync = 1.0
        } else if (gammaBinWidthIndx === 1) {
            gammaBinWidthValueSync = 2.0
        } else {
            gammaBinWidthValueSync = null
        }
        gammaBinWidth3D = gammaBinWidthValueSync
    }

    function generateSurfacePlot3D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx) {
        console.debug(`QML backend for generateSurfacePlot3D. Data will be loaded from ${Qt.resolvedUrl(filepath)}.`)
        runJavaScriptIsOff3D = false
        obj.getData3DFromJson(Qt.resolvedUrl(filepath), sliderIndx, function(xData, yData, zData, countsData, customData) {
            let surfacePlotDict = {}
            surfacePlotDict['x'] = xData
            surfacePlotDict['y'] = yData
            surfacePlotDict['z'] = zData
            surfacePlotDict['surfaceColor'] = countsData
            surfacePlotDict['customData'] = customData
            surfacePlotDict['hoverTemplate'] = '2\u03b8: %{customdata[0]}\u00B0<br>'+
                                               '\u03b3: %{customdata[1]}\u00B0<br>'+
                                               'z: %{customdata[2]:.3f} mm<br>'+
                                               'Counts: %{customdata[3]}'
            obj.plotData = surfacePlotDict
            updateSliderPatchData3D(obj, sliderIndx)

            runJavaScriptIsOff3D = true
            console.debug(`End of QML backend for generateSurfacePlot3D: slider index ${twoThetaSliderIndex3D} at ${twoThetaSliderValue3D}.`)
        })
    }

    function updateSliderPatchData3D(obj, sliderIndx) {
        console.debug(`QML backend for updateSliderPatchData3D.`)

        let xData = obj.plotData.x
        let yData = obj.plotData.y
        let zData = obj.plotData.z

        let midZ, midNextZ

        // proper handling of the bin width estimation for the last
        // bin center, when there is no next (i+1) bin.
        if (sliderIndx === zData.length - 1) {
            midZ = zData[sliderIndx]
            midNextZ = zData[sliderIndx - 1]
        } else {
            midZ = zData[sliderIndx]
            midNextZ = zData[sliderIndx + 1]
        }
        let diffMidZ = midNextZ.map((val, i) => Math.abs(val - midZ[i]))

        let topX = xData[sliderIndx]
        let topY = yData[sliderIndx]
        let topZ = midZ.map((val, i) => val + diffMidZ[i] / 2)

        let bottomX = xData[sliderIndx]
        let bottomY = yData[sliderIndx]
        let bottomZ = midZ.map((val, i) => val - diffMidZ[i] / 2)

        // Choose vertical connector points (2 edges)
        let connectorX = [topX[0], bottomX[0], null, topX[topX.length - 1], bottomX[bottomX.length - 1]]
        let connectorY = [topY[0], bottomY[0], null, topY[topY.length - 1], bottomY[bottomY.length - 1]]
        let connectorZ = [topZ[0], bottomZ[0], null, topZ[topZ.length - 1], bottomZ[bottomZ.length - 1]]

        let patchX = [...topX, null, ...bottomX, null, ...connectorX]
        let patchY = [...topY, null, ...bottomY, null, ...connectorY]
        let patchZ = [...topZ, null, ...bottomZ, null, ...connectorZ]

        let patchD = {
          'x': patchX,
          'y': patchY,
          'z': patchZ
        }

        obj.patchData = patchD

        console.debug(`Updated 3D SurfacePlot patchData to slice index = ${sliderIndx}.`)
    }

    function updateSurfacePlotTwoThetaBinWidth3D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        console.debug(`QML backend for updateSurfacePlotTwoThetaBinWidth3D for two theta slider index ${twoThetaSliderIndex}.`)

        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        let filepath3D = '../../../../examples/RawData/user_voxels_3D_%1.json'.arg(mockBinningIndex)
        generateSurfacePlot3D(obj, filepath3D, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)

        console.debug(`End of QML backend for updateSurfacePlotTwoThetaBinWidth3D. Loaded ${filepath3D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    function updateSurfacePlotGammaBinWidth3D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        console.debug(`QML backend for updateSurfacePlotGammaBinWidth3D.`)

        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        let filepath3D = '../../../../examples/RawData/user_voxels_3D_%1.json'.arg(mockBinningIndex)
        generateSurfacePlot3D(obj, filepath3D, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)

        console.debug(`End of QML backend for updateSurfacePlotGammaBinWidth3D. Loaded ${filepath3D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    function getTwoThetaSliderIndex3D() {
        console.debug(`QML backend for getTwoThetaSliderIndex3D.`)
        let sliderIndex = (twoThetaSliderValue3D - minTwoThetaCenter3D) / twoThetaBinWidth3D
        twoThetaSliderIndexSync = sliderIndex
        return sliderIndex
    }


    // Binning 2D
    property string plotFilepath2D: '../../../../examples/RawData/user_voxels_2D_1.json'

    property int twoThetaBinWidthIndex2D: 0
    property real minTwoThetaCenter2D: 45.25
    property real maxTwoThetaCenter2D: 134.75
    property real twoThetaBinWidth2D: 0.5
    property real twoThetaSliderValue2D: minTwoThetaCenter2D
    property int twoThetaSliderIndex2D

    property int gammaBinWidthIndex2D: 0
    property real gammaBinWidth2D: 1.0

    property bool runJavaScriptIsOff2D: true

    function updateTwoThetaSliderData2D(twoThetaBinWidthIndx) {
        twoThetaBinWidthIndexSync = twoThetaBinWidthIndx
        console.debug(`QML backend for updateTwoThetaSliderData2D`)
        if (twoThetaBinWidthIndx === 0) {
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter2D = 45.25 //centers[0]
            maxTwoThetaCenter2D = 134.75 //centers[-1]
            twoThetaBinWidth2D = 0.5
            console.debug(`Updated 2D twoTheta slider data to bin_width=${twoThetaBinWidth2D}, and slider edges to (min=${minTwoThetaCenter2D}, max=${maxTwoThetaCenter2D})`)
        } else if (twoThetaBinWidthIndx === 1) {
            minTwoThetaCenter2D = 45.5 //centers[0]
            maxTwoThetaCenter2D = 134.5 //centers[-1]
            twoThetaBinWidth2D = 1
            console.debug(`Updated 2D twoTheta slider data to bin_width=${twoThetaBinWidth2D}, and slider edges to (min=${minTwoThetaCenter2D}, max=${maxTwoThetaCenter2D})`)
        } else {
            minTwoThetaCenter2D = null
            maxTwoThetaCenter2D = null
            twoThetaBinWidth2D = null
            console.debug(`WARNING: Update 2D twoTheta slider data for two theta bin width index ${twoThetaBinWidthIndx} is not implemented.`)
        }
    }

    function updateGammaBinWidth2D(gammaBinWidthIndx) {
        if (gammaBinWidthIndx === 0) {
            gammaBinWidth2D = 1.0
        } else if (gammaBinWidthIndx === 1) {
            gammaBinWidth2D = 2.0
        } else {
            gammaBinWidth2D = null
        }
        gammaBinWidthIndexSync = gammaBinWidthIndx
    }

    function generateHeatmap2D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx) {
        console.debug(`QML backend for generateHeatmap2D. Data will be loaded from ${Qt.resolvedUrl(filepath)}.`)
        runJavaScriptIsOff2D = false
        obj.getData2DFromJson(Qt.resolvedUrl(filepath), function(uniqueTwoTheta, uniqueGamma, countsData, customData) {
            let heatmapPlotDict = {}
            heatmapPlotDict['x'] = uniqueTwoTheta
            heatmapPlotDict['y'] = uniqueGamma
            heatmapPlotDict['z'] = countsData
            heatmapPlotDict['hoverTemplate'] = '2\u03b8: %{x}\u00B0<br>'+
                                               '\u03b3: %{y}\u00B0<br>'+
                                               'Counts: %{z}'
            obj.plotData = heatmapPlotDict
            runJavaScriptIsOff2D = true
            console.debug(`End of QML backend for generateHeatmap2D: slider index ${twoThetaSliderIndex2D} at ${twoThetaSliderValue2D}.`)
        })
    }

    function updateHeatmapTwoThetaBinWidth2D(obj, twoThetaBinWidth) {
        console.debug(`QML backend for updateHeatmapTwoThetaBinWidth2D.`)

        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth2D)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        let filepath2D = '../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        generateHeatmap2D(obj, filepath2D, twoThetaBinWidth, gammaBinWidth2D, 0)

        console.debug(`End of QML backend for updateHeatmapTwoThetaBinWidth2D. Loaded ${filepath2D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth2D}).`)
    }

    function updateHeatmapGammaBinWidth2D(obj, gammaBinWidth) {
        console.debug(`QML backend for updateHeatmapGammaBinWidth2D.`)

        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth2D, gammaBinWidth)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        let filepath2D = '../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        generateHeatmap2D(obj, filepath2D, twoThetaBinWidth2D, gammaBinWidth, twoThetaSliderIndex2D)

        console.debug(`End of QML backend for updateHeatmapGammaBinWidth2D. Loaded ${filepath2D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth2D}, ${gammaBinWidth}).`)
    }

    // Polar Heatmap

    function generatePolarHeatmap2D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx) {
        console.debug(`QML backend for generatePolarHeatmap2D. Data will be loaded from ${Qt.resolvedUrl(filepath)}.`)
        runJavaScriptIsOff2D = false
        obj.getData2DFromJson(Qt.resolvedUrl(filepath), sliderIndx, function(ringsR, uniqueTwoTheta, ringsGamma, ringsCountsMesh) {
            let polarHeatmapFullDataDict = {}
            polarHeatmapFullDataDict['r'] = ringsR
            polarHeatmapFullDataDict['theta'] = ringsGamma
            polarHeatmapFullDataDict['z'] = ringsCountsMesh
            polarHeatmapFullDataDict['twoTheta'] = uniqueTwoTheta
            obj.fullData = polarHeatmapFullDataDict
            // When gamma width is changed, the slider index remains unchanged, so we want to update the view
            if (twoThetaSliderIndex2D === sliderIndx) {
                updateSliceData2D(obj, sliderIndx)
            } else { // When two theta width is changed, we just change the slider index and the view updates through call in TwoThetaSlider1D.qml
                updateTwoThetaSliderIndex2D()
            }
            runJavaScriptIsOff2D = true
            console.debug(`End of QML backend for generatePolarHeatmap2D: slider index ${twoThetaSliderIndex2D} at ${twoThetaSliderValue2D}. `)
        })
    }

    function updateSliceData2D(obj, sliderIndx) {
        console.debug(`QML backend for updateSliceData2D.`)

        let polarHeatmapPlotDict = {}
        let ringR = obj.fullData.r
        let ringGamma = obj.fullData.theta
        let ringCountsMesh = obj.fullData.z[sliderIndx]
        let twoTheta = obj.fullData.twoTheta[sliderIndx]
        let twoThetaArray = Array(ringCountsMesh.length).fill(twoTheta)

        polarHeatmapPlotDict['r'] = ringR
        polarHeatmapPlotDict['theta'] = ringGamma
        polarHeatmapPlotDict['z'] = ringCountsMesh
        polarHeatmapPlotDict['customData'] = twoThetaArray
        polarHeatmapPlotDict['hoverTemplate'] = '2\u03b8: %{customdata}\u00B0<br>'+
                                        '\u03b3: %{theta}<br>'+
                                        'Counts: %{marker.color}'

        obj.plotData = polarHeatmapPlotDict

        console.debug(`Updated 2D PolarHeatmap plotData to slice index ${sliderIndx}.`)
    }

    function updatePolarHeatmapTwoThetaBinWidth2D(obj, twoThetaBinWidth) {
        console.debug(`QML backend for updatePolarHeatmapTwoThetaBinWidth2D.`)

        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth2D)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        let filepath2D = '../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        generatePolarHeatmap2D(obj, filepath2D, twoThetaBinWidth, gammaBinWidth2D, 0)

        console.debug(`End of QML backend for updatePolarHeatmapTwoThetaBinWidth2D. Loaded ${filepath2D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth2D}).`)
    }

    function updatePolarHeatmapGammaBinWidth2D(obj, gammaBinWidth) {
        console.debug(`QML backend for updatePolarHeatmapGammaBinWidth2D.`)

        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth2D, gammaBinWidth)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        let filepath2D = '../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        generatePolarHeatmap2D(obj, filepath2D, twoThetaBinWidth2D, gammaBinWidth, twoThetaSliderIndex2D)

        console.debug(`End of QML backend for updatePolarHeatmapGammaBinWidth2D. Loaded ${filepath2D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth2D}, ${gammaBinWidth}).`)
    }

    function updateTwoThetaSliderIndex2D() {
        console.debug(`QML backend for updateTwoThetaSliderIndex2D.`)
        twoThetaSliderIndex2D = (twoThetaSliderValue2D - minTwoThetaCenter2D) / twoThetaBinWidth2D
    }

    // Binning 1D
    property string plotFilepath1D: '../../../../examples/RawData/user_voxels_2D_1.json'

    property int twoThetaBinWidthIndex1D: 0
    property real minTwoThetaCenter1D: 45.25
    property real maxTwoThetaCenter1D: 134.75
    property real twoThetaBinWidth1D: 0.5
    property real twoThetaSliderValue1D: 45.25
    property int twoThetaSliderIndex1D: 0

    property int gammaBinWidthIndex1D: 0
    property real gammaBinWidth1D: 1.0

    property bool runJavaScriptIsOff1D: true

    function updateTwoThetaSliderData1D(twoThetaBinWidthIndx) {
        console.debug(`QML backend for updateTwoThetaSliderData1D.`)
        twoThetaBinWidthIndexSync = twoThetaBinWidthIndx
        if (twoThetaBinWidthIndx === 0) {
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter = 45.25 //centers[0]
            maxTwoThetaCenter = 134.75 //centers[-1]
            twoThetaBinWidthValueSync = 0.5
            console.debug(`Updated 1D twoTheta slider data to bin_width=${twoThetaBinWidth1D}, and slider edges to (min=${minTwoThetaCenter1D}, max=${maxTwoThetaCenter1D})`)
        } else if (twoThetaBinWidthIndx === 1) {
            minTwoThetaCenter = 45.5 //centers[0]
            maxTwoThetaCenter = 134.5 //centers[-1]
            twoThetaBinWidthValueSync = 1
            console.debug(`Updated 1D twoTheta slider data to bin_width=${twoThetaBinWidth1D}, and slider edges to (min=${minTwoThetaCenter1D}, max=${maxTwoThetaCenter1D})`)
        } else {
            minTwoThetaCenter = null
            maxTwoThetaCenter = null
            twoThetaBinWidthValueSync = null
            console.debug(`WARNING: Update 1D twoTheta slider data for bin width index ${twoThetaBinWidthIndx} is not implemented.`)
        }
        minTwoThetaCenter1D = minTwoThetaCenter
        maxTwoThetaCenter1D = maxTwoThetaCenter
        twoThetaBinWidth1D = twoThetaBinWidthValueSync
    }

    function updateGammaBinWidth1D(gammaBinWidthIndx) {
        console.debug(`QML backend for updateGammaBinWidth1D.`)
        gammaBinWidthIndexSync = gammaBinWidthIndx
        if (gammaBinWidthIndx === 0) {
            gammaBinWidthValueSync = 1.0
        } else if (gammaBinWidthIndx === 1) {
            gammaBinWidthValueSync = 2.0
        } else {
            gammaBinWidthValueSync = null
        }
        gammaBinWidth1D = gammaBinWidthValueSync
    }

    function generateLinePlot1D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx) {
        console.debug(`QML backend for generateLinePlot1D. Data will be loaded from ${Qt.resolvedUrl(filepath)} for ${sliderIndx}.`)
        runJavaScriptIsOff1D = false
        obj.getData1DFromJson(Qt.resolvedUrl(filepath), sliderIndx, function(uniqueTwoTheta, uniqueGamma, countsData) {
            let linePlotFullDataDict = {}
            linePlotFullDataDict['twoTheta'] = uniqueTwoTheta
            linePlotFullDataDict['gamma'] = uniqueGamma
            linePlotFullDataDict['counts'] = countsData
            obj.fullData = linePlotFullDataDict
            updateSliceData1D(obj, sliderIndx)

            runJavaScriptIsOff1D = true
            console.debug(`End of QML backend for generateLinePlot1D: slider index ${twoThetaSliderIndex1D} at ${twoThetaSliderValue1D}.`)
        })
    }

    function updateSliceData1D(obj, sliderIndex) {
        console.debug(`QML backend for updateSliceData1D.`)

        let linePlotDict = {}
        let sliceGamma = obj.fullData.gamma
        let sliceCounts = obj.fullData.counts[sliderIndex]
        let sliceTwoTheta = obj.fullData.twoTheta[sliderIndex]
        let sliceTwoThetaArray = Array(sliceGamma.length).fill(sliceTwoTheta)
        linePlotDict['x'] = sliceGamma
        linePlotDict['y'] = sliceCounts
        linePlotDict['customData'] = sliceTwoThetaArray
        linePlotDict['hoverTemplate'] = '2\u03b8: %{customdata}\u00B0<br>'+
                                        '\u03b3: %{x}\u00B0<br>'+
                                        'Counts: %{y}'
        obj.plotData = linePlotDict

        console.debug(`Updated 1D LinePlot plotData to slice index = ${sliderIndex}.`)
    }

    function updateLinePlotTwoThetaBinWidth1D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        console.debug(`QML backend for updateLinePlotTwoThetaBinWidth1D for two theta slider index ${twoThetaSliderIndex}.`)

        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        let filepath1D = '../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        generateLinePlot1D(obj, filepath1D, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)

        console.debug(`End of QML backend for updateLinePlotTwoThetaBinWidth1D. Loaded ${filepath1D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    function updateLinePlotGammaBinWidth1D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        console.debug(`QML backend for updateLinePlotGammaBinWidth1D.`)

        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        let filepath1D = '../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        generateLinePlot1D(obj, filepath1D, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)

        console.debug(`End of QML backend for updateLinePlotGammaBinWidth1D. Loaded ${filepath1D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    function getTwoThetaSliderIndex1D() {
        console.debug(`QML backend for getTwoThetaSliderIndex1D.`)
        let sliderIndex = (twoThetaSliderValue1D - minTwoThetaCenter1D) / twoThetaBinWidth1D
        twoThetaSliderIndexSync = sliderIndex
        return sliderIndex
    }

    function getBinningIndices(twoThetaBinWidth, gammaBinWidth) {
        console.debug(`getBinningIndices for twoThetaBinWidth=${twoThetaBinWidth} and gammaBinWidth=${gammaBinWidth}`)
        let twoThetaBinWidthIndex, gammaBinWidthIndex
        if (twoThetaBinWidth === 0.5) {
            twoThetaBinWidthIndex = 0
        } else if (twoThetaBinWidth === 1) {
            twoThetaBinWidthIndex = 1
        } else {
            twoThetaBinWidthIndex = 2
            console.debug(`WARNING in getBinningIndices: unimplemented twoThetaBinWidth ${twoThetaBinWidth}`)
        }
        if (gammaBinWidth === 1) {
            gammaBinWidthIndex = 0
        } else if (gammaBinWidth === 2) {
            gammaBinWidthIndex = 1
        } else {
            gammaBinWidthIndex = 2
            console.debug(`WARNING in getBinningIndices: unimplemented gammaBinWidth ${gammaBinWidth}`)
        }
        return [twoThetaBinWidthIndex, gammaBinWidthIndex]
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
