// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements

import Gui.Globals as Globals


Row {
    property int labelWidth: EaStyle.Sizes.fontPixelSize * 5
    property int comboboxWidth: (EaStyle.Sizes.sideBarContentWidth - 2*labelWidth - 3*spacing) / 2


    spacing: EaStyle.Sizes.fontPixelSize


    EaElements.Label {
        width: labelWidth
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignRight

        text: qsTr('2θ bin size')
    }

    EaElements.ComboBox {
        id: twoThetaBinWidthIndexSelector3D

        width: comboboxWidth

        //values for two_theta_bin_width_3D
        // currentIndex: 2
        // model: ['0.1°', '0.25°', '0.5°', '0.75°', '1°', '2°', '5°', '10°']
        model: ['0.5°', '1°']
        currentIndex: Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex3D

        onCurrentIndexChanged: {
            Globals.BackendWrapper.rawDataTwoThetaBinWidthIndex3D = currentIndex
            Globals.BackendWrapper.rawDataUpdateTwoThetaSliderData3D(currentIndex)
            if (Globals.BackendWrapper.rawDataResetTwoThetaSlider) {
                Globals.References.pages.rawData.sidebar.basic.groups.binning3d.twoThetaSlider.value = Globals.BackendWrapper.rawDataMinTwoThetaCenter3D
            }
        }

        Component.onCompleted: Globals.References.pages.rawData.sidebar.basic.groups.binning3d.twoThetaBinWidthIndex = twoThetaBinWidthIndexSelector3D
    }


    EaElements.Label {
        width: labelWidth
        anchors.verticalCenter: parent.verticalCenter
        horizontalAlignment: Text.AlignRight

        text: qsTr('γ bin size')
    }

    EaElements.ComboBox {
        id: gammaBinWidthIndexSelector3D

        width: comboboxWidth

        //values for gamma_bin_width_3D
        // model: ['1°', '2°', '5°', '10°']
        model: ['1°', '2°']
        currentIndex: Globals.BackendWrapper.rawDataGammaBinWidthIndex3D

        onCurrentIndexChanged: {
            Globals.BackendWrapper.rawDataGammaBinWidthIndex3D = currentIndex
            Globals.BackendWrapper.rawDataUpdateGammaBinWidth3D(currentIndex)
        }

        Component.onCompleted: Globals.References.pages.rawData.sidebar.basic.groups.binning3d.gammaBinWidthIndex = gammaBinWidthIndexSelector3D
    }
}
