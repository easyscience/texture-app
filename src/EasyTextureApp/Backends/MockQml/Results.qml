// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {
    property bool created: true

    property string dPatternPlotFilepath: '../../../../../../examples/Results/barplot_d_patters_1.json'

    readonly property int minSliderValue: 1
    property int ringIndexSliderValue: 1
}
