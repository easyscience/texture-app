// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

pragma Singleton

import QtQuick 2.15

QtObject {
    // Debug mode
    property bool isDebugMode: typeof _pyQmlProxyObj === "undefined"

    // Initial application pages accessibility
    property bool homePageEnabled: isDebugMode ? true : true
    property bool projectPageEnabled: isDebugMode ? true : false
    property bool step1PageEnabled: isDebugMode ? true : false
    property bool step2PageEnabled: isDebugMode ? true : false
    property bool step3PageEnabled: isDebugMode ? true : false
    property bool summaryPageEnabled: isDebugMode ? true : false

    // //////////////////////////
    // References to GUI elements
    // //////////////////////////

    // Application bar
    property var appBarCentralTabs

    // Application bar tab buttons
    property var homeTabButton
    property var projectTabButton
    property var step1TabButton
    property var step2TabButton
    property var step3TabButton
    property var summaryTabButton

    // Charts
    property var chartViewSimple1dPlotly
}
