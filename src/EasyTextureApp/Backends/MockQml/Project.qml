// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {

    property bool created: false

    property string name: ''

    readonly property var info: {
        'description': '',
        'location': '',
        'creationDate': ''
    }

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
        {
            'description': 'neutron, powder, simulation, POWTEX@MLZ',
            'name': 'Powder-Sample (POWTEX)',
            'path': '/Examples/Powder-sample/powder.json'
        }
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
    }

}
