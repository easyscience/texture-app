// SPDX-FileCopyrightText: 2022 easyDiffraction contributors <support@easydiffraction.org>
// SPDX-License-Identifier: BSD-3-Clause
// © 2021-2022 Contributors to the easyDiffraction project <https://github.com/easyScience/easyDiffractionApp>

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import EasyApp.Gui.Globals as EaGlobals
import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents
import EasyApp.Gui.Logic as EaLogic

import Gui.Globals as Globals


Column {
    spacing: EaStyle.Sizes.fontPixelSize

    // Table

    EaComponents.TableView {
        id: myTableView

        defaultInfoText: qsTr("No measurements loaded")

        // Table model

        model: EaComponents.JsonListModel {
            json: Globals.Proxies.main.rawData.isCreated ?
                      JSON.stringify([Globals.Proxies.main.rawData.rawFiles]) :
                      ""
            query: "$[*]"
        }

        // Table rows

        delegate: EaComponents.TableViewDelegate {

            EaComponents.TableViewLabel {
                width: EaStyle.Sizes.fontPixelSize * 2.5
                headerText: qsTr("No.")
                text: model.index + 1
            }

            EaComponents.TableViewLabelControl {
                id: tableViewLine
                horizontalAlignment: Text.AlignLeft
                width: EaStyle.Sizes.fontPixelSize * 29
                headerText: qsTr("Name")
                text: model.name
                ToolTip.visible: EaGlobals.Vars.showToolTips && text !== "" && tableViewLine.hovered
                ToolTip.text: model.fullpath
            }

            /*EaComponents.TableViewLabel {
                headerText: qsTr("Color")
                backgroundColor: EaStyle.Colors.chartForegrounds[0]
            }
            */

            EaComponents.TableViewButton {
                id: deleteRowColumn
                headerText: qsTr("Del.")
                fontIcon: "minus-circle"
                ToolTip.text: qsTr("Remove this model")
                onClicked: {
                    Globals.Proxies.main.rawData.isCreated = false
                    var idx = myTableView.currentIndex
                    Globals.Proxies.main.rawData.rawFiles.splice(idx, 1)
                    console.debug("Current TableView row deleted by index: " + idx)

                    Globals.Proxies.main.rawData.isCreated = (Globals.Proxies.main.rawData.rawFiles.length > 0)
                    if (!Globals.Proxies.main.rawData.isCreated){
                        Globals.Proxies.main.rawData.selectedFileName = ''
                    }
                    //Globals.Proxies.main.corrections.emptyData()
                    //Globals.Vars.rawDataPageEnabled = false
                    //Globals.Vars.explorePageEnabled = false
                    //Globals.Vars.resultsPageEnabled = false

                }



            }

        }

    }

    // Control buttons below table

    Row {
        spacing: EaStyle.Sizes.fontPixelSize

        EaElements.SideBarButton {
            wide: true
            enabled: true //false //!Globals.Proxies.main.corrections.isCreated
            fontIcon: "upload"
            text: qsTr("Load measurement file")
            onClicked: {
                measurementFileDialog.open()
            }

            Component.onCompleted: {
                Globals.Refs.app.rawDataPage.importDataFromLocalDriveButton = this
            }

        }


    }

    function getFilename(str)
    {
        return (str.slice(str.lastIndexOf("/")+1))
    }

    // Select File dialog
    FileDialog {
        id: measurementFileDialog
        fileMode: FileDialog.OpenFile
        nameFilters: [ "JSON files (*.json)"]
        title: qsTr("Choose Measurement File")

        onAccepted: {
            Globals.Proxies.main.rawData.isMmtFileAssigned = true
            Globals.Proxies.main.rawData.isCreated = false //trigger refresh

            Globals.Proxies.main.project.needSave = true

            Globals.Proxies.main.rawData.rawFiles.push({
                "name": getFilename(selectedFile.toString()),
                "fullpath": selectedFile.toString()
            })

            Globals.Proxies.main.rawData.selectedRawFile = selectedFile.toString()
            Globals.Proxies.main.rawData.selectedFileName = getFilename(selectedFile.toString())

            Globals.Proxies.main.rawData.isCreated = true //trigger refresh

            Globals.Proxies.main.rawData.loadOneTwoThreeD()
            //Globals.Proxies.main.rawData.loadData()
        }

        onRejected: {
            Globals.Proxies.main.rawData.isMmtFileAssigned = false
            Globals.Proxies.main.rawData.isCreated = false
        }
    }
}
