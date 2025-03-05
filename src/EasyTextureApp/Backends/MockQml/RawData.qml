// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {
    readonly property int currentMeasurementIndex: -1
    property bool loaded: false

    property var measurements: []
    readonly property var measurementNames: measurements.map(function (item) { return item.name })
    property string selectedFilename: ''


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
}
