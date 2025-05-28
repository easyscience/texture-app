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
    property bool resetTwoThetaSlider: false

    property int gammaBinWidthIndex: 0
    property real gammaBinWidth: 1.0

    property string plotFilepath: '../../../../../../examples/Explore/user_voxels_2D_1.json'

    function generate2dPolarHeatmapPlot(twoThetaBinWidth, gammaBinWidth) {
        [twoThetaIndex, gammaIndex] = getBinningIndices(twoThetaBinWidth, gammaBinWidth)
        update2DPlotFilepath(twoThetaIndex, gammaIndex)
        console.debug(`QML backend for generate2dPolarHeatmapPlot. Load ${plotFilepath} for (twoThetaBinWidth, gammaBinWidth): (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }

    function update2DPlotFilepath(twoThetaBinWidthIndx, gammaBinWidthIndx) {
        let mockBinningIndex = 2 * twoThetaBinWidthIndx + gammaBinWidthIndx + 1
        plotFilepath = '../../../../../../examples/explore/user_voxels_2D_%1.json'.arg(mockBinningIndex)
        console.debug(`update2DPlotFilepath to ${plot2dFilepath}`)
    }

    function generate1dLinePlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`QML backend for generate1dLinePlot. Load ${plot1dFilepath} with (twoThetaBinWidth, gammaBinWidth): (${twoThetaBinWidth}, ${gammaBinWidth}).`)
    }
}
