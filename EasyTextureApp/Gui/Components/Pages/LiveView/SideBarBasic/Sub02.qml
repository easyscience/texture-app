// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals



Grid {
     columns: 2
     columnSpacing: EaStyle.Sizes.fontPixelSize


     Column {
         //Grid
         Grid {
             readonly property int commonSpacing: EaStyle.Sizes.fontPixelSize * 1.5

             columns: 2
             rowSpacing: 0
             columnSpacing: commonSpacing


             EaElements.Label {
                 text: qsTr("Current File Size:")
             }
             EaElements.Label {
                 text: "xxx"
             }

             EaElements.Label {
                 text: qsTr("Current Number of Events:")
             }
             EaElements.Label {
                 text: "xxx"
             }


             EaElements.Label {
                 text: qsTr("Average Count per Detector Voxel:")
             }
             EaElements.Label {
                 text: "xxx"
             }

         } // Grid


     }


 }

