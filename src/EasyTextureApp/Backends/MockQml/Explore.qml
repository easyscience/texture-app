// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {

    property bool created: true

    property int twoThetaBinWidthIndex: 0
    property real minTwoThetaCenter: 45.25
    property real maxTwoThetaCenter: 134.75
    property real twoThetaBinWidth: 0.5
    property real twoThetaSliderValue: minTwoThetaCenter

    property int gammaBinWidthIndex: 0
    property real gammaBinWidth: 1.0

    property string plotFilepath: '../../../../../../examples/Explore/user_voxels_2D_1.json'

    function generate2dPolarHeatmapPlot(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        updatePlotFilepath(twoThetaIndex, gammaIndex)
        console.debug(`In ${this}: QML backend for generate2dPolarHeatmapPlot. Load ${plotFilepath} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)
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
        let twoThetaIndex, gammaIndex
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        updatePlotFilepath(twoThetaIndex, gammaIndex)
        console.debug(`In ${this}: QML backend for generate1dLinePlot. Load ${plotFilepath} for (twoThetaBinWidth, gammaBinWidth) = (${twoThetaBinWidth}, ${gammaBinWidth}).`)

    }
}
