// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Charts as Charts
import Gui.Globals as Globals

Charts.Plotly2DPolarHeatmap {
    //useWebGL: Globals.Proxies.main.plotting.useWebGL1d
    url:  Qt.resolvedUrl('../../../../Html/LiveDataView/Plotly2dPolarHeatmapLive.html')
    sliderValue: Globals.Proxies.main.liveView.twoThetaSliderValue

    xAxisTitle: "x, mm"
    yAxisTitle: "y, mm"
}
