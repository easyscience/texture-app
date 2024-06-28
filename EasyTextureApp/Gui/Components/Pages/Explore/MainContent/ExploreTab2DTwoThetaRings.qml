// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyExampleApp>

import QtQuick

import EasyApp.Gui.Charts as EaCharts

import Gui.Charts as Charts
import Gui.Globals as Globals

Charts.Plotly2DTwoThetaRings {
    dataFile: qsTr(Globals.Proxies.main.explore.selectedExploreFile2D)
    sliderValue: Globals.Proxies.main.explore.twoThetaSliderValue
    //useWebGL: Globals.Proxies.main.plotting.useWebGL1d
}
