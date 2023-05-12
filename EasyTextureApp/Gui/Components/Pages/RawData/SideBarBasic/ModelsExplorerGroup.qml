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

        defaultInfoText: qsTr("No measurements loaded")

        // Table model

        model: EaComponents.JsonListModel {
            json: Globals.Proxies.main.corrections.isCreated ?
                      JSON.stringify([Globals.Proxies.main.corrections.description]) :
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

            EaComponents.TableViewTextInput {
                horizontalAlignment: Text.AlignLeft
                width: EaStyle.Sizes.fontPixelSize * 27.9
                headerText: qsTr("Name")
                text: model.name
            }

            EaComponents.TableViewLabel {
                headerText: qsTr("Color")
                backgroundColor: EaStyle.Colors.chartForegrounds[0]
            }

            EaComponents.TableViewButton {
                id: deleteRowColumn
                headerText: qsTr("Del.")
                fontIcon: "minus-circle"
                ToolTip.text: qsTr("Remove this model")
                onClicked: {
                    Globals.Proxies.main.rawData.emptyData()
                    Globals.Proxies.main.corrections.emptyData()
                    Globals.Vars.rawDataPageEnabled = false
                    Globals.Vars.explorePageEnabled = false
                    Globals.Vars.resultsPageEnabled = false
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
            onClicked: measurementFileDialog.open() //onClicked: Globals.Proxies.main.corrections.calculateData()
            Component.onCompleted: Globals.Refs.app.correctionsPage.addNewModelManuallyButton = this
        }
    }


    // Select File dialog
    FileDialog {
        id: measurementFileDialog
        title: qsTr("Choose Measurement File")
    }
}
