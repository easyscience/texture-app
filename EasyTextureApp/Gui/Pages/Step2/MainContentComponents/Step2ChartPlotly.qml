// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebEngine 1.10

import easyApp.Gui.Elements 1.0 as EaElements

import Gui.Globals 1.0 as ExGlobals

Rectangle {

    WebEngineView {
        id: chartView

        anchors.fill: parent
        anchors.bottomMargin: 20
        anchors.topMargin: 18
        anchors.leftMargin: 15
        anchors.rightMargin: 15

        backgroundColor: parent.color

        url: 'ChartPlotly1.html'

        onWidthChanged: reload()
        onHeightChanged: reload()

        Component.onCompleted: ExGlobals.Variables.plotlyChart = this
    }
}
