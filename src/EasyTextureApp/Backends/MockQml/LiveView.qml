// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {

    property bool connected: false
    property int selectedTabIndex: 0

    // Binning 3D
    property string plotFilepath3D: '../../../../../../examples/LiveView/user_voxels_live_3D_1.json'

    property int twoThetaBinWidthIndex3D: 0
    property real twoThetaBinWidth3D: 0.5

    property int gammaBinWidthIndex3D: 0
    property real gammaBinWidth3D: 1.0

    property var indexList: [2, 3, 1]
    property int currentIndex: 0

    function updatePlotFilepath3D() {
        console.debug(`In ${this}: updatePlotFilepath3D()`)
        var mockIndex = indexList[currentIndex]
        plotFilepath3D = '../../../../../../examples/LiveView/user_voxels_live_3D_%1.json'.arg(mockIndex)
        currentIndex = (currentIndex + 1) % indexList.length;
    }

    // Binning 2D
    property string plotFilepath2D: '../../../../../../examples/LiveView/user_voxels_live_2D_1.json'

    property int twoThetaBinWidthIndex2D: 0
    property real minTwoThetaCenter2D: 45.25
    property real maxTwoThetaCenter2D: 134.75
    property real twoThetaBinWidth2D: 0.5
    property real twoThetaRingsSliderValue2D: minTwoThetaCenter2D

    property int gammaBinWidthIndex2D: 0
    property real gammaBinWidth2D: 1.0

    function updatePlotFilepath2D() {
        console.debug(`In ${this}: updatePlotFilepath2D()`)
        var mockIndex = indexList[currentIndex]
        plotFilepath2D = '../../../../../../examples/LiveView/user_voxels_live_2D_%1.json'.arg(mockIndex)
        currentIndex = (currentIndex + 1) % indexList.length;
    }

}
