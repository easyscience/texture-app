// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {

    readonly property var about: {
        'name': 'EasyTexture',
        'namePrefix': 'Easy',
        'nameSuffix': 'Texture',
        'namePrefixForLogo': 'easy',
        'nameSuffixForLogo': 'texture',
        'homePageUrl': 'https://github.com/easyscience/texture-app',
        'issuesUrl': 'https://github.com/easyscience/texture-app/issues',
        'licenseUrl': 'https://github.com/easyscience/texture-app/LICENCE.md',
        'dependenciesUrl': 'https://github.com/EasyScience/EasyExample/DEPENDENCIES.md',
        'version': '0.0.1',
        'icon': Qt.resolvedUrl('../Resources/Logos/App.svg'),
        'date': new Date().toISOString().slice(0,10),
        'developerYearsFrom': '2019',
        'developerYearsTo': '2025',
        'description': 'Example of a desktop application of basic complexity with Python backend and EasyApp-based GUI',
        'developerIcons': [
            {
                'url': 'https://ess.eu',
                'icon': Qt.resolvedUrl('../Resources/Logos/ESS.png'),
                'heightScale': 3.0
            }
        ]
    }

}

