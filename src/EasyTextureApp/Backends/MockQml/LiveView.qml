// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {

    property bool connected: false
    property int selectedTabIndex: 0

    // Binning 3D
    property string plotFilepath3D: '../../../../../../examples/LiveView/user_voxels_3D_1.json'

    property int twoThetaBinWidthIndex3D: 0
    property real twoThetaBinWidth3D: 0.5

    property int gammaBinWidthIndex3D: 0
    property real gammaBinWidth3D: 1.0

    // Binning 2D
    property string plotFilepath2D: '../../../../../../examples/LiveView/user_voxels_2D_1.json'

    property int twoThetaBinWidthIndex2D: 0
    property real minTwoThetaCenter2D: 45.25
    property real maxTwoThetaCenter2D: 134.75
    property real twoThetaBinWidth2D: 0.5
    property real twoThetaRingsSliderValue2D: minTwoThetaCenter2D

    property int gammaBinWidthIndex2D: 0
    property real gammaBinWidth2D: 1.0

    /*property bool activated: false

    property int twoThetaBinWidthIndex: 0
    property real minTwoThetaCenter: 45.25
    property real maxTwoThetaCenter: 134.75
    property real twoThetaBinWidth: 0.5
    property real twoThetaSliderValue: minTwoThetaCenter

    property int gammaBinWidthIndex: 0
    property real gammaBinWidth: 1.0

    property string plotFilepath: '../../../../../../examples/Explore/user_voxels_2D_1.json'

    function generate2dPolarHeatmapPlot(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        console.debug(`In ${this}: QML backend for generate2dPolarHeatmapPlot.`)
        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        updatePlotFilepath(twoThetaIndex, gammaIndex)
        console.debug(`In ${this}: Loaded ${plotFilepath} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    function getBinningIndices(twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: getBinningIndices for twoThetaBinWidth=${twoThetaBinWidth} and gammaBinWidth=${gammaBinWidth}`)
        let twoThetaBinWidthIndex, gammaBinWidthIndex
        if (twoThetaBinWidth === 0.5) {
            twoThetaBinWidthIndex = 0
        } else if (twoThetaBinWidth === 1){
            twoThetaBinWidthIndex = 1
        } else {
            twoThetaBinWidthIndex = 2
            console.debug(`In ${this}: WARNING in getBinningIndices: unimplemented twoThetaBinWidth ${twoThetaBinWidth}`)
        }
        if (gammaBinWidth === 1) {
            gammaBinWidthIndex = 0
        } else if (gammaBinWidth === 2){
            gammaBinWidthIndex = 1
        } else {
            gammaBinWidthIndex = 2
            console.debug(`In ${this}: WARNING in getBinningIndices: unimplemented gammaBinWidth ${gammaBinWidth}`)
        }
        return [twoThetaBinWidthIndex, gammaBinWidthIndex]
    }

    function updatePlotFilepath(twoThetaBinWidthIndx, gammaBinWidthIndx) {
        let mockBinningIndex = 2 * twoThetaBinWidthIndx + gammaBinWidthIndx + 1
        plotFilepath = '../../../../../../examples/Explore/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        console.debug(`In ${this}: updatePlotFilepath to ${plotFilepath}`)
    }

    function generate1dLinePlot(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        console.debug(`In ${this}: QML backend for generate1dLinePlot.`)
        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        updatePlotFilepath(twoThetaIndex, gammaIndex)
        console.debug(`In ${this}: Loaded ${plotFilepath} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    // stats related
    property int totalCountsMin: 0
    property int totalCountsMax: 0
    property int totalCountsSum: 0

    property int ringCountsMin: 0
    property int ringCountsMax: 0
    property int ringCountsSum: 0
    property real ringMaxIntensityWidth: 0

    function setTotalStatistics(twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: QML backend for setTotalStatistics using ${plotFilepath}`)
    }

    function setRingStatistics(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        console.debug(`In ${this}: QML backend for setRingStatistics using ${plotFilepath}`)
    }*/
}
