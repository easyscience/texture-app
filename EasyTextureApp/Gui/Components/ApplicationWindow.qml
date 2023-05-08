// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Animations as EaAnimations
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals
import Gui.Components as Components


EaComponents.ApplicationWindow {

    appName: Globals.Configs.appConfig.name
    appVersion: Globals.Configs.appConfig.version
    appDate: Globals.Configs.appConfig.date

    //opacity: Globals.Vars.splashScreenAnimoFinished ? 1 : 0
    //Behavior on opacity { EaAnimations.ThemeChange {} }

    onClosing: Qt.quit()

    Component.onCompleted: {
        print("Application window loaded:", this)
        Globals.Vars.applicationWindowCreated = true
    }
    Component.onDestruction: print("Application window destroyed:", this)

    ///////////////////
    // APPLICATION BAR
    ///////////////////

    // Left group of application bar tool buttons
    appBarLeftButtons: [

        EaElements.ToolButton {
            enabled: Globals.Proxies.main.project.isCreated &&
                    Globals.Proxies.main.project.needSave
            highlighted: true
            fontIcon: "save"
            ToolTip.text: qsTr("Save current state of the project")
            onClicked: Globals.Proxies.main.project.save()
        },

        EaElements.ToolButton {
            enabled: false
            fontIcon: "undo"
        },

        EaElements.ToolButton {
            enabled: false
            fontIcon: "redo"
        },

        EaElements.ToolButton {
            enabled: Globals.Vars.homePageEnabled
            fontIcon: "backspace"
            ToolTip.text: qsTr("Reset to initial state without project, model and data")
            onClicked: {
                appBarCentralTabs.setCurrentIndex(0)
                Globals.Vars.projectPageEnabled = false
                Globals.Vars.correctionsPageEnabled = false
                Globals.Vars.rawDataPageEnabled = false
                Globals.Vars.explorePageEnabled = false
                Globals.Vars.resultsPageEnabled = false
                Globals.Vars.liveViewPageEnabled = false
            }
            Component.onCompleted: Globals.Refs.app.appbar.resetStateButton = this
        }

    ]

    // Right group of application bar tool buttons
    appBarRightButtons: [

        EaElements.ToolButton {
            fontIcon: "cog"
            ToolTip.text: qsTr("Application preferences")
            onClicked: EaGlobals.Variables.showAppPreferencesDialog = true
        },

        EaElements.ToolButton {
            fontIcon: "question-circle"
            ToolTip.text: qsTr("Get online help")
            onClicked: Qt.openUrlExternally(Globals.Configs.appConfig.homePageUrl)
        },

        EaElements.ToolButton {
            fontIcon: "bug"
            ToolTip.text: qsTr("Report a bug or issue")
            onClicked: Qt.openUrlExternally(Globals.Configs.appConfig.issuesUrl)
        }

    ]

    // Central group of application bar tab buttons (workflow tabs)
    // Tab buttons for the pages described below
    appBarCentralTabs.contentData: [

        // Home tab
        EaElements.AppBarTabButton {
            enabled: Globals.Vars.homePageEnabled
            fontIcon: "home"
            text: qsTr("Home")
            ToolTip.text: qsTr("Home page")
            Component.onCompleted: {
                homePageLoader.source = 'Pages/Home/Page.qml'
                Globals.Refs.app.appbar.homeButton = this
            }
        },

        // Project tab
        EaElements.AppBarTabButton {
            enabled: Globals.Vars.projectPageEnabled
            fontIcon: "archive"
            text: qsTr("Project")
            ToolTip.text: qsTr("Project description page")
            onEnabledChanged: enabled ?
                                  projectPageLoader.source = 'Pages/Project/PageStructure.qml' :
                                  projectPageLoader.source = ''
            Component.onCompleted: Globals.Refs.app.appbar.projectButton = this
        },

        // RawData tab
        EaElements.AppBarTabButton {
            enabled: Globals.Vars.rawDataPageEnabled
            fontIcon: "database"
            text: qsTr("Raw Data")
            ToolTip.text: qsTr("Raw Data page")
            onEnabledChanged: enabled ?
                                  rawDataPageLoader.source = 'Pages/RawData/PageStructure.qml' :
                                  rawDataPageLoader.source = ''
            Component.onCompleted: Globals.Refs.app.appbar.rawDataButton = this
        },

        // Corrections tab
        EaElements.AppBarTabButton {
            enabled: Globals.Vars.correctionsPageEnabled
            fontIcon: "hammer"
            text: qsTr("Corrections")
            ToolTip.text: qsTr("Corrections page")
            onEnabledChanged: enabled ?
                                  correctionsPageLoader.source = 'Pages/Corrections/PageStructure.qml' :
                                  correctionsPageLoader.source = ''
            Component.onCompleted: Globals.Refs.app.appbar.correctionsButton = this
        },

        // Explore tab
        EaElements.AppBarTabButton {
            enabled: Globals.Vars.explorePageEnabled
            fontIcon: "microscope"
            text: qsTr("Explore")
            ToolTip.text: qsTr("Explore page")
            onEnabledChanged: enabled ?
                                  explorePageLoader.source = 'Pages/Explore/PageStructure.qml' :
                                  explorePageLoader.source = ''
            Component.onCompleted: Globals.Refs.app.appbar.exploreButton = this
        },

        // Results tab
        EaElements.AppBarTabButton {
            enabled: Globals.Vars.resultsPageEnabled
            fontIcon: "calculator"
            text: qsTr("Results")
            ToolTip.text: qsTr("Results page")
            onEnabledChanged: enabled ?
                                  resultsPageLoader.source = 'Pages/Results/PageStructure.qml' :
                                  resultsPageLoader.source = ''
            onCheckedChanged: checked ?
                                  Globals.Proxies.main.results.isCreated = true :
                                  Globals.Proxies.main.results.isCreated = false
            Component.onCompleted: Globals.Refs.app.appbar.resultsButton = this
        },


        // Separator tab (separates previous TextureApp tabs from following LiveView tab)
        EaElements.AppBarTabButton {
            enabled: false
            text: "         "
        },


        // Live View tab
        EaElements.AppBarTabButton {
            enabled: Globals.Vars.liveViewPageEnabled
            fontIcon: "satellite-dish"
            //fontIcon: "signal"
            text: qsTr("Live View")
            ToolTip.text: qsTr("Live View page")
            onEnabledChanged: enabled ?
                                  liveViewPageLoader.source = 'Pages/LiveView/PageStructure.qml' :
                                  liveViewPageLoader.source = ''
            Component.onCompleted: Globals.Refs.app.appbar.liveViewButton = this
        }

    ]

    //////////////////////
    // MAIN VIEW + SIDEBAR
    //////////////////////

    // Pages for the tab buttons described above
    contentArea: [
        Loader { id: homePageLoader },
        Loader { id: projectPageLoader },
        Loader { id: rawDataPageLoader },
        Loader { id: correctionsPageLoader },
        Loader { id: explorePageLoader },
        Loader { id: resultsPageLoader },
        Loader { id: separatorPageLoader },
        Loader { id: liveViewPageLoader }
    ]

    /////////////
    // STATUS BAR
    /////////////

    statusBar: Components.StatusBar {}

    ////////////
    // GUI TESTS
    ////////////

    Loader {
        source: Globals.Vars.isTestMode ? 'GuiTestsController.qml' : ""
    }

}
