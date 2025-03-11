// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

// This module is registered in the main.py file and allows access to the properties
// and backend  methods of the singleton object of the ‘PyBackend’ class.
// If ‘PyBackend’ is not defined, then 'MockBackend' from directory 'Backends' is used.
// It is needed to run the GUI frontend via the qml runtime tool without any Python backend.
import Backends as Backends


QtObject {

    ////////////////
    // Backend proxy
    ////////////////

    readonly property var activeBackend: {
        if (typeof Backends.PyBackend !== 'undefined') {
            console.debug('REAL python backend is in use')
            return Backends.PyBackend
        } else {
            console.debug('MOCK QML backend is in use')
            return Backends.MockBackend
        }
    }

    /////////////
    // Status bar
    /////////////

    readonly property string statusProject: activeBackend.status.project
    readonly property string statusPhasesCount: activeBackend.status.phasesCount
    readonly property string statusExperimentsCount: activeBackend.status.experimentsCount
    readonly property string statusCalculator: activeBackend.status.calculator
    readonly property string statusMinimizer: activeBackend.status.minimizer
    readonly property string statusVariables: activeBackend.status.variables

    ///////////////
    // Project page
    ///////////////

    readonly property var projectInfo: activeBackend.project.info
    readonly property var projectExamples: activeBackend.project.examples

    property bool projectCreated: activeBackend.project.created
    onProjectCreatedChanged: activeBackend.project.created = projectCreated
    property string projectName: activeBackend.project.name
    onProjectNameChanged: activeBackend.project.name = projectName

    function projectCreate() { activeBackend.project.create() }
    function projectSave() { activeBackend.project.save() }
    function projectEditInfo(path, new_value) { activeBackend.project.editInfo(path, new_value) }

    ///////////////
    // RawData page
    ///////////////

    readonly property var rawDataMeasurements: activeBackend.rawData.measurements
    readonly property var rawDataMeasurementNames: activeBackend.rawData.measurementNames

    readonly property int rawDataCurrentMeasurementIndex: activeBackend.rawData.currentMeasurementIndex
    //property string rawDataSelectedFilename: activeBackend.rawData.selectedFilename

    property bool rawDataLoaded: activeBackend.rawData.loaded
    onRawDataLoadedChanged: activeBackend.rawData.loaded = rawDataLoaded

    function rawDataLoadMeasurement(filePath) { activeBackend.rawData.loadMeasurement(filePath) }
    function rawDataSetSelectedFilename(path, name) { activeBackend.rawData.setSelectedFilename(path, name)}
    function rawDataRemoveFilename(text) {
        activeBackend.rawData.removeFilename(text);
        if (rawDataMeasurements.length === 0){
            rawDataLoaded = false
        }
    }
    function rawDataSetCurrentMeasurementIndex(value) { activeBackend.rawData.setCurrentMeasurementIndex(value) }

    property int rawDataSelectedTabIndex: activeBackend.rawData.selectedTabIndex
    onRawDataSelectedTabIndexChanged: activeBackend.rawData.selectedTabIndex= rawDataSelectedTabIndex
    property int rawDataTwoThetaIndex: activeBackend.rawData.twoThetaIndex
    onRawDataTwoThetaIndexChanged: activeBackend.rawData.twoThetaIndex = rawDataTwoThetaIndex
    property int rawDataGammaIndex: activeBackend.rawData.gammaIndex
    onRawDataGammaIndexChanged: activeBackend.rawData.gammaIndex = rawDataGammaIndex
    property real rawDataTwoThetaRingsSliderValue: activeBackend.rawData.twoThetaRingsSliderValue
    onRawDataTwoThetaRingsSliderValueChanged: activeBackend.rawData.twoThetaRingsSliderValue = rawDataTwoThetaRingsSliderValue
    property real rawDataTwoThetaSliderValue: activeBackend.rawData.twoThetaSliderValue
    onRawDataTwoThetaSliderValueChanged: activeBackend.rawData.twoThetaSliderValue = rawDataTwoThetaSliderValue
    //property real rawDataTwoThetaRingsSliderStep: activeBackend.rawData.twoThetaRingsSliderStep
    //onRawDataTwoThetaRingsSliderStepChanged: activeBackend.rawData.twoThetaRingsSliderStep = rawDataTwoThetaRingsSliderStep
    property real rawDataTwoThetaSliderStep: activeBackend.rawData.twoThetaSliderStep
    onRawDataTwoThetaSliderStepChanged: activeBackend.rawData.twoThetaSliderStep = rawDataTwoThetaSliderStep


    property string rawDataPlot3dFilepath: activeBackend.rawData.plot3dFilepath
    onRawDataPlot3dFilepathChanged: activeBackend.rawData.surface3dPlotFilepath = rawDataPlot3dFilepath
    property string rawDataPlot2dHeatmapFilepath: activeBackend.rawData.plot2dHeatmapFilepath
    onRawDataPlot2dHeatmapFilepathChanged: activeBackend.rawData.plot2dHeatmapFilepath = rawDataPlot2dHeatmapFilepath
    property string rawDataPlot2dPolarHeatmapFilepath: activeBackend.rawData.plot2dPolarHeatmapFilepath
    onRawDataPlot2dPolarHeatmapFilepathChanged: activeBackend.rawData.plot2dPolarHeatmapFilepath = rawDataPlot2dPolarHeatmapFilepath
    property string rawDataPlot1dFilepath: activeBackend.rawData.plot1dFilepath
    onRawDataPlot1dFilepathChanged: activeBackend.rawData.plot1dFilepath = rawDataPlot1dFilepath

    //function rawDataLoadMeasurement(filePath) { activeBackend.rawData.loadMeasurement(filePath) }
    ///////////////
    // Summary page
    ///////////////

    readonly property string reportAsHtml: activeBackend.report.asHtml

    property bool reportCreated: activeBackend.report.created
    onReportCreatedChanged: activeBackend.report.created = reportCreated
}
