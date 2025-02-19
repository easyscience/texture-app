// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Charts as Charts
import Gui.Globals as Globals

Charts.Plotly2DGammaTwoTheta {
    //dataFile: qsTr(Globals.Proxies.main.rawData.selectedRawFile)
    dataFile: qsTr(Globals.Proxies.main.rawData.selectedRawFile2D)

    //xAxisTitle: "2\u03b8, deg"
    //yAxisTitle: "\u03b3, deg"
}
