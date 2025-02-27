// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15

import Gui.Globals as Globals
import Gui.Charts as Charts

Charts.Plotly1DBarPlot {
    dataFile: qsTr(Globals.Proxies.main.results.selectedResultsFile)
    sliderValue: Globals.Proxies.main.results.sliderValue
    //useWebGL: Globals.Proxies.main.plotting.useWebGL1d

    //xAxisTitle: "d, Å"
    //yAxisTitle: "Counts"

    //xData: Globals.Proxies.main.rawData.xData
    //measuredYData: Globals.Proxies.main.rawData.yData

    //Component.onCompleted: Globals.Proxies.main.results.sliderMaxValue = numberOfSlices
}
