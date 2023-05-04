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

                qmlProxy.rawData.descriptionChanged.connect(qmlProxy.project.setNeedSaveToTrue)

                qmlProxy.rawData.isCreatedChanged.connect(function() {
                    print(`Experiment created: ${qmlProxy.rawData.isCreated}`)
                    qmlProxy.parameters.setFittables()
                    qmlProxy.project.setNeedSaveToTrue()
                })

                qmlProxy.rawData.parameterEdited.connect(function(needSetFittables) {
                    qmlProxy.rawData.parametersEdited(needSetFittables)
                })

                qmlProxy.rawData.parametersEdited.connect(function(needSetFittables) {
                    print(`Experiment parameters changed. Need set fittables: ${needSetFittables}`)
                    qmlProxy.rawData.parametersChanged()
                    qmlProxy.rawData.loadData()
                    if (needSetFittables) {
                        qmlProxy.parameters.setFittables()
                    }
                    qmlProxy.project.setNeedSaveToTrue()
                })

                qmlProxy.rawData.dataSizeChanged.connect(function() {
                    print(`Experiment data size: ${qmlProxy.rawData.dataSize}`)
                    qmlProxy.rawData.loadData()
                    if (qmlProxy.corrections.isCreated) {
                        qmlProxy.corrections.calculateData()
                    }
                })

                // Corrections

                qmlProxy.corrections.descriptionChanged.connect(qmlProxy.project.setNeedSaveToTrue)

                qmlProxy.corrections.isCreatedChanged.connect(function() {
                    print(`Model created: ${qmlProxy.corrections.isCreated}`)
                    qmlProxy.parameters.setFittables()
                    qmlProxy.project.setNeedSaveToTrue()
                })

                qmlProxy.corrections.parameterEdited.connect(function(needSetFittables) {
                    qmlProxy.corrections.parametersEdited(needSetFittables)
                })

                qmlProxy.corrections.parametersEdited.connect(function(needSetFittables) {
                    qmlProxy.corrections.parametersChanged()
                    qmlProxy.corrections.calculateData()
                    if (needSetFittables) {
                        qmlProxy.parameters.setFittables()
                    }
                    qmlProxy.project.setNeedSaveToTrue()
                })

                // Fitting

                qmlProxy.fitting.fitFinishedChanged.connect(function() {
                    print(`Fit finished: ${qmlProxy.fitting.fitFinished}`)
                    const needSetFittables = true
                    qmlProxy.corrections.parametersEdited(needSetFittables)
                })

            }

        }

        //////////
        // Project
        //////////

        readonly property var project: QtObject {

            property bool isCreated: false
            property bool needSave: false
            property string name: 'Default project'
            property string description: 'Default project description'
            property string location: ''
            property string createdDate: ''
            property string image: Qt.resolvedUrl('../Resources/Project/Sine.svg')
            property var examples: [
                {
                    'name': 'Horizontal line',
                    'description': 'Straight line, horizontal, PicoScope 2204A',
                    'path': '../Resources/Examples/HorizontalLine/project.json'
                },
                {
                    'name': 'Slanting line 1',
                    'description': 'Straight line, positive slope, Tektronix 2430A',
                    'path': '../Resources/Examples/SlantingLine1/project.json'
                },
                {
                    'name': 'Slanting line 2',
                    'description': 'Straight line, negative slope, Siglent SDS1202X-E',
                    'path': '../Resources/Examples/SlantingLine2/project.json'
                }
            ]

            function setNeedSaveToTrue() {
                needSave = true
            }

            function create() {
                createdDate = `${new Date().toLocaleDateString()} ${new Date().toLocaleTimeString()}`
                isCreated = true
            }

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
                        'parameters': qmlProxy.corrections.parameters,
                        'yData': qmlProxy.corrections.yData
                    }
                }

                if (qmlProxy.fitting.fitFinished) {
                    project['fitting'] = {
                        'fitFinished': qmlProxy.fitting.fitFinished
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
            signal parameterEdited(bool needSetFittables)
            signal parametersEdited(bool needSetFittables)

            property bool isCreated: false
            property var description: {
                'name': 'PicoScope'
            }
            property var parameters: {
                'xMin': {
                    'value': 0.0,
                    'fittable': false,
                },
                'xMax': {
                    'value': 1.0,
                    'fittable': false,
                },
                'xStep': {
                    'value': 0.01,
                    'fittable': false,
                }
            }
            property int dataSize: 300
            property var xData: []
            property var yData: []

            function loadData() {
                const length = dataSize
                const slope = -3.0
                const yIntercept = 1.5
                xData = Array.from({ length: length }, (_, i) => i / (length - 1))
                yData = Logic.LineCalculator.pseudoMeasured(xData, slope, yIntercept)
                isCreated = true
            }            

            function emptyData() {
                xData = []
                yData = []
                isCreated = false
            }

            function editParameter(name, item, value, needSetFittables) {
                if (item === 'value') {
                    value = parseFloat(value)
                } else if (item === 'fit') {
                    if (!value) {
                        parameters[name].error = 0
                    }
                }
                if (parameters[name][item] === value) {
                    return
                }
                parameters[name][item] = value
                parameterEdited(needSetFittables)
            }
        }

        //////////////
        // Corrections
        //////////////

        readonly property var corrections: QtObject {
            signal parameterEdited(bool needSetFittables)
            signal parametersEdited(bool needSetFittables)

            property bool isCreated: false
            property var description: {
                    'name': 'Line'
            }
            property var parameters: {
                'slope': {
                    'value': 1.0,
                    'error': 0,
                    'min': -5,
                    'max': 5,
                    'unit': '',
                    'fittable': true,
                    'fit': true
                },
                'yIntercept': {
                    'value': 0.0,
                    'error': 0,
                    'min': -5,
                    'max': 5,
                    'unit': '',
                    'fittable': true,
                    'fit': true
                }
            }
            property var yData: []

            function calculateData() {
                const slope = parameters.slope.value
                const yIntercept = parameters.yIntercept.value
                const xData = qmlProxy.rawData.xData
                yData = Logic.LineCalculator.calculated(xData, slope, yIntercept)
                isCreated = true
            }

            function emptyData() {
                yData = []
                isCreated = false
            }

            function editParameter(name, item, value, needSetFittables) {
                if (item === 'value') {
                    value = parseFloat(value)
                } else if (item === 'fit') {
                    if (!value) {
                        parameters[name].error = 0
                    }
                }
                if (parameters[name][item] === value) {
                    return
                }
                parameters[name][item] = value
                parameterEdited(needSetFittables)
            }
        }

        //////////
        // Fitting
        //////////

        readonly property var fitting: QtObject {
            property bool fitFinished: false

            function fit() {
                fitFinished = false
                if (qmlProxy.corrections.parameters.slope.fit) {
                    qmlProxy.corrections.parameters.slope.value = -3.0015
                    qmlProxy.corrections.parameters.slope.error = 0.0023
                }
                if (qmlProxy.corrections.parameters.yIntercept.fit) {
                    qmlProxy.corrections.parameters.yIntercept.value = 1.4950
                    qmlProxy.corrections.parameters.yIntercept.error = 0.0045
                }
                fitFinished = true
            }
        }

        /////////////
        // Parameters
        /////////////

        readonly property var parameters: QtObject {
            property var fittables: []

            function edit(group, name, item, value) {
                const needSetFittables = false
                if (group === 'rawData') {
                    qmlProxy.rawData.editParameter(name, item, value, needSetFittables)
                } else if (group === 'corrections') {
                    qmlProxy.corrections.editParameter(name, item, value, needSetFittables)
                }
            }

            function setFittables() {
                let _fittables = []
                for (let name in qmlProxy.rawData.parameters) {
                    let param = qmlProxy.rawData.parameters[name]
                    if (param.fittable) {
                        param.group = 'rawData'
                        param.parent = qmlProxy.rawData.description.name
                        param.name = name
                        _fittables.push(param)
                    }
                }
                for (let name in qmlProxy.corrections.parameters) {
                    let param = qmlProxy.corrections.parameters[name]
                    if (param.fittable) {
                        param.group = 'corrections'
                        param.parent = qmlProxy.corrections.description.name
                        param.name = name
                        _fittables.push(param)
                    }
                }
                if (_fittables.length !== 0) {
                    /*
                    for (let i = 0; i < 10000; ++i) {
                        _fittables.push(_fittables[0])
                    }
                    */
                    fittables = _fittables
                }
            }

        }

        //////////
        // Results
        //////////

        readonly property var results: QtObject {
            property bool isCreated: false

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

        /////////
        // Status
        /////////

        readonly property var status: QtObject {
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
            property var asJson: [
                {
                    name: 'Calculations',
                    value: 'CrysPy'
                },
                {
                    name: 'Minimization',
                    value: 'lmfit'
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
