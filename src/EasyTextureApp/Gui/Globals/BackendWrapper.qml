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

    property string statusProject: activeBackend.status.project
    onStatusProjectChanged: activeBackend.status.project = statusProject
    property string statusRawDataFile: activeBackend.status.rawDataFile
    onStatusRawDataFileChanged: activeBackend.status.rawDataFile = statusRawDataFile
    property string statusGammaSliceWidth: exploreGammaBinWidth

    property bool statusProjectVisible: activeBackend.status.projectVisible
    onStatusProjectVisibleChanged: activeBackend.status.projectVisible = statusProjectVisible
    property bool statusRawDataFileVisible: activeBackend.status.rawDataFileVisible
    onStatusRawDataFileVisibleChanged: activeBackend.status.rawDataFileVisible = statusRawDataFileVisible
    property bool statusGammaSliceWidthVisible: activeBackend.status.gammaSliceWidthVisible
    onStatusGammaSliceWidthVisibleChanged: activeBackend.status.gammaSliceWidthVisible = statusGammaSliceWidthVisible

    /////////////////////////////
    // Global Detector Properties
    /////////////////////////////

    readonly property real minTwoTheta: 45
    readonly property real maxTwoTheta: 135
    readonly property real gammaHoleLow: 225
    readonly property real gammaHoleHigh: 315

    function getDetectorGammaRange() {
        let gammaRange = 360 - (gammaHoleHigh - gammaHoleLow)
        return gammaRange
    }

    function getGammaSliceRange(sliceIndx) {
        let currentBin = rawDataGenerateBinEdgesGamma(gammaHoleLow, gammaHoleHigh, exploreGammaBinWidth)[sliceIndx - 1]
        let binMin = currentBin[0]
        let binMax = currentBin[1]
        let gammaRange = "[" + binMin.toString() + "° ,  " + binMax.toString() + "°)"
        return gammaRange
    }

    ///////////////
    // Project page
    ///////////////

    readonly property var projectInfo: activeBackend.project.info
    readonly property var projectExamples: activeBackend.project.examples

    property bool projectCreated: activeBackend.project.created
    onProjectCreatedChanged: {
        activeBackend.project.created = projectCreated
        if (projectCreated) {
            statusProjectVisible = true
        } else {
            statusProjectVisible = false
        }
    }

    property string projectName: activeBackend.project.name
    onProjectNameChanged: {
        activeBackend.project.name = projectName
    }

    function projectCreate() {
        activeBackend.project.create()
        statusProject = projectName
    }

    function projectSave() {
        activeBackend.project.save()
    }

    function projectEditInfo(path, new_value) {
        activeBackend.project.editInfo(path, new_value)
    }

    ///////////////
    // RawData page
    ///////////////

    property bool rawDataCalculateViewsAtOnce: activeBackend.rawData.calculateViewsAtOnce
    onRawDataCalculateViewsAtOnceChanged: activeBackend.rawData.calculateViewsAtOnce = rawDataCalculateViewsAtOnce

    property real rawDataTwoThetaBinWidthValueSync: activeBackend.rawData.twoThetaBinWidthValueSync
    onRawDataTwoThetaBinWidthValueSyncChanged: activeBackend.rawData.twoThetaBinWidthValueSync = rawDataTwoThetaBinWidthValueSync
    property int rawDataTwoThetaBinWidthIndexSync: activeBackend.rawData.twoThetaBinWidthIndexSync
    onRawDataTwoThetaBinWidthIndexSyncChanged: activeBackend.rawData.twoThetaBinWidthIndexSync = rawDataTwoThetaBinWidthIndexSync
    property real rawDataGammaBinWidthValueSync: activeBackend.rawData.gammaBinWidthValueSync
    onRawDataGammaBinWidthValueSyncChanged: activeBackend.rawData.gammaBinWidthValueSync = rawDataGammaBinWidthValueSync
    property int rawDataGammaBinWidthIndexSync: activeBackend.rawData.gammaBinWidthIndexSync
    onRawDataGammaBinWidthIndexSyncChanged: activeBackend.rawData.gammaBinWidthIndexSync = rawDataGammaBinWidthIndexSync
    property real rawDataTwoThetaSliderValueSync: activeBackend.rawData.twoThetaSliderValueSync
    onRawDataTwoThetaSliderValueSyncChanged: activeBackend.rawData.twoThetaSliderValueSync = rawDataTwoThetaSliderValueSync
    property int rawDataTwoThetaSliderIndexSync: activeBackend.rawData.twoThetaSliderIndexSync
    onRawDataTwoThetaSliderIndexSyncChanged: activeBackend.rawData.twoThetaSliderIndexSync = rawDataTwoThetaSliderIndexSync


    property bool rawDataLoaded: activeBackend.rawData.loaded
    onRawDataLoadedChanged: {
        activeBackend.rawData.loaded = rawDataLoaded
        if (rawDataLoaded) {
            statusRawDataFileVisible = true
        } else {
            statusRawDataFileVisible = false
            statusGammaSliceWidthVisible = false
        }
    }
    property int rawDataSelectedTabIndex: activeBackend.rawData.selectedTabIndex
    onRawDataSelectedTabIndexChanged: activeBackend.rawData.selectedTabIndex = rawDataSelectedTabIndex

    property int rawDataResetTwoThetaSlider: activeBackend.rawData.resetTwoThetaSlider
    onRawDataResetTwoThetaSliderChanged: activeBackend.rawData.resetTwoThetaSlider = rawDataResetTwoThetaSlider
    // Load measurements group
    readonly property var rawDataMeasurements: activeBackend.rawData.measurements

    function rawDataLoadMeasurement(filePath) {
        activeBackend.rawData.loadMeasurement(filePath)
    }

    function rawDataSetSelectedFilename(path, name) {
        activeBackend.rawData.setSelectedFilename(path, name)
    }

    function rawDataRemoveFilename(text) {
        activeBackend.rawData.removeFilename(text)
        if (rawDataMeasurements.length === 0) {
            rawDataLoaded = false
        }
        if (rawDataMeasurements.length !== 0) {
            let lastFile = rawDataMeasurements[rawDataMeasurements.length - 1].name
            statusRawDataFile = lastFile
        }
    }

    // Binning 3D
    property string rawDataPlotFilepath3D: activeBackend.rawData.plotFilepath3D
    onRawDataPlotFilepath3DChanged: activeBackend.rawData.plotFilepath3D = rawDataPlotFilepath3D

    property int rawDataTwoThetaBinWidthIndex3D: activeBackend.rawData.twoThetaBinWidthIndex3D
    onRawDataTwoThetaBinWidthIndex3DChanged: activeBackend.rawData.twoThetaBinWidthIndex3D = rawDataTwoThetaBinWidthIndex3D
    property real rawDataMinTwoThetaCenter3D: activeBackend.rawData.minTwoThetaCenter3D
    onRawDataMinTwoThetaCenter3DChanged: activeBackend.rawData.minTwoThetaCenter3D = rawDataMinTwoThetaCenter3D
    property real rawDataMaxTwoThetaCenter3D: activeBackend.rawData.maxTwoThetaCenter3D
    onRawDataMaxTwoThetaCenter3DChanged: activeBackend.rawData.maxTwoThetaCenter3D = rawDataMaxTwoThetaCenter3D
    property real rawDataTwoThetaBinWidth3D: activeBackend.rawData.twoThetaBinWidth3D
    onRawDataTwoThetaBinWidth3DChanged: activeBackend.rawData.twoThetaBinWidth3D = rawDataTwoThetaBinWidth3D
    property real rawDataTwoThetaSliderValue3D: activeBackend.rawData.twoThetaSliderValue3D
    onRawDataTwoThetaSliderValue3DChanged: activeBackend.rawData.twoThetaSliderValue3D = rawDataTwoThetaSliderValue3D
    property int rawDataTwoThetaSliderIndex3D: activeBackend.rawData.twoThetaSliderIndex3D
    onRawDataTwoThetaSliderIndex3DChanged: activeBackend.rawData.twoThetaSliderIndex3D = rawDataTwoThetaSliderIndex3D

    property int rawDataGammaBinWidthIndex3D: activeBackend.rawData.gammaBinWidthIndex3D
    onRawDataGammaBinWidthIndex3DChanged: activeBackend.rawData.gammaBinWidthIndex3D = rawDataGammaBinWidthIndex3D
    property int rawDataGammaBinWidth3D: activeBackend.rawData.gammaBinWidth3D
    onRawDataGammaBinWidth3DChanged: activeBackend.rawData.gammaBinWidth3D = rawDataGammaBinWidth3D

    property bool rawDataRunJavaScriptIsOff3D: activeBackend.rawData.runJavaScriptIsOff3D
    onRawDataRunJavaScriptIsOff3DChanged: activeBackend.rawData.runJavaScriptIsOff3D = rawDataRunJavaScriptIsOff3D

    function rawDataUpdateTwoThetaSliderData3D(selectedBinWidthIndexValue) {
        activeBackend.rawData.updateTwoThetaSliderData3D(selectedBinWidthIndexValue)
    }

    function rawDataUpdateGammaBinWidth3D(selectedBinWidthIndexValue) {
        activeBackend.rawData.updateGammaBinWidth3D(selectedBinWidthIndexValue)
    }

    function rawDataGenerateSurfacePlot3D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx) {
        activeBackend.rawData.generateSurfacePlot3D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx)
    }

    function rawDataUpdateSliderPatchData3D(obj, sliderIndx) {
        activeBackend.rawData.updateSliderPatchData3D(obj, sliderIndx)
    }

    function rawDataUpdateSurfacePlotTwoThetaBinWidth3D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        activeBackend.rawData.updateSurfacePlotTwoThetaBinWidth3D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)
    }

    function rawDataUpdateSurfacePlotGammaBinWidth3D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        activeBackend.rawData.updateSurfacePlotGammaBinWidth3D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)
    }

    function rawDataGetTwoThetaSliderIndex3D() {
        return activeBackend.rawData.getTwoThetaSliderIndex3D()
    }

    // Binning 2D
    property string rawDataPlotFilepath2D: activeBackend.rawData.plotFilepath2D
    onRawDataPlotFilepath2DChanged: activeBackend.rawData.plotFilepath2D = rawDataPlotFilepath2D

    property int rawDataTwoThetaBinWidthIndex2D: activeBackend.rawData.twoThetaBinWidthIndex2D
    onRawDataTwoThetaBinWidthIndex2DChanged: activeBackend.rawData.twoThetaBinWidthIndex2D = rawDataTwoThetaBinWidthIndex2D
    property real rawDataMinTwoThetaCenter2D: activeBackend.rawData.minTwoThetaCenter2D
    onRawDataMinTwoThetaCenter2DChanged: activeBackend.rawData.minTwoThetaCenter2D = rawDataMinTwoThetaCenter2D
    property real rawDataMaxTwoThetaCenter2D: activeBackend.rawData.maxTwoThetaCenter2D
    onRawDataMaxTwoThetaCenter2DChanged: activeBackend.rawData.maxTwoThetaCenter2D = rawDataMaxTwoThetaCenter2D
    property real rawDataTwoThetaBinWidth2D: activeBackend.rawData.twoThetaBinWidth2D
    onRawDataTwoThetaBinWidth2DChanged: activeBackend.rawData.twoThetaBinWidth2D = rawDataTwoThetaBinWidth2D
    property real rawDataTwoThetaSliderValue2D: activeBackend.rawData.twoThetaSliderValue2D
    onRawDataTwoThetaSliderValue2DChanged: activeBackend.rawData.twoThetaSliderValue2D = rawDataTwoThetaSliderValue2D
    property int rawDataTwoThetaSliderIndex2D: activeBackend.rawData.twoThetaSliderIndex2D
    onRawDataTwoThetaSliderIndex2DChanged: activeBackend.rawData.twoThetaSliderIndex2D = rawDataTwoThetaSliderIndex2D

    property int rawDataGammaBinWidthIndex2D: activeBackend.rawData.gammaBinWidthIndex2D
    onRawDataGammaBinWidthIndex2DChanged: activeBackend.rawData.gammaBinWidthIndex2D = rawDataGammaBinWidthIndex2D
    property real rawDataGammaBinWidth2D: activeBackend.rawData.gammaBinWidth2D
    onRawDataGammaBinWidth2DChanged: activeBackend.rawData.gammaBinWidth2D = rawDataGammaBinWidth2D

    property bool rawDataRunJavaScriptIsOff2D: activeBackend.rawData.runJavaScriptIsOff2D
    onRawDataRunJavaScriptIsOff2DChanged: activeBackend.rawData.runJavaScriptIsOff2D = rawDataRunJavaScriptIsOff2D

    function rawDataUpdateTwoThetaSliderData2D(selectedBinWidthIndexValue) {
        activeBackend.rawData.updateTwoThetaSliderData2D(selectedBinWidthIndexValue)
    }

    function rawDataUpdateGammaBinWidth2D(selectedBinWidthIndexValue) {
        activeBackend.rawData.updateGammaBinWidth2D(selectedBinWidthIndexValue)
    }

    function rawDataGenerateHeatmap2D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx) {
        activeBackend.rawData.generateHeatmap2D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx)
    }

    function rawDataUpdateHeatmapTwoThetaBinWidth2D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        activeBackend.rawData.updateHeatmapTwoThetaBinWidth2D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)
    }

    function rawDataUpdateHeatmapGammaBinWidth2D(obj, twoThetaBinWidth, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        activeBackend.rawData.updateHeatmapGammaBinWidth2D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)
    }

    function rawDataGeneratePolarHeatmap2D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx) {
        activeBackend.rawData.generatePolarHeatmap2D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx)
    }

    function rawDataUpdatePolarHeatmapTwoThetaBinWidth2D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        activeBackend.rawData.updatePolarHeatmapTwoThetaBinWidth2D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)
    }

    function rawDataUpdatePolarHeatmapGammaBinWidth2D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        activeBackend.rawData.updatePolarHeatmapGammaBinWidth2D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)
    }

    // function rawDataUpdateSliderIndex2D(obj, sliderIndx) {
    //     activeBackend.rawData.updateSliderIndex2D(obj, sliderIndx)
    // }

    function rawDataUpdateSliceData2D(obj, sliderIndx) {
        activeBackend.rawData.updateSliceData2D(obj, sliderIndx)
    }

    function rawDataGetTwoThetaSliderIndex2D() {
        return activeBackend.rawData.getTwoThetaSliderIndex2D()
    }

    // Binning 1D
    property string rawDataPlotFilepath1D: activeBackend.rawData.plotFilepath1D
    onRawDataPlotFilepath1DChanged: activeBackend.rawData.plotFilepath1D = rawDataPlotFilepath1D

    property real rawDataTwoThetaBinWidth1D: activeBackend.rawData.twoThetaBinWidth1D
    onRawDataTwoThetaBinWidth1DChanged: activeBackend.rawData.twoThetaBinWidth1D = rawDataTwoThetaBinWidth1D
    property int rawDataTwoThetaBinWidthIndex1D: activeBackend.rawData.twoThetaBinWidthIndex1D
    onRawDataTwoThetaBinWidthIndex1DChanged: activeBackend.rawData.twoThetaBinWidthIndex1D = rawDataTwoThetaBinWidthIndex1D
    property real rawDataMinTwoThetaCenter1D: activeBackend.rawData.minTwoThetaCenter1D
    onRawDataMinTwoThetaCenter1DChanged: activeBackend.rawData.minTwoThetaCenter1D = rawDataMinTwoThetaCenter1D
    property real rawDataMaxTwoThetaCenter1D: activeBackend.rawData.maxTwoThetaCenter1D
    onRawDataMaxTwoThetaCenter1DChanged: activeBackend.rawData.maxTwoThetaCenter1D = rawDataMaxTwoThetaCenter1D
    property int rawDataTwoThetaSliderIndex1D: activeBackend.rawData.twoThetaSliderIndex1D
    onRawDataTwoThetaSliderIndex1DChanged: activeBackend.rawData.twoThetaSliderIndex1D = rawDataTwoThetaSliderIndex1D

    property int rawDataGammaBinWidthIndex1D: activeBackend.rawData.gammaBinWidthIndex1D
    onRawDataGammaBinWidthIndex1DChanged: activeBackend.rawData.gammaBinWidthIndex1D = rawDataGammaBinWidthIndex1D
    property real rawDataGammaBinWidth1D: activeBackend.rawData.gammaBinWidth1D
    onRawDataGammaBinWidth1DChanged: activeBackend.rawData.gammaBinWidth1D = rawDataGammaBinWidth1D

    property real rawDataTwoThetaSliderValue1D: activeBackend.rawData.twoThetaSliderValue1D
    onRawDataTwoThetaSliderValue1DChanged: activeBackend.rawData.twoThetaSliderValue1D = rawDataTwoThetaSliderValue1D

    property bool rawDataRunJavaScriptIsOff1D: activeBackend.rawData.runJavaScriptIsOff1D
    onRawDataRunJavaScriptIsOff1DChanged: activeBackend.rawData.runJavaScriptIsOff1D = rawDataRunJavaScriptIsOff1D

    function rawDataUpdateTwoThetaSliderData1D(selectedBinWidthIndexValue) {
        activeBackend.rawData.updateTwoThetaSliderData1D(selectedBinWidthIndexValue)
    }

    function rawDataUpdateGammaBinWidth1D(selectedBinWidthIndexValue) {
        activeBackend.rawData.updateGammaBinWidth1D(selectedBinWidthIndexValue)
    }

    function rawDataGenerateBinEdgesGamma(holeLow, holeHigh, binStep, dropIncomplete = true) {
        let gammaBinsList = activeBackend.rawData.generateBinEdgesGamma(holeLow, holeHigh, binStep, dropIncomplete)
        return gammaBinsList
    }

    function rawDataGenerateLinePlot1D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx) {
        activeBackend.rawData.generateLinePlot1D(obj, filepath, twoThetaBinWidth, gammaBinWidth, sliderIndx)
    }

    function rawDataUpdateLinePlot1D(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        activeBackend.rawData.updateLinePlot1D(twoThetaBinWidth, gammaBinWidth, currentTwoTheta)
    }

    function rawDataUpdateLinePlotTwoThetaBinWidth1D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        activeBackend.rawData.updateLinePlotTwoThetaBinWidth1D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)
    }

    function rawDataUpdateLinePlotGammaBinWidth1D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex) {
        activeBackend.rawData.updateLinePlotGammaBinWidth1D(obj, twoThetaBinWidth, gammaBinWidth, twoThetaSliderIndex)
    }

    function rawDataUpdateSliceData1D(obj, sliderIndx) {
        activeBackend.rawData.updateSliceData1D(obj, sliderIndx)
    }

    function rawDataGetTwoThetaSliderIndex1D() {
        return activeBackend.rawData.getTwoThetaSliderIndex1D()
    }

    ///////////////////
    // Corrections page
    ///////////////////

    property bool correctionsCreated: activeBackend.corrections.created
    onCorrectionsCreatedChanged: activeBackend.corrections.created = correctionsCreated

    property bool correctionsLoadCalibration: activeBackend.corrections.loadCalibration
    onCorrectionsLoadCalibrationChanged: activeBackend.corrections.loadCalibration = correctionsLoadCalibration
    property bool correctionsLoadEmpty: activeBackend.corrections.loadEmpty
    onCorrectionsLoadEmptyChanged: activeBackend.corrections.loadEmpty = correctionsLoadEmpty
    property bool correctionsLoadVanadium: activeBackend.corrections.loadVanadium
    onCorrectionsLoadVanadiumChanged: activeBackend.corrections.loadVanadium = correctionsLoadVanadium

    function correctionsLoadVanadiumMeasurement(filePath) {
        activeBackend.corrections.loadVanadiumMeasurement(filePath)
    }

    ///////////////
    // Explore page
    ///////////////

    property bool exploreActivated: activeBackend.explore.activated
    onExploreActivatedChanged: {
        activeBackend.explore.activated = exploreActivated
        if (exploreActivated) {
            statusGammaSliceWidthVisible = true
        } else {
            statusGammaSliceWidthVisible = false
        }
    }

    property int exploreTwoThetaBinWidthIndex: activeBackend.explore.twoThetaBinWidthIndex
    onExploreTwoThetaBinWidthIndexChanged: activeBackend.explore.twoThetaBinWidthIndex = exploreTwoThetaBinWidthIndex
    property real exploreMinTwoThetaCenter: activeBackend.explore.minTwoThetaCenter
    onExploreMinTwoThetaCenterChanged: activeBackend.explore.minTwoThetaCenter = exploreMinTwoThetaCenter
    property real exploreMaxTwoThetaCenter: activeBackend.explore.maxTwoThetaCenter
    onExploreMaxTwoThetaCenterChanged: activeBackend.explore.maxTwoThetaCenter = exploreMaxTwoThetaCenter
    property real exploreTwoThetaBinWidth: activeBackend.explore.twoThetaBinWidth
    onExploreTwoThetaBinWidthChanged: activeBackend.explore.twoThetaBinWidth = exploreTwoThetaBinWidth
    property real exploreTwoThetaSliderValue: activeBackend.explore.twoThetaSliderValue
    onExploreTwoThetaSliderValueChanged: activeBackend.explore.twoThetaSliderValue = exploreTwoThetaSliderValue

    property int exploreGammaBinWidthIndex: activeBackend.explore.gammaBinWidthIndex
    onExploreGammaBinWidthIndexChanged: activeBackend.explore.gammaBinWidthIndex = exploreGammaBinWidthIndex
    property real exploreGammaBinWidth: activeBackend.explore.gammaBinWidth
    onExploreGammaBinWidthChanged: activeBackend.explore.gammaBinWidth = exploreGammaBinWidth

    property string explorePlotFilepath: activeBackend.explore.plotFilepath
    onExplorePlotFilepathChanged: activeBackend.explore.plotFilepath = explorePlotFilepath

    function exploreGenerate2dPolarHeatmapPlot(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        activeBackend.explore.generate2dPolarHeatmapPlot(twoThetaBinWidth, gammaBinWidth, currentTwoTheta)
    }
    function exploreGenerate1dLinePlot(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        activeBackend.explore.generate1dLinePlot(twoThetaBinWidth, gammaBinWidth, currentTwoTheta)
    }

    // Statistics related
    property int exploreTotalCountsMin: activeBackend.explore.totalCountsMin
    onExploreTotalCountsMinChanged: activeBackend.explore.totalCountsMin = exploreTotalCountsMin
    property int exploreTotalCountsMax: activeBackend.explore.totalCountsMax
    onExploreTotalCountsMaxChanged: activeBackend.explore.totalCountsMax = exploreTotalCountsMax
    property int exploreTotalCountsSum: activeBackend.explore.totalCountsSum
    onExploreTotalCountsSumChanged: activeBackend.explore.totalCountsSum = exploreTotalCountsSum

    function exploreSetTotalStatistics(twoThetaBinWidth, gammaBinWidth) {
        activeBackend.explore.setTotalStatistics(twoThetaBinWidth, gammaBinWidth)
    }

    property int exploreRingCountsMin: activeBackend.explore.ringCountsMin
    onExploreRingCountsMinChanged: activeBackend.explore.ringCountsMin = exploreRingCountsMin
    property int exploreRingCountsMax: activeBackend.explore.ringCountsMax
    onExploreRingCountsMaxChanged: activeBackend.explore.ringCountsMax = exploreRingCountsMax
    property int exploreRingCountsSum: activeBackend.explore.ringCountsSum
    onExploreRingCountsSumChanged: activeBackend.explore.ringCountsSum = exploreRingCountsSum
    property real exploreRingMaxIntensityWidth: activeBackend.explore.ringMaxIntensityWidth
    onExploreRingMaxIntensityWidthChanged: activeBackend.explore.ringMaxIntensityWidth = exploreRingMaxIntensityWidth

    function exploreSetRingStatistics(twoThetaBinWidth, gammaBinWidth, currentTwoTheta) {
        activeBackend.explore.setRingStatistics(twoThetaBinWidth, gammaBinWidth, currentTwoTheta)
    }

    ///////////////
    // Results page
    ///////////////

    property bool resultsCreated: activeBackend.results.created
    onResultsCreatedChanged: activeBackend.results.created = resultsCreated

    readonly property int resultsMinSliderValue: 1
    property int resultsMaxSliderValue: activeBackend.results.maxSliderValue
    onResultsMaxSliderValueChanged: activeBackend.results.maxSliderValue = resultsMaxSliderValue
    property int resultsSelectedTabIndex: 0

    property string resultsDPatternPlotFilepath: activeBackend.results.dPatternPlotFilepath
    onResultsDPatternPlotFilepathChanged: activeBackend.results.dPatternPlotFilepath = resultsDPatternPlotFilepath
    property string resultsTwoThetaPlotFilepath: activeBackend.results.twoThetaPlotFilepath
    onResultsTwoThetaPlotFilepathChanged: activeBackend.results.twoThetaPlotFilepath = resultsTwoThetaPlotFilepath

    property int resultsRingIndexSliderValue: activeBackend.results.ringIndexSliderValue
    onResultsRingIndexSliderValueChanged: activeBackend.results.ringIndexSliderValue = resultsRingIndexSliderValue

    function resultsGenerateDSpacingBarPlot(dSpacingBinWidth, gammaBinWidth, currentGammaSliceIndx) {
        activeBackend.results.generateDSpacingBarPlot(dSpacingBinWidth, gammaBinWidth, currentGammaSliceIndx)
    }

    function resultsGenerateTwoThetaBarPlot(twoThetaBinWidth, gammaBinWidth, currentGammaSliceIndx) {
        activeBackend.results.generateTwoThetaBarPlot(twoThetaBinWidth, gammaBinWidth, currentGammaSliceIndx)
    }

    function resultsGenerateIntegratedTwoThetaBarPlot(twoThetaBinWidth, gammaBinWidth) {
        activeBackend.results.generateIntegratedTwoThetaBarPlot(twoThetaBinWidth, gammaBinWidth)
    }

    ////////////////
    // LiveView page
    ////////////////

    property bool liveViewConnected: activeBackend.liveView.connected
    onLiveViewConnectedChanged: activeBackend.liveView.connected = liveViewConnected

    property int liveViewSelectedTabIndex: activeBackend.liveView.selectedTabIndex
    onLiveViewSelectedTabIndexChanged: activeBackend.liveView.selectedTabIndex = liveViewSelectedTabIndex

    // Binning 3D
    property string liveViewPlotFilepath3D: activeBackend.liveView.plotFilepath3D
    onLiveViewPlotFilepath3DChanged: activeBackend.liveView.plotFilepath3D = liveViewPlotFilepath3D

    property int liveViewTwoThetaBinWidthIndex3D: activeBackend.liveView.twoThetaBinWidthIndex3D
    onLiveViewTwoThetaBinWidthIndex3DChanged: activeBackend.liveView.twoThetaBinWidthIndex3D = liveViewTwoThetaBinWidthIndex3D
    property real liveViewTwoThetaBinWidth3D: activeBackend.liveView.twoThetaBinWidth3D
    onLiveViewTwoThetaBinWidth3DChanged: activeBackend.liveView.twoThetaBinWidth3D = liveViewTwoThetaBinWidth3D

    property int liveViewGammaBinWidthIndex3D: activeBackend.liveView.gammaBinWidthIndex3D
    onLiveViewGammaBinWidthIndex3DChanged: activeBackend.liveView.gammaBinWidthIndex3D = liveViewGammaBinWidthIndex3D
    property int liveViewGammaBinWidth3D: activeBackend.liveView.gammaBinWidth3D
    onLiveViewGammaBinWidth3DChanged: activeBackend.liveView.gammaBinWidth3D = liveViewGammaBinWidth3D

    function liveViewUpdatePlotFilepath3D() {
        activeBackend.liveView.updatePlotFilepath3D()
    }

    // Binning 2D
    property string liveViewPlotFilepath2D: activeBackend.liveView.plotFilepath2D
    onLiveViewPlotFilepath2DChanged: activeBackend.liveView.plotFilepath2D = liveViewPlotFilepath2D

    property int liveViewTwoThetaBinWidthIndex2D: activeBackend.liveView.twoThetaBinWidthIndex2D
    onLiveViewTwoThetaBinWidthIndex2DChanged: activeBackend.liveView.twoThetaBinWidthIndex2D = liveViewTwoThetaBinWidthIndex2D
    property real liveViewMinTwoThetaCenter2D: activeBackend.liveView.minTwoThetaCenter2D
    onLiveViewMinTwoThetaCenter2DChanged: activeBackend.rawData.minTwoThetaCenter2D = rawDataMinTwoThetaCenter2D
    property real liveViewMaxTwoThetaCenter2D: activeBackend.liveView.maxTwoThetaCenter2D
    onLiveViewMaxTwoThetaCenter2DChanged: activeBackend.liveView.maxTwoThetaCenter2D = liveViewMaxTwoThetaCenter2D
    property real liveViewTwoThetaBinWidth2D: activeBackend.liveView.twoThetaBinWidth2D
    onLiveViewTwoThetaBinWidth2DChanged: activeBackend.liveView.twoThetaBinWidth2D = liveViewTwoThetaBinWidth2D
    property real liveViewTwoThetaSliderValue2D: activeBackend.liveView.twoThetaSliderValue2D
    onLiveViewTwoThetaSliderValue2DChanged: activeBackend.liveView.twoThetaSliderValue2D = liveViewTwoThetaSliderValue2D

    property int liveViewGammaBinWidthIndex2D: activeBackend.liveView.gammaBinWidthIndex2D
    onLiveViewGammaBinWidthIndex2DChanged: activeBackend.liveView.gammaBinWidthIndex2D = liveViewGammaBinWidthIndex2D
    property real liveViewGammaBinWidth2D: activeBackend.liveView.gammaBinWidth2D
    onLiveViewGammaBinWidth2DChanged: activeBackend.liveView.gammaBinWidth2D = liveViewGammaBinWidth2D

    function liveViewUpdatePlotFilepath2D() {
        activeBackend.liveView.updatePlotFilepath2D()
    }
}
