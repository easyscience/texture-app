// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {
    property bool created: true

    property string dPatternPlotFilepath: '../../../../../../examples/Results/barplot_d_patters_1.json'

    readonly property int minSliderValue: 1
    property int maxSliderValue: 270
    property int ringIndexSliderValue: 1

    function generateBarPlot(dSpacingBinWidth, gammaBinWidth, currentGammaSliceIndx) {
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
            console.debug(`WARNING in ${this}: unsupported value of gammaBinWidth in generateBarPlot`)
        }
        console.debug(`In ${this}: QML backend for generateBarPlot using ${dPatternPlotFilepath}`)
    }
}
