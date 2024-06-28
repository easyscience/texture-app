// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15

import EasyApp.Gui.Charts as EaCharts

import Gui.Globals as Globals
import Gui.Charts as Charts

Charts.Plotly1D {
    //dataFile: qsTr(Globals.Proxies.main.rawData.selectedRawFile)
    dataFile: qsTr(Globals.Proxies.main.rawData.selectedRawFile1D)
    sliderValue: Globals.Proxies.main.rawData.twoThetaSliderValue
    //useWebGL: Globals.Proxies.main.plotting.useWebGL1d

    //xAxisTitle: "\u03b3, deg"
    //yAxisTitle: "Counts"

    //xData: Globals.Proxies.main.rawData.xData
    //measuredYData: Globals.Proxies.main.rawData.yData

    Component.onCompleted: print('COMPL yvalue', yAxisTitle)//Globals.Refs.app.rawDataPage.plotView = this
}

