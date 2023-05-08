// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

pragma Singleton

import QtQuick


QtObject { // If "Unknown component. (M300) in QtCreator", try: "Tools > QML/JS > Reset Code Model"

    // Main
    readonly property var app: {
        'appbar': {
            'resetStateButton': null,
            'homeButton': null,
            'projectButton': null,
            'correctionsButton': null,
            'rawDataButton': null,
            'exploreButton': null,
            'resultsButton': null,
            'liveViewButton': null
        },
        'homePage': {
            'startButton': null,
            'startButton2': null
        },
        'projectPage': {
            'continueButton': null
        },
        'rawDataPage': {
            'continueButton': null,
            'importDataFromLocalDriveButton': null,
            'plotView': null
        },
        'correctionsPage': {
            'continueButton': null,
            'addNewModelManuallyButton': null,
            'plotView': null
        },
        'explorePage': {
            'continueButton': null,
            'startFittingButton': null,
            'plotView': null
        },
        'resultsPage': {
        },
        'liveViewPage': {
        },
    }

    // Misc
    property var resultsReportWebEngine
    property var remoteController

}
