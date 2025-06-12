// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {
    property bool created: true

    property string dPatternPlotFilepath: '../../../../../../examples/Results/barplot_d_patters_1.json'
    property string twoThetaPlotFilepath: '../../../../../../examples/Results/barplot_two_theta_patters_1.json'


    readonly property int minSliderValue: 1
    property int maxSliderValue: 270
    property int ringIndexSliderValue: 1

    function generateDSpacingBarPlot(dSpacingBinWidth, gammaBinWidth, currentGammaSliceIndx) {
        if (gammaBinWidth === 1) {
            dPatternPlotFilepath = '../../../../../../examples/Results/barplot_d_patters_1.json'
            // should in general depend on whether dropIncomplete is true or false
            maxSliderValue = 270
        } else if (gammaBinWidth === 2) {
            dPatternPlotFilepath = '../../../../../../examples/Results/barplot_d_patters_2.json'
            maxSliderValue = 134
        } else {
            dPatternPlotFilepath = ''
            resultsMaxSliderValue = 1
            console.debug(`WARNING in ${this}: unsupported value of gammaBinWidth in generateDSpacingBarPlot`)
        }
        console.debug(`In ${this}: QML backend for generateDSpacingBarPlot using ${dPatternPlotFilepath}`)
    }

    function generateTwoThetaBarPlot(twoThetaBinWidth, gammaBinWidth, currentGammaSliceIndx) {
        if (gammaBinWidth === 1) {
            twoThetaPlotFilepath = '../../../../../../examples/Results/barplot_two_theta_patters_1.json'
            // should in general depend on whether dropIncomplete is true or false
        } else if (gammaBinWidth === 2) {
            twoThetaPlotFilepath = '../../../../../../examples/Results/barplot_two_theta_patters_2.json'
        } else {
            twoThetaPlotFilepath = ''
            console.debug(`WARNING in ${this}: unsupported value of gammaBinWidth in generateTwoThetaBarPlot`)
        }
        console.debug(`In ${this}: QML backend for generateTwoThetaBarPlot using ${twoThetaPlotFilepath}`)
    }

    function generateIntegratedTwoThetaBarPlot(twoThetaBinWidth, gammaBinWidth) {
        console.debug(`In ${this}: QML backend for generateIntegratedTwoThetaBarPlot using ${twoThetaPlotFilepath}`)
    }
}
