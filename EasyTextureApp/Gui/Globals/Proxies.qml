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
            property string name: 'Default project'
            property string description: 'Default project description'
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

            property var rawFiles: []
            property string selectedRawFile: ''
            property string selectedFileName: ''
            property string dataPath: ''
            property real twoTheta: 45.5
            property real twoThetaSliderValue: 45.5
            property real twoThetaRingsSliderValue: 45.5

            property real thetaRingsMinTT: 50.1
            property real slider1DStep: 0.5
            property real slider2DStep: 0.5

            property int twoThetaIndex: 0
            property int gammaIndex: 0
            property int selectedBinningIndex: 0
            // selected tab index: 1: 3D view, 2: 2D(gamma-two theta), 3: 2D(two theta rings), 4: 1D view
            property int selectedTabIndex: 1

            property int dataSize: 10
            property var xData: []
            property var yData: []

            function updateBinned(){
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
            }

            function loadData() {
                const length = dataSize
                const slope = 0.0
                const yIntercept = 1.5
                //xData = Array.from({ length: length }, (_, i) => i+1)
                //xData = Array.from({ length: length }, (_, i) => i / (length - 1))//[0.1,0.15,0.2,0.25,0.3,0.35,0.4]//Array.from({ length: length }, (_, i) => i / (length - 1))
                //yData = Logic.LineCalculator.pseudoMeasured(xData, slope, yIntercept)
                isCreated = true
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
            property int gammaSliceWidth: 1

            property string exploreDataPath: ''
            property string exploreFileName: ''
            property string selectedExploreFile: Qt.resolvedUrl("./../Data/RawDataView/user_voxels_2D_1.json")

            property real twoThetaSliderValue: 45.5
            property real twoThetaSliderStep: 0.5

            property real totalCountMin: -1.0
            property real totalCountMax: -1.0
            property real totalCountSum: -1.0
            property int numberOfGammaSlices: 270

            property real twoThetaRingCountMin: -1.0
            property real twoThetaRingCountMax: -1.0
            property real twoThetaRingCountSum: -1.0
            property int maxIntensityWidth: -1.0

            function updateBinning(){
                exploreDataPath = Qt.resolvedUrl("./../Data/RawDataView/")
                exploreFileName = "user_voxels_2D_%1.json".arg(gammaSliceWidth)
                selectedExploreFile = exploreDataPath + exploreFileName
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

            property string asXml:
                `<root>
                  <item>
                    <name>Calculations</name>
                    <value>CrysPy</value>
                  </item>
                  <item>
                    <name>Minimization</name>
                    <value>lmfit</value>
                  </item>
                </root>`

            // assign key-value pairs for the status bar:
            property var projectStatusBar: [
                {
                    name: "Sample",
                    value: qmlProxy.project.name.toString()
                },
                {
                    name: "Location",
                    value: qmlProxy.project.location.toString()
                }
            ]

            property var twoThetaRingsStatusBar: [
                {
                    name: "2θ",
                    value: qmlProxy.explore.twoThetaSliderValue.toString()
                },
                {
                    name: "Slice-Width",
                    value: qmlProxy.explore.gammaSliceWidth.toString()
                }
            ]

            property var liveViewStatusBar: [
                {
                    name: "LiveView1",
                    value: "?", //qmlProxy.project.name.toString()
                },
                {
                    name: "LiveView2",
                    value: "??",//qmlProxy.project.location.toString()
                }
            ]
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
