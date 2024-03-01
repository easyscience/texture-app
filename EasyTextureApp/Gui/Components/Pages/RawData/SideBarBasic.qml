// SPDX-FileCopyrightText: 2023 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2023 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick

import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals


EaComponents.SideBarColumn {

    // from EasyAppExample:
    EaElements.GroupBox {
        title: qsTr("Measurement File")
        collapsible: false
        last: !Globals.Proxies.main.corrections.isCreated

        Loader { source: 'SideBarBasic/MeasurementsExplorerGroup.qml' }
    }

    EaElements.GroupBox {
        title: qsTr("3D Binning Parameters")
        collapsible: false
        visible: Globals.Proxies.main.rawData.is3DtabSelected && Globals.Proxies.main.rawData.isCreated

        Loader { source: 'SideBarBasic/Binning3D.qml' }
    }

    EaElements.GroupBox {
        title: qsTr("2D Binning Parameters")
        collapsible: false
        visible: Globals.Proxies.main.rawData.is2DtabSelected && Globals.Proxies.main.rawData.isCreated

        Loader { source: 'SideBarBasic/Binning2D.qml' }
    }

    EaElements.GroupBox {
        title: qsTr("1D Binning Parameters")
        collapsible: false
        visible: Globals.Proxies.main.rawData.is1DtabSelected && Globals.Proxies.main.rawData.isCreated

        Loader { source: 'SideBarBasic/Binning1D.qml' }
    }
}
