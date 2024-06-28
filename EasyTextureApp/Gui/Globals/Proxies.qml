// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

pragma Singleton

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Logic as EaLogic

import Gui.Globals as Globals
import Gui.Logic as Logic


QtObject { // If "Unknown component. (M300) in QtCreator", try: "Tools > QML/JS > Reset Code Model"

    property var main: typeof pyProxy !== 'undefined' && pyProxy !== null ?
                                         pyProxy:
                                         qmlProxy

    readonly property var qmlProxy: QtObject {

        //////////////
        // Connections
        //////////////

        readonly property var connections: QtObject {

            Component.onCompleted: {
                // Project

                qmlProxy.project.nameChanged.connect(qmlProxy.project.setNeedSaveToTrue)
                qmlProxy.project.descriptionChanged.connect(qmlProxy.project.setNeedSaveToTrue)
                qmlProxy.project.isCreatedChanged.connect(qmlProxy.project.save)

                // RawData
                //qmlProxy.rawData.descriptionChanged.connect(qmlProxy.project.setNeedSaveToTrue)

                qmlProxy.rawData.isCreatedChanged.connect(function() {
                    print(`Raw data created: ${qmlProxy.rawData.isCreated}`)
                    qmlProxy.project.setNeedSaveToTrue()
                })


                // Corrections

                //qmlProxy.corrections.descriptionChanged.connect(qmlProxy.project.setNeedSaveToTrue)

                qmlProxy.corrections.isCreatedChanged.connect(function() {
                    print(`Corrections created: ${qmlProxy.corrections.isCreated}`)
                    qmlProxy.project.setNeedSaveToTrue()
                })

            }

        }

        //////////
        // Project
        //////////

        readonly property var project: QtObject {

            property bool isCreated: false
            property bool needSave: false
            //
            property string name: ''
            property string description: ''
            property string location: ''
            property string createdDate: ''
            property string image: Qt.resolvedUrl('../Resources/Project/Sine.svg')
            //
            property bool isEnabledOpenExistingProject: false
            property bool isEnabledSaveProjectAs: false
            property bool isEnabledCloseCurrentProject: false

            property var recentProjects: [
                {
                    'name': 'Bio-Sample (POWTEX)',
                    'description': 'neutron, powder, simulation, POWTEX@MLZ',
                    'path': '../Examples/Bio-sample/biosample_snippet.json'
                },
                {
                    'name': 'NaCl-Sample (POWTEX)',
                    'description': 'neutron, powder, simulation, POWTEX@MLZ',
                    'path': '../Resources/Examples/NaCl-sample/nacl.json'
                },
                {
                    'name': 'Powder-Sample (POWTEX)',
                    'description': 'neutron, powder, simulation, POWTEX@MLZ',
                    'path': '../Resources/Examples/Powder-sample/powder-example.json'
                }
            ]


            onNameChanged: {
                qmlProxy.status.project = name
            }

            function setNeedSaveToTrue() {
                needSave = true
            }

            function create() {
                createdDate = `${new Date().toLocaleDateString()} ${new Date().toLocaleTimeString()}`
                isCreated = true
            }

            // TODO
            function save() {
                let project = {}

                if (isCreated) {
                    project['project'] = {
                        'name': name,
                        'description': description,
                        'location': location,
                        'creationDate': createdDate
                    }
                }

                if (qmlProxy.rawData.isCreated) {
                    project['rawData'] = {
                        'name': qmlProxy.rawData.description.name,
                        'isCreated': qmlProxy.rawData.isCreated,
                        'parameters': qmlProxy.rawData.parameters,
                        'dataSize': qmlProxy.rawData.dataSize,
                        'xData': qmlProxy.rawData.xData,
                        'yData': qmlProxy.rawData.yData
                    }
                }

                if (qmlProxy.corrections.isCreated) {
                    project['corrections'] = {
                        'name': qmlProxy.corrections.description.name,
                        'isCreated': qmlProxy.corrections.isCreated,
                    }
                }

                if (qmlProxy.results.isCreated) {
                    project['results'] = {
                        'isCreated': qmlProxy.results.isCreated
                    }
                }

                const filePath = `${location}/project.json`
                EaLogic.Utils.writeFile(filePath, JSON.stringify(project))

                needSave = false
            }
        }


        /////////////
        // RawData
        /////////////

        readonly property var rawData: QtObject {

            property bool isCreated: false
            property bool isMmtFileAssigned: false
            property bool is1DtabSelected: false
            property bool is2DtabSelected: false
            property bool is2DthetaRingsTabSelected: false
            property bool is3DtabSelected: true
            property bool updateSliderParameters: false

            //Full paths
            property string selectedRawFile: ''
            property string selectedRawFile1D: ''
            property string selectedRawFile2D: ''
            property string selectedRawFile3D: ''

            //Just filenames
            property string selectedFileName: ''
            property string selectedFileName1D: ''
            property string selectedFileName2D: ''
            property string selectedFileName3D: ''

            property var rawFiles: []
            property string dataPath: ''
            property real twoTheta: 45.5
            property real twoThetaSliderValue: 45.5
            property real twoThetaRingsSliderValue: 45.5

            property real thetaRingsMinTT: 50.1
            property real slider1DStep: 0.5
            property real slider2DStep: 0.5

            property int twoThetaIndex //: 0
            property int gammaIndex//: 0
            property int selectedBinningIndex//: 0
            // selected tab index: 1: 3D view, 2: 2D(gamma-two theta), 3: 2D(two theta rings), 4: 1D view
            property int selectedTabIndex//: 1

            /*property int dataSize: 10
            property var xData: []
            property var yData: []*/

            function loadOneTwoThreeD() {
                dataPath = Qt.resolvedUrl("./../Data/RawDataView/")

                selectedFileName1D = "user_voxels_1D_sorted_by_gamma_1.json"
                selectedFileName2D = "user_voxels_2D_1.json"
                selectedFileName3D = "user_voxels_3D_1.json"

                selectedRawFile1D = dataPath + selectedFileName1D
                selectedRawFile2D = dataPath + selectedFileName2D
                selectedRawFile3D = dataPath + selectedFileName3D
            }

            function updateOneTwoThreeDBinning() {
                dataPath = Qt.resolvedUrl("./../Data/RawDataView/")
                selectedBinningIndex = 2*twoThetaIndex + gammaIndex + 1

                selectedFileName1D = "user_voxels_1D_sorted_by_gamma_%1.json".arg(selectedBinningIndex)
                selectedFileName2D = "user_voxels_2D_%1.json".arg(selectedBinningIndex)
                selectedFileName3D = "user_voxels_3D_%1.json".arg(selectedBinningIndex)

                selectedRawFile1D = dataPath + selectedFileName1D
                selectedRawFile2D = dataPath + selectedFileName2D
                selectedRawFile3D = dataPath + selectedFileName3D
            }

            /*
            function loadFile1D(){
                print("IN LOAD FILE 1D")
                selectedBinningIndex = 2*twoThetaIndex + gammaIndex + 1
                dataPath = Qt.resolvedUrl("./../Data/RawDataView/")

                selectedFileName1D = "user_voxels_1D_sorted_by_gamma_%1.json".arg(selectedBinningIndex)
                selectedRawFile1D = dataPath + selectedFileName1D
            }

            function loadFile2D(){
                print("IN LOAD FILE 2D")
                selectedBinningIndex = 2*twoThetaIndex + gammaIndex + 1
                dataPath = Qt.resolvedUrl("./../Data/RawDataView/")

                selectedFileName2D = "user_voxels_2D_%1.json".arg(selectedBinningIndex)
                selectedRawFile2D = dataPath + selectedFileName2D
            }

            function loadFile3D(){
                print("IN LOAD FILE 3D")
                selectedBinningIndex = 2*twoThetaIndex + gammaIndex + 1
                dataPath = Qt.resolvedUrl("./../Data/RawDataView/")

                selectedFileName3D = "user_voxels_3D_%1.json".arg(selectedBinningIndex)
                selectedRawFile3D = dataPath + selectedFileName3D

            }*/

            /*function updateBinned(){
                // updates datafile for loading based on selected binning
                //print("Tsb indx", selectedTabIndex)
                selectedBinningIndex = 2*twoThetaIndex + gammaIndex + 1
                dataPath = Qt.resolvedUrl("./../Data/RawDataView/")
                if (selectedTabIndex==4) {
                    selectedFileName = "user_voxels_1D_sorted_by_gamma_%1.json".arg(selectedBinningIndex)
                }
                if (selectedTabIndex==2 || selectedTabIndex==3) {
                    selectedFileName = "user_voxels_2D_%1.json".arg(selectedBinningIndex)
                }
                if (selectedTabIndex==1) {
                    selectedFileName = "user_voxels_3D_%1.json".arg(selectedBinningIndex)
                }
                selectedRawFile = dataPath + selectedFileName
            }*/

            onSelectedFileNameChanged: {
                qmlProxy.status.selectedRawDataFile = selectedFileName
            }

            function emptyData() {
                xData = []
                yData = []
                isCreated = false
            }
        }

        //////////////
        // Corrections
        //////////////

        readonly property var corrections: QtObject {
            signal parameterEdited(bool needSetFittables)
            signal parametersEdited(bool needSetFittables)

            property bool isCreated: isCorrectionFileAssigned
            property bool applyDataCorrection: false
            property bool isCorrectionFileAssigned: false
            property string correctionFileName

            function emptyData() {
                isCreated = false
            }

        }



        //////////////
        // Explore
        //////////////

        readonly property var explore: QtObject {

            //property int twoTheta: 90
            property int gammaSliceWidth

            property string exploreDataPath: ''

            property string exploreFileName: ''
            property string exploreFileName1D: ''
            property string exploreFileName2D: ''

            property string selectedExploreFile: ''
            property string selectedExploreFile1D: ''
            property string selectedExploreFile2D: ''

            property real twoThetaSliderValue: 45.5
            property real twoThetaSliderStep: 0.5

            property real totalCountMin//: -1.0
            property real totalCountMax//: -1.0
            property real totalCountSum//: -1.0
            property int numberOfGammaSlices: 270

            property real twoThetaRingCountMin//: -1.0
            property real twoThetaRingCountMax//: -1.0
            property real twoThetaRingCountSum//: -1.0
            property int maxIntensityWidth//: -1.0

            function loadOneTwoD() {
                exploreDataPath = Qt.resolvedUrl("./../Data/RawDataView/")

                exploreFileName1D = "user_voxels_1D_sorted_by_gamma_1.json"
                exploreFileName2D = "user_voxels_2D_1.json"

                selectedExploreFile1D = exploreDataPath + exploreFileName1D
                selectedExploreFile2D = exploreDataPath + exploreFileName2D
            }

            function updateBinning(){
                exploreDataPath = Qt.resolvedUrl("./../Data/RawDataView/")

                exploreFileName1D = "user_voxels_1D_sorted_by_gamma_%1.json".arg(gammaSliceWidth)
                exploreFileName2D = "user_voxels_2D_%1.json".arg(gammaSliceWidth)

                selectedExploreFile1D= exploreDataPath + exploreFileName1D
                selectedExploreFile2D = exploreDataPath + exploreFileName2D
            }

            onTwoThetaSliderValueChanged: {
                qmlProxy.status.selectedTwoTheta = twoThetaSliderValue
            }

            onGammaSliceWidthChanged: {
                qmlProxy.status.selectedGammaSliceWidth = gammaSliceWidth
            }
        }

        //////////
        // Results
        //////////

        readonly property var results: QtObject {
            property bool isCreated: false
            property bool isTwoThetaSelected: false
            property real gw: qmlProxy.explore.gammaSliceWidth
            property string selectedResultsFile: (gw==1) ? Qt.resolvedUrl("./../Data/ResultsView/user_voxels_d_pattern_1.json") : Qt.resolvedUrl("./../Data/ResultsView/user_voxels_d_pattern_2.json")
            property string selectedResultsTwoThetaFile: (gw==1) ? Qt.resolvedUrl("./../Data/ResultsView/user_voxels_two_theta_pattern_1.json") : Qt.resolvedUrl("./../Data/ResultsView/user_voxels_two_theta_pattern_2.json")

            property int sliderValue
            property int sliderMaxValue


            //Component.onCompleted: print("COMPLETED")
            function emptyData() {
                xData = []
                yData = []
                isCreated = false
            }

            // https://stackoverflow.com/questions/17882518/reading-and-writing-files-in-qml-qt
            // https://stackoverflow.com/questions/57351643/how-to-save-dynamically-generated-web-page-in-qwebengineview
            function saveHtmlReport(fileUrl) {
                const webEngine = Globals.Refs.resultsReportWebEngine
                webEngine.runJavaScript("document.documentElement.outerHTML",
                                        function(htmlContent) {
                                            const status = EaLogic.Utils.writeFile(fileUrl, htmlContent)
                                        })
            }
        }

        //////////////
        // Live View
        //////////////

        readonly property var liveView: QtObject {

            property bool isLiveViewSelected: false
            property bool is3DTabSelected: true
            property real twoThetaSliderValue: 45.5
            property real sliderStep: 1.0

            /*property int twoTheta: 90
            property int gammaSliceWidth: 1
            property string exploreDataPath: ''
            property string exploreFileName: ''
            property string selectedExploreFile: ''

            property real twoThetaSliderValue: 45.5
            property real twoThetaSliderStep: 0.5

            function updateBinning(){
                exploreDataPath = Qt.resolvedUrl("./../Data/RawDataView/")
                exploreFileName = "user_voxels_2D_%1.json".arg(gammaSliceWidth)
                selectedExploreFile = exploreDataPath + exploreFileName
            }*/
        }

        /////////
        // Status
        /////////

        property var status: QtObject {
            property bool isCreated: false
            property string project: 'Undefined'
            property string selectedRawDataFile: ''
            property string selectedTwoTheta: ''
            property string selectedGammaSliceWidth: ''
        }



        ///////////
        // Plotting
        ///////////

        readonly property var plotting: QtObject {
            readonly property bool useWebGL1d: false
            readonly property var libs1d: ['Plotly']
            property string currentLib1d: 'Plotly'
        }

    }

}
