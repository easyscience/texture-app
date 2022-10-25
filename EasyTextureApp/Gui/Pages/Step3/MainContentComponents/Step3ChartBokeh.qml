// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15

import easyApp.Gui.Charts 1.0 as EaCharts

import Gui.Globals 1.0 as ExGlobals

EaCharts.BaseBokeh {
    measuredData: ExGlobals.Constants.proxy.plotting1d.bokehMeasuredDataObj

    plotRanges: ExGlobals.Constants.proxy.plotting1d.experimentPlotRangesObj

    xAxisTitle: "2θ (deg)"
    yMainAxisTitle: "Imeas"
}
