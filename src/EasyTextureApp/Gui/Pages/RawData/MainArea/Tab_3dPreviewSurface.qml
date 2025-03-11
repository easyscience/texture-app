// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Charts as Charts
import Gui.Globals as Globals

EaCharts.Plotly3dSurface {
    id: surface3d
    url: Qt.resolvedUrl(Globals.BackendWrapper.rawDataPlot3dFilepath)

    xAxisTitle: "x, mm"
    yAxisTitle: "y, mm"
    zAxisTitle: "z, mm"
}
