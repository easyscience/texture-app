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

    readonly property bool rawDataSyncTabsBinnings: activeBackend.rawData.syncTabsBinnings

    property int rawDataSelectedTabIndex: activeBackend.rawData.selectedTabIndex
    onRawDataSelectedTabIndexChanged: activeBackend.rawData.selectedTabIndex= rawDataSelectedTabIndex

    property real rawDataMinTwoThetaCenter: activeBackend.rawData.minTwoThetaCenter
    onRawDataMinTwoThetaCenterChanged: activeBackend.rawData.minTwoThetaCenter = rawDataMinTwoThetaCenter
    property real rawDataMaxTwoThetaCenter: activeBackend.rawData.maxTwoThetaCenter
    onRawDataMaxTwoThetaCenterChanged: activeBackend.rawData.maxTwoThetaCenter = rawDataMaxTwoThetaCenter
    property real rawDataTwoThetaBinWidth: activeBackend.rawData.twoThetaBinWidth
    onRawDataTwoThetaBinWidthChanged: activeBackend.rawData.twoThetaBinWidth = rawDataTwoThetaBinWidth
    property real rawDataGammaBinWidth: activeBackend.rawData.gammaBinWidth
    onRawDataGammaBinWidthChanged: activeBackend.rawData.gammaBinWidth = rawDataGammaBinWidth

    readonly property real rawDataMinTwoTheta: activeBackend.rawData.minTwoTheta
    readonly property real rawDataMaxTwoTheta: activeBackend.rawData.maxTwoTheta
    readonly property real rawDataGammaHoleLow: activeBackend.rawData.gammaHoleLow
    readonly property real rawDataGammaHoleHigh: activeBackend.rawData.gammaHoleHigh

    readonly property var rawDataMeasurements: activeBackend.rawData.measurements
    readonly property var rawDataMeasurementNames: activeBackend.rawData.measurementNames

    readonly property int rawDataCurrentMeasurementIndex: activeBackend.rawData.currentMeasurementIndex
    //property string rawDataSelectedFilename: activeBackend.rawData.selectedFilename

    property bool rawDataLoaded: activeBackend.rawData.loaded
    onRawDataLoadedChanged: activeBackend.rawData.loaded = rawDataLoaded

    property string rawDataSelectedFilePath: activeBackend.rawData.selectedFilePath
    onRawDataSelectedFilePathChanged: activeBackend.rawData.selectedFilePath = rawDataSelectedFilePath

    function rawDataLoadMeasurement(filePath) { activeBackend.rawData.loadMeasurement(filePath) }
    function rawDataSetSelectedFilename(path, name) { activeBackend.rawData.setSelectedFilename(path, name)}
    function rawDataRemoveFilename(text) {
        activeBackend.rawData.removeFilename(text);
        if (rawDataMeasurements.length === 0){
            rawDataLoaded = false
        }
    }
    function rawDataSetCurrentMeasurementIndex(value) { activeBackend.rawData.setCurrentMeasurementIndex(value) }
    property var rawDataLoadedData: activeBackend.rawData.loadedData

    //Binning Group
    property int rawDataTwoThetaBinWidthIndexMD: activeBackend.rawData.twoThetaBinWidthIndexMD
    property int rawDataGammaBinWidthIndexMD: activeBackend.rawData.gammaBinWidthIndexMD

    // Binning 3D
    property int rawDataTwoThetaBinWidthIndex3D: activeBackend.rawData.twoThetaBinWidthIndex3D
    onRawDataTwoThetaBinWidthIndex3DChanged: activeBackend.rawData.twoThetaBinWidthIndex3D = rawDataTwoThetaBinWidthIndex3D
    property int rawDataGammaBinWidthIndex3D: activeBackend.rawData.gammaBinWidthIndex3D
    onRawDataGammaBinWidthIndex3DChanged: activeBackend.rawData.gammaBinWidthIndex3D = rawDataGammaBinWidthIndex3D

    property string rawDataPlot3dFilepath: activeBackend.rawData.plot3dFilepath
    onRawDataPlot3dFilepathChanged: activeBackend.rawData.plot3dFilepath = rawDataPlot3dFilepath

    function rawDataUpdate3DTwoThetaBinningData(selectedBinWidthIndexValue) { activeBackend.rawData.update3DTwoThetaBinningData(selectedBinWidthIndexValue) }
    function rawDataUpdate3DGammaBinningData(selectedBinWidthIndexValue) { activeBackend.rawData.update3DGammaBinningData(selectedBinWidthIndexValue) }

    // Binning 2D
    property int rawDataTwoThetaBinWidthIndex2D: activeBackend.rawData.twoThetaBinWidthIndex2D
    onRawDataTwoThetaBinWidthIndex2DChanged: activeBackend.rawData.twoThetaBinWidthIndex2D = rawDataTwoThetaBinWidthIndex2D
    property int rawDataGammaBinWidthIndex2D: activeBackend.rawData.gammaBinWidthIndex2D
    onRawDataGammaBinWidthIndex2DChanged: activeBackend.rawData.gammaBinWidthIndex2D = rawDataGammaBinWidthIndex2D

    property real rawDataMinTwoThetaCenter2D: activeBackend.rawData.minTwoThetaCenter2D
    onRawDataMinTwoThetaCenter2DChanged: activeBackend.rawData.minTwoThetaCenter2D = rawDataMinTwoThetaCenter2D
    property real rawDataMaxTwoThetaCenter2D: activeBackend.rawData.maxTwoThetaCenter2D
    onRawDataMaxTwoThetaCenter2DChanged: activeBackend.rawData.maxTwoThetaCenter2D = rawDataMaxTwoThetaCenter2D
    property real rawDataTwoThetaBinWidth2D: activeBackend.rawData.twoThetaBinWidth2D
    onRawDataTwoThetaBinWidth2DChanged: activeBackend.rawData.twoThetaBinWidth2D = rawDataTwoThetaBinWidth2D
    property real rawDataGammaBinWidth2D: activeBackend.rawData.gammaBinWidth2D
    onRawDataGammaBinWidth2DChanged: activeBackend.rawData.gammaBinWidth2D = rawDataGammaBinWidth2D

    property real rawDataTwoThetaRingsSliderValue2D: activeBackend.rawData.twoThetaRingsSliderValue2D
    onRawDataTwoThetaRingsSliderValue2DChanged: activeBackend.rawData.twoThetaRingsSliderValue2D = rawDataTwoThetaRingsSliderValue2D

    property string rawDataPlot2dFilepath: activeBackend.rawData.plot2dFilepath
    onRawDataPlot2dFilepathChanged: activeBackend.rawData.plot2dFilepath = rawDataPlot2dFilepath

    function rawDataUpdate2DTwoThetaBinningData(selectedBinWidthIndexValue) { activeBackend.rawData.update2DTwoThetaBinningData(selectedBinWidthIndexValue) }
    function rawDataUpdate2DGammaBinningData(selectedBinWidthIndexValue) { activeBackend.rawData.update2DGammaBinningData(selectedBinWidthIndexValue) }

    // Binning 1D

    property int rawDataTwoThetaBinWidthIndex1D: activeBackend.rawData.twoThetaBinWidthIndex1D
    onRawDataTwoThetaBinWidthIndex1DChanged: activeBackend.rawData.twoThetaBinWidthIndex1D = rawDataTwoThetaBinWidthIndex1D
    property int rawDataGammaBinWidthIndex1D: activeBackend.rawData.gammaBinWidthIndex1D
    onRawDataGammaBinWidthIndex1DChanged: activeBackend.rawData.gammaBinWidthIndex1D = rawDataGammaBinWidthIndex1D

    property real rawDataMinTwoThetaCenter1D: activeBackend.rawData.minTwoThetaCenter1D
    onRawDataMinTwoThetaCenter1DChanged: activeBackend.rawData.minTwoThetaCenter1D = rawDataMinTwoThetaCenter1D
    property real rawDataMaxTwoThetaCenter1D: activeBackend.rawData.maxTwoThetaCenter1D
    onRawDataMaxTwoThetaCenter1DChanged: activeBackend.rawData.maxTwoThetaCenter1D = rawDataMaxTwoThetaCenter1D
    property real rawDataTwoThetaBinWidth1D: activeBackend.rawData.twoThetaBinWidth1D
    onRawDataTwoThetaBinWidth1DChanged: activeBackend.rawData.twoThetaBinWidth1D = rawDataTwoThetaBinWidth1D
    property real rawDataGammaBinWidth1D: activeBackend.rawData.gammaBinWidth1D
    onRawDataGammaBinWidth1DChanged: activeBackend.rawData.gammaBinWidth1D = rawDataGammaBinWidth1D

    property real rawDataTwoThetaSliderValue1D: activeBackend.rawData.twoThetaSliderValue1D
    onRawDataTwoThetaSliderValue1DChanged: activeBackend.rawData.twoThetaSliderValue1D = rawDataTwoThetaSliderValue1D
    property bool rawDataResetTwoThetaSlider1D: activeBackend.rawData.resetTwoThetaSlider1D
    onRawDataResetTwoThetaSlider1DChanged: activeBackend.rawData.resetTwoThetaSlider1D = rawDataResetTwoThetaSlider1D

    property string rawDataPlot1dFilepath: activeBackend.rawData.plot1dFilepath
    onRawDataPlot1dFilepathChanged: activeBackend.rawData.plot1dFilepath = rawDataPlot1dFilepath

    function rawDataUpdate1DTwoThetaBinningData(selectedBinWidthIndexValue) { activeBackend.rawData.update1DTwoThetaBinningData(selectedBinWidthIndexValue) }
    function rawDataUpdate1DGammaBinningData(selectedBinWidthIndexValue) { activeBackend.rawData.update1DGammaBinningData(selectedBinWidthIndexValue) }

    ///////////////
    // Summary page
    ///////////////

    readonly property string reportAsHtml: activeBackend.report.asHtml

    property bool reportCreated: activeBackend.report.created
    onReportCreatedChanged: activeBackend.report.created = reportCreated

}
