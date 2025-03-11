// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals
import Gui.Charts as Charts

EaCharts.Plotly1dLine {
    id: line1d
    url: Qt.resolvedUrl(Globals.BackendWrapper.rawDataPlot1dFilepath)

    xAxisTitle: "\u03b3, deg"
    yAxisTitle: "Counts"
}

