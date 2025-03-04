// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {
    readonly property int currentMeasurementIndex: -1
    property bool loaded: false

    //property string name: ''

    property var measurements: [
        {
            'indx': 1,
            'name': 'testname',
        },
        {
            'indx': 2,
            'name': 'testname2',
        },
        {
            'indx': 3,
            'name': 'testname3',
        },
    ]
    readonly property var measurementNames: measurements.map(function (item) { return item.name })
    property string selectedFilename: ''


    function loadMeasurement() {

        console.debug(`NOT IMPLEMENTED: LOAD MEASUREMENT FILE`, selectedFilename)
    }
    function setCurrentMeasurementIndex(value) {
        console.debug(`setCurrentMeasurementIndex ${value}`)
    }
    function setSelectedFilename(value) {
        console.debug(`setSelectedFileName ${value}`)
    }
    function removeFilename(text) {
        measurements = measurements.filter(item => item.name !== text)
        console.debug(`removeFilename with name ${text}`)
    }

    /*
    readonly property var examples: [
        {
            'description': 'neutron, powder, simulation, POWTEX@MLZ',
            'name': 'Bio-Sample (POWTEX)',
            'path': '/Examples/Bio-sample/biosample.json'
        },
        {
            'description': 'neutron, powder, simulation, POWTEX@MLZ',
            'name': 'NaCl-Sample (POWTEX)',
            'path': '/Examples/NaCl-sample/nacl.json'
        },
    ]


    function create() {
        console.debug(`Creating project '${name}'`)
        info.creationDate = `${new Date().toLocaleDateString()} ${new Date().toLocaleTimeString()}`
        infoChanged()  // this signal is not emitted automatically when only part of the object is changed
        created = true
    }

    function save() {
        console.debug(`NOT IMPLEMENTED: Saving project '${name}'`)
    }

    function editInfo(key, new_value) {
        console.debug(`In editInfo: Setting projectInfo['${key}'] to '${new_value}'`)
        info[key] = new_value
    }*/

}
