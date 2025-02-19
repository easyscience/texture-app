// SPDX-FileCopyrightText: 2022 EasyExample contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyExample project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick
import QtQuick.Controls

import EasyApp.Gui.Style as EaStyle
import EasyApp.Gui.Elements as EaElements
import EasyApp.Gui.Components as EaComponents

import Gui.Globals as Globals



// Connect button
EaElements.SideBarButton {
    wide: true
    fontIcon: "network-wired" // "handshake"  "network-wired"  "satellite-dish"   "lock"/"unlock"
    text: qsTr("Connect")

    onClicked: {}
    Component.onCompleted: {}
}

