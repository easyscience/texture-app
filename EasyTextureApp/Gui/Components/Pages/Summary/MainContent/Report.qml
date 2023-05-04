// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.BasicReport {

    xAxisTitle: "x"
    yAxisTitle: "y"

    measuredXYData: Globals.Proxies.main.summary.isCreated ?
                        {'x': Globals.Proxies.main.rawData.xData, 'y': Globals.Proxies.main.rawData.yData} :
                        {}
    calculatedXYData: Globals.Proxies.main.summary.isCreated ?
                          {'x': Globals.Proxies.main.rawData.xData, 'y': Globals.Proxies.main.model.yData} :
                          {}

    Component.onCompleted: Globals.Refs.summaryReportWebEngine = this

}

