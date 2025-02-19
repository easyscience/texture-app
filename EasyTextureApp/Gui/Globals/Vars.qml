// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

pragma Singleton

import QtQuick


QtObject { // If "Unknown component. (M300) in QtCreator", try: "Tools > QML/JS > Reset Code Model"

    // Non-standard modes
    property bool isDebugMode: false
    property bool isTestMode: typeof pyIsTestMode !== 'undefined' ?
                                  pyIsTestMode:
                                  false

    // Initial application pages accessibility
    property bool homePageEnabled: isDebugMode ? true : true
    property bool projectPageEnabled: isDebugMode ? true : false
    property bool correctionsPageEnabled: isDebugMode ? true : false
    property bool rawDataPageEnabled: isDebugMode ? true : false
    property bool explorePageEnabled: isDebugMode ? true : false
    property bool resultsPageEnabled: isDebugMode ? true : false
    property bool liveViewPageEnabled: isDebugMode ? true : false

    // Misc
    property bool splashScreenAnimoFinished: isDebugMode ? true : false
    property bool applicationWindowCreated: false
    property bool homePageCreated: false

}
