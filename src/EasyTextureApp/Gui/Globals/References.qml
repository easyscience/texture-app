// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick


// Initialisation of the reference dictionary. It is filled in later, when the required object is
// created and its unique id is assigned and added here instead of 'null'. After that, any object
// whose id is stored here can be accessed from any other qml file.
QtObject {

    // Populated in ApplicationWindows.qml
    readonly property var applicationWindow: {
        'appBarCentralTabs': {
            'homeButton': null,
            'projectButton': null,
            'rawDataButton': null,
            'correctionsButton': null,
            'exploreButton': null,
            'resultsButton': null,
            'liveViewButton': null,
        }
    }

    // Populated in Pages/...
    readonly property var pages: {
        'project': {
            'sidebar': {
                'basic': {
                    'popups': {
                        'openCifFile': null
                    }
                }
            }
        },
        'rawData': {
            'mainArea': {
                'tabLinePlot1d': {},
                'tabHeatmapPlot2d': {},
                'tabPolarHeatmapPlot2d': {},
                'tabSurfacePlot3d': {}
            },
            'sidebar': {
                'basic': {
                    'groups': {
                        'binning1d': {
                            'twoThetaBinWidthIndex': {},
                            'gammaBinWidthIndex': {},
                            'twoThetaSlider': {}
                        },
                        'binning2d': {
                            'twoThetaBinWidthIndex': {},
                            'gammaBinWidthIndex': {},
                            'twoThetaSlider': {}
                        },
                        'binning3d': {
                            'twoThetaBinWidthIndex': {},
                            'gammaBinWidthIndex': {},
                            'twoThetaSlider': {}
                        },
                    },
                    'popups': {
                        'openJsonFile': null
                    }
                }
            }
        },
        'corrections': {
            'sidebar': {
                'basic': {
                    'popups': {
                        'loadVortexCalibrationFile': null,
                        'loadEmptyMeasurementFile': null,
                        'loadVanadiumMeasurementFile': null
                    }
                }
            }
        },
        'explore': {
            'sidebar': {
                'basic': {
                    'popups': {
                        'openJsonFile': null
                    }
                }
            }
        },
        'results': {
            'sidebar': {
                'basic': {
                    'groups': {
                        'slicer': null
                    }
                }
            }
        },
        'liveView': {
            'sidebar': {
                'basic': {
                    'groups': {
                        'features2d': {
                            'twoThetaBinWidthIndex': {},
                            'gammaBinWidthIndex': {},
                            'twoThetaSlider': {}
                        },
                        'features3d': {
                            'twoThetaBinWidthIndex': {},
                            'gammaBinWidthIndex': {}
                        }
                    }
                }
            }
        },
    }
}
