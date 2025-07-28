// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {
    property bool loaded: false
    property int selectedTabIndex: 0
    property bool syncTabsBinnings: true
    property bool syncTabsSliders: true


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

    property real twoThetaSyncedSliderValue: 45.25
    property int syncedTwoThetaBinWidthIndex: 0
    property int syncedGammaBinWidthIndex: 0

    // Binning 3D
    property string plotFilepath3D: '../../../../../../examples/RawData/user_voxels_3D_1.json'

    property int twoThetaBinWidthIndex3D: 0
    property real minTwoThetaCenter3D: 45.25
    property real maxTwoThetaCenter3D: 134.75
    property real twoThetaBinWidth3D: 0.5
    property real twoThetaSliderValue3D: minTwoThetaCenter3D

    property int gammaBinWidthIndex3D: 0
    property real gammaBinWidth3D: 1.0

    function updateTwoThetaSliderData3D(twoThetaBinWidthIndx) {
        if (twoThetaBinWidthIndx === 0) {
            twoThetaBinWidth3D = 0.5
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter3D = 45.25 //centers[0]
            maxTwoThetaCenter3D = 134.75 //centers[-1]
            console.debug(`update3DTwoThetaSliderData to bin_width=${twoThetaBinWidth3D}, and slider edges to (min=${minTwoThetaCenter3D}, max=${maxTwoThetaCenter3D})`)
        } else if (twoThetaBinWidthIndx === 1) {
            twoThetaBinWidth3D = 1
            // centers, edges = bins_two_theta(min_two_theta, max_two_theta, bin_width, drop_incomplete=True)
            minTwoThetaCenter3D = 45.5 //centers[0]
            maxTwoThetaCenter3D = 134.5 //centers[-1]
            console.debug(`update3DTwoThetaSliderData to bin_width=${twoThetaBinWidth3D}, and slider edges to (min=${minTwoThetaCenter3D}, max=${maxTwoThetaCenter3D})`)
        } else {
            twoThetaBinWidth3D = null
            minTwoThetaCenter3D = null
            maxTwoThetaCenter3D = null
            console.debug(`WARNING: update3DTwoThetaSliderData for two theta bin width index ${twoThetaBinWidthIndx} is not implemented.`)
        }
        twoThetaSliderValue3D = minTwoThetaCenter3D
        console.debug(`twoThetaRingsSliderValue3D is changed to ${twoThetaSliderValue3D}`)
    }

    function updateTwoThetaBinWidth3D(twoThetaBinWidthIndx) {
        if (twoThetaBinWidthIndx === 0) {
            twoThetaBinWidth3D = 0.5
        } else if (twoThetaBinWidthIndx === 1) {
            twoThetaBinWidth3D = 1.0
        } else {
            twoThetaBinWidth3D = null
        }
    }

    function updateGammaBinWidth3D(gammaBinWidthIndx) {
        if (gammaBinWidthIndx === 0) {
            gammaBinWidth3D = 1.0
        } else if (gammaBinWidthIndx === 1) {
            gammaBinWidth3D = 2.0
        } else {
            gammaBinWidth3D = null
        }
    }

    function generateSurfacePlot3D(filepath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: QML backend for generateSurfacePlot3D. Loaded ${plotFilepath3D} by default.`)
    }

    function updateSurfacePlot3D(twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: QML backend for updateSurfacePlot3D.`)
        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        plotFilepath3D = '../../../../../../examples/RawData/user_voxels_3D_%1.json'.arg(mockBinningIndex)
        console.debug(`In ${this}: Loaded ${plotFilepath3D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }


    // Binning 2D
    property string plotFilepath2D: '../../../../../../examples/RawData/user_voxels_2D_1.json'

    property int twoThetaBinWidthIndex2D: 0
    property real minTwoThetaCenter2D: 45.25
    property real maxTwoThetaCenter2D: 134.75
    property real twoThetaBinWidth2D: 0.5
    property real twoThetaSliderValue2D: minTwoThetaCenter2D

    property int gammaBinWidthIndex2D: 0
    property real gammaBinWidth2D: 1.0

    function updateTwoThetaSliderData2D(twoThetaBinWidthIndx) {
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
            twoThetaBinWidth2D = null
            minTwoThetaCenter2D = null
            maxTwoThetaCenter2D = null
            console.debug(`WARNING: update2DTwoThetaSliderData for two theta bin width index ${twoThetaBinWidthIndx} is not implemented.`)
        }
        twoThetaSliderValue2D = minTwoThetaCenter2D
        console.debug(`twoThetaSliderValue2D is changed to ${twoThetaSliderValue2D}`)
    }

    function updateGammaBinWidth2D(gammaBinWidthIndx) {
        if (gammaBinWidthIndx === 0) {
            gammaBinWidth2D = 1.0
        } else if (gammaBinWidthIndx === 1) {
            gammaBinWidth2D = 2.0
        } else {
            gammaBinWidth2D = null
        }
    }

    function generateHeatmapPlot2D(filepath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: QML backend for generateHeatmapPlot2D. Loaded ${plotFilepath2D} by default.`)
    }

    function updateHeatmapPlot2D(twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: QML backend for updateHeatmapPlot2D.`)
        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        plotFilepath2D = '../../../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        console.debug(`In ${this}: Loaded ${plotFilepath2D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    function generatePolarHeatmapPlot2D(filepath, twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        console.debug(`In ${this}: QML backend for generatePolarHeatmapPlot2D. Loaded ${plotFilepath2D} by default.`)
    }

    function updatePolarHeatmapPlot2D(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        console.debug(`In ${this}: QML backend for updatePolarHeatmapPlot2D.`)
        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        plotFilepath2D = '../../../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        console.debug(`In ${this}: Loaded ${plotFilepath2D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }


    // Binning 1D
    property string plotFilepath1D: '../../../../../../examples/RawData/user_voxels_2D_1.json'

    property int twoThetaBinWidthIndex1D: 0
    property real minTwoThetaCenter1D: 45.25
    property real maxTwoThetaCenter1D: 134.75
    property real twoThetaBinWidth1D: 0.5
    property real twoThetaSliderValue1D: minTwoThetaCenter1D

    property int gammaBinWidthIndex1D: 0
    property real gammaBinWidth1D: 1.0

    function updateTwoThetaSliderData1D(twoThetaBinWidthIndx) {
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
            twoThetaBinWidth1D = null
            minTwoThetaCenter1D = null
            maxTwoThetaCenter1D = null
            console.debug(`WARNING: update1DTwoThetaSliderData for two theta bin width index ${twoThetaBinWidthIndx} is not implemented.`)
        }
        twoThetaSliderValue1D = minTwoThetaCenter1D
        console.debug(`twoThetaSliderValue1D is changed to ${twoThetaSliderValue1D}`)
    }

    function updateGammaBinWidth1D(gammaBinWidthIndx) {
        if (gammaBinWidthIndx === 0) {
            gammaBinWidth1D = 1.0
        } else if (gammaBinWidthIndx === 1) {
            gammaBinWidth1D = 2.0
        } else {
            gammaBinWidth1D = null
        }
    }

    function generateLinePlot1D(filepath, twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        console.debug(`In ${this}: QML backend for generateLinePlot1D. Loaded ${plotFilepath1D} by default.`)
    }

    function updateLinePlot1D(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        console.debug(`In ${this}: QML backend for updateLinePlot1D.`)
        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        let mockBinningIndex = 2 * twoThetaIndex + gammaIndex + 1
        plotFilepath1D = '../../../../../../examples/RawData/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        console.debug(`In ${this}: Loaded ${plotFilepath1D} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    function getBinningIndices(twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: getBinningIndices for twoThetaBinWidth=${twoThetaBinWidth} and gammaBinWidth=${gammaBinWidth}`)
        let twoThetaBinWidthIndex, gammaBinWidthIndex
        if (twoThetaBinWidth === 0.5) {
            twoThetaBinWidthIndex = 0
        } else if (twoThetaBinWidth === 1) {
            twoThetaBinWidthIndex = 1
        } else {
            twoThetaBinWidthIndex = 2
            console.debug(`In ${this}: WARNING in getBinningIndices: unimplemented twoThetaBinWidth ${twoThetaBinWidth}`)
        }
        if (gammaBinWidth === 1) {
            gammaBinWidthIndex = 0
        } else if (gammaBinWidth === 2) {
            gammaBinWidthIndex = 1
        } else {
            gammaBinWidthIndex = 2
            console.debug(`In ${this}: WARNING in getBinningIndices: unimplemented gammaBinWidth ${gammaBinWidth}`)
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
