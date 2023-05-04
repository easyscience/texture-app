// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaElements.RemoteController {
    id: rc

    property var res: []

    Timer {
        running: true
        interval: 1000
        onTriggered: {
            runBasicGuiTest()
            processTestResults()
        }
    }

    // Tests

    function processTestResults() {
        let success = 0
        let okTests = 0
        let failedTests = 0

        print("============================ GUI TEST REPORT START =============================")

        for (let i in res) {
            if (res[i].startsWith('FAIL')) {
                success = -1
                failedTests += 1
                print(res[i])
            } else {
                okTests +=1
            }
        }

        print("--------------------------------------------------------------------------------")
        print(`${res.length} total, ${res.length - failedTests} passed, ${failedTests} failed`)
        print("============================= GUI TEST REPORT END ==============================")

        print("Closing app after test mode.")
        Qt.exit(success)
    }

    function saveImage(dirName, fileName) {
        saveScreenshot(parent, `${dirName}/${fileName}`)
    }

    function runBasicGuiTest() {
        // Set up testing process

        print('Run basic suit of GUI tests')

        //const saveImagesDir = '../.tests/GuiTests/BasicGuiTest/ActualImages'

        rc.posToCenter()
        rc.showPointer()

        // Home Page

        //saveImage(saveImagesDir, 'HomePage.png')

        res.push( rc.compare(Globals.Refs.app.appbar.homeButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.projectButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.appbar.rawDataButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.appbar.correctionsButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.appbar.exploreButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.appbar.summaryButton.enabled, false) )

        res.push( rc.compare(Globals.Refs.app.homePage.startButton.text, 'Start') )
        res.push( rc.compare(Globals.Refs.app.homePage.startButton.enabled, true) )

        rc.mouseClick(Globals.Refs.app.homePage.startButton)
        //rc.wait(2000)

        // Project Page

        //saveImage(saveImagesDir, 'ProjectPage.png')

        res.push( rc.compare(Globals.Refs.app.appbar.homeButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.projectButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.rawDataButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.appbar.correctionsButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.appbar.exploreButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.appbar.summaryButton.enabled, false) )

        res.push( rc.compare(Globals.Refs.app.projectPage.continueButton.text, 'Continue without project') )
        res.push( rc.compare(Globals.Refs.app.projectPage.continueButton.enabled, true) )

        rc.mouseClick(Globals.Refs.app.projectPage.continueButton)
        //rc.wait(2000)

        // RawData page

        //saveImage(saveImagesDir, 'RawDataPage.png')

        res.push( rc.compare(Globals.Refs.app.appbar.homeButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.projectButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.rawDataButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.correctionsButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.appbar.exploreButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.appbar.summaryButton.enabled, false) )

        res.push( rc.compare(Globals.Refs.app.rawDataPage.importDataFromLocalDriveButton.text, 'Import data from local drive') )
        res.push( rc.compare(Globals.Refs.app.rawDataPage.importDataFromLocalDriveButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.rawDataPage.continueButton.text, 'Continue without experiment data') )
        res.push( rc.compare(Globals.Refs.app.rawDataPage.continueButton.enabled, true) )

        rc.mouseClick(Globals.Refs.app.rawDataPage.importDataFromLocalDriveButton)
        rc.wait(2000)

        res.push( rc.compare(Globals.Refs.app.rawDataPage.importDataFromLocalDriveButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.rawDataPage.continueButton.text, 'Continue') )

        res.push( rc.compare(Globals.Refs.app.rawDataPage.plotView.xData, Globals.Tests.expected.created.rawData.xData) )
        res.push( rc.compare(Globals.Refs.app.rawDataPage.plotView.measuredYData, Globals.Tests.expected.created.rawData.yData) )

        rc.mouseClick(Globals.Refs.app.rawDataPage.continueButton)
        //rc.wait(2000)

        // Corrections Page

        //saveImage(saveImagesDir, 'CorrectionsPage.png')

        res.push( rc.compare(Globals.Refs.app.appbar.homeButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.projectButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.rawDataButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.correctionsButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.exploreButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.appbar.summaryButton.enabled, false) )

        res.push( rc.compare(Globals.Refs.app.correctionsPage.addNewModelManuallyButton.text, 'Add new model manually') )
        res.push( rc.compare(Globals.Refs.app.correctionsPage.addNewModelManuallyButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.correctionsPage.continueButton.text, 'Continue') )
        res.push( rc.compare(Globals.Refs.app.correctionsPage.continueButton.enabled, false) )

        rc.mouseClick(Globals.Refs.app.correctionsPage.addNewModelManuallyButton)
        rc.wait(2000)

        res.push( rc.compare(Globals.Refs.app.correctionsPage.addNewModelManuallyButton.enabled, false) )
        res.push( rc.compare(Globals.Refs.app.correctionsPage.continueButton.enabled, true) )

        res.push( rc.compare(Globals.Refs.app.correctionsPage.plotView.xData, Globals.Tests.expected.created.rawData.xData) )
        res.push( rc.compare(Globals.Refs.app.correctionsPage.plotView.calculatedYData, Globals.Tests.expected.created.corrections.yData) )

        rc.mouseClick(Globals.Refs.app.correctionsPage.continueButton)
        //rc.wait(2000)

        // Explore page

        //saveImage(saveImagesDir, 'ExplorePage.png')

        res.push( rc.compare(Globals.Refs.app.appbar.homeButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.projectButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.rawDataButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.correctionsButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.exploreButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.appbar.summaryButton.enabled, false) )

        res.push( rc.compare(Globals.Refs.app.explorePage.startFittingButton.text, 'Start fitting') )
        res.push( rc.compare(Globals.Refs.app.explorePage.startFittingButton.enabled, true) )
        res.push( rc.compare(Globals.Refs.app.explorePage.continueButton.text, 'Continue') )
        res.push( rc.compare(Globals.Refs.app.explorePage.continueButton.enabled, true) )

        rc.wait(2000)

        res.push( rc.compare(Globals.Refs.app.explorePage.plotView.xData, Globals.Tests.expected.created.rawData.xData) )
        res.push( rc.compare(Globals.Refs.app.explorePage.plotView.measuredYData, Globals.Tests.expected.created.rawData.yData) )
        res.push( rc.compare(Globals.Refs.app.explorePage.plotView.calculatedYData, Globals.Tests.expected.created.corrections.yData) )

        rc.mouseClick(Globals.Refs.app.explorePage.startFittingButton)
        rc.wait(2000)

        res.push( rc.compare(Globals.Refs.app.explorePage.plotView.xData, Globals.Tests.expected.created.rawData.xData) )
        res.push( rc.compare(Globals.Refs.app.explorePage.plotView.measuredYData, Globals.Tests.expected.created.rawData.yData) )
        res.push( rc.compare(Globals.Refs.app.explorePage.plotView.calculatedYData, Globals.Tests.expected.fitted.corrections.yData) )

        rc.mouseClick(Globals.Refs.app.explorePage.continueButton)
        //rc.wait(2000)

        // Summary page

        //saveImage(saveImagesDir, 'SummaryPage.png')

        // Complete testing process

        rc.mouseClick(Globals.Refs.app.appbar.resetStateButton)
        //rc.wait(2000)

        rc.hidePointer()
    }

}
