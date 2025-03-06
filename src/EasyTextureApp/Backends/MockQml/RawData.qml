// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {
    property bool loaded: false

    // Load measurements group
    property var measurements: []
    readonly property var measurementNames: measurements.map(function (item) { return item.name })
    property string selectedFilename: ''
    readonly property int currentMeasurementIndex: -1

    function loadMeasurement() {
        console.debug(`loadMeasurement: NOT IMPLEMENTED`, selectedFilename)
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
