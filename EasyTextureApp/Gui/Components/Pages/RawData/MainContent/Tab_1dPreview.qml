// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals


EaCharts.Plotly1dMeasVsCalc {

    useWebGL: Globals.Proxies.main.plotting.useWebGL1d

    xAxisTitle: "x"
    yAxisTitle: "y"

    xData: Globals.Proxies.main.rawData.xData
    measuredYData: Globals.Proxies.main.rawData.yData

    Component.onCompleted: Globals.Refs.app.rawDataPage.plotView = this

}
