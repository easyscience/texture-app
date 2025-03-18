// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {
    property bool loaded: false
    readonly property real twoThetaMin: 45.5


    // Load measurements group
    property var measurements: []
    readonly property var measurementNames: measurements.map(function (item) { return item.name })
    property string selectedFilePath: ''
    readonly property int currentMeasurementIndex: -1
    property string plot3dFilepath: '../../../../../../examples/RawData/user_voxels_3D.json'
    property string plot2dHeatmapFilepath: '../../../../../../examples/RawData/user_voxels_2D_sorted_1.json'
    property string plot2dPolarHeatmapFilepath: '../../../../../../examples/RawData/user_voxels_2D_sorted_1.json'
    property string plot1dFilepath: '../../../../../../examples/RawData/user_voxels_1D_sorted_by_gamma_1.json'

    function loadMeasurement(filePath) {
        console.debug(`NOT IMPLEMENTED: loadMeasurement file ${filePath}. Load pre-saved files instead.`)
        let [twoThetaBinWidth, gammaBinWidth] = getBinning(twoThetaIndex, gammaIndex);
        generate3dSurfacePlot(filePath, twoThetaBinWidth, gammaBinWidth)
        generate2dHeatmapPlot(filePath, twoThetaBinWidth, gammaBinWidth)
        generate2dPolarHeatmapPlot(filePath, twoThetaBinWidth, gammaBinWidth)
        generate1dLinePlot(filePath, twoThetaBinWidth, gammaBinWidth)
    }

    function generate3dSurfacePlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`NOT IMPLEMENTED: generate3dSurfacePlot for file ${filePath}. Load ${plot3dFilepath}$ instead.`)
        //let twoThetaBinSize = getTwoThetaBinning(twoThetaIndex)
        //let gammaBinSize = getGammaBinning(gammaIndex)
    }

    function generate2dHeatmapPlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`NOT IMPLEMENTED: generate2dHeatmapPlot for file ${filePath}. Load ${plot2dHeatmapFilepath}$ instead.`)
        //let twoThetaBinSize = getTwoThetaBinning(twoThetaIndex)
        //let gammaBinSize = getGammaBinning(gammaIndex)
    }

    function generate2dPolarHeatmapPlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`NOT IMPLEMENTED: generate2dPolarHeatmapPlot for file ${filePath}. Load ${plot2dPolarHeatmapFilepath}$ instead.`)
        //let twoThetaBinSize = getTwoThetaBinning(twoThetaIndex)
        //let gammaBinSize = getGammaBinning(gammaIndex)
    }

    function generate1dLinePlot(filePath, twoThetaBinWidth, gammaBinWidth) {
        console.debug(`NOT IMPLEMENTED: generate1dLinePlot for file ${filePath}. Load ${plot1dFilepath}$ instead.`)
        //let twoThetaBinSize = getTwoThetaBinning(twoThetaIndex)
        //let gammaBinSize = getGammaBinning(gammaIndex)
    }

    function setCurrentMeasurementIndex(value) {
        console.debug(`setCurrentMeasurementIndex ${value}: NOT IMPLEMENTED`)
    }

    function setSelectedFilename(path, name) {
        console.debug(`setSelectedFileName ${name}`)

        // Check if the path already exists in the measurements array
        var pathExists = measurements.some(function(entry) {
            return entry.path === path;
        });

        if (!pathExists) {
            var newEntry = {
                'indx': measurements.length + 1,
                'path':  path,
                'name':  name
            };
            measurements = measurements.concat([newEntry])
        } else {
            console.debug(`Path ${path} already exists.`);
        }
    }

    function removeFilename(text) {
        measurements = measurements.filter(item => item.name !== text)
        console.debug(`removeFilename with name ${text}`)
    }

    function getTwoThetaBinning(twoThetaIndex) {
        console.debug(`getTwoThetaBinning for two theta index ${twoThetaIndex}`)
        const twoTheta = [0.5, 1]
        // in final version
        //const twoTheta = [0.1, 0.25, 0.5, 0.75, 1, 2, 5, 10];
        return twoTheta[twoThetaIndex]
    }

    function getGammaBinning(gammaIndex) {
        console.debug(`getGammaBinning for gamma index ${gammaIndex}`)
        const gamma = [1, 2]
        // in final version
        //const gamma = [0.1, 1, 2, 5, 10]
        return gamma[gammaIndex]
    }

    function getBinning(twoThetaIndex, gammaIndex) {
        let twoThetaBinning =  getTwoThetaBinning(twoThetaIndex)
        let gammaBinning =  getGammaBinning(gammaIndex)
        console.debug(`getBinning: two_theta_bin_width ${twoThetaBinning} and gamma_bin_width ${gammaBinning}`)
        return [twoThetaBinning, gammaBinning]
    }

    //Binning Group
    property int selectedTabIndex
    property int twoThetaIndex//: 0
    property real twoThetaSliderStep: 0.5
    onTwoThetaIndexChanged: {
        console.debug(`TwoThetaIndexChanged to`, twoThetaIndex)
        updateTwoThetaSliderStep(twoThetaIndex)
        updateFigure(selectedTabIndex)

    }
    property int gammaIndex//: 0
    onGammaIndexChanged: {
        console.debug(`GammaIndexChanged to`, gammaIndex)
        updateFigure(selectedTabIndex)
    }

    function updateFigure(tab_indx) {
        console.debug(`updateFigure for tab ${tab_indx}: NOT IMPLEMENTED`)
    }
    function updateTwoThetaSliderStep(two_theta_indx) {
        if (two_theta_indx === 0) {
            twoThetaSliderStep = 0.5
            console.debug(`updateTwoThetaSliderStep to ${twoThetaSliderStep}`)
        } else if (two_theta_indx === 1) {
            twoThetaSliderStep = 1
            console.debug(`updateTwoThetaSliderStep to ${twoThetaSliderStep}`)
        } else {
            console.debug(`updateTwoThetaSliderStep for two theta index ${two_theta_indx}: NOT IMPLEMENTED`)
        }
    }

    // Binning 3D

    // Binning 2D
    property real twoThetaRingsSliderValue: 45.5
    onTwoThetaRingsSliderValueChanged: {
        console.debug(`TwoThetaRingsSliderValueChanged to`, twoThetaRingsSliderValue)
        updateFigure(selectedTabIndex)
    }
    //property real twoThetaRingsSliderStep: 0.5

    // Binning 1D
    property real twoThetaSliderValue: 45.5
    onTwoThetaSliderValueChanged: {
        console.debug(`TwoThetaSliderValueChanged to`, twoThetaSliderValue)
        updateFigure(selectedTabIndex)
    }
}
