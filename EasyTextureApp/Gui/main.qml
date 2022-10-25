// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15

import Gui.Globals 1.0 as ExGlobals
import Gui.Components 1.0 as ExComponents


ExComponents.ApplicationWindow {
    id: window

    appName: ExGlobals.Constants.appName
    appVersion: ExGlobals.Constants.appVersion
    appDate: ExGlobals.Constants.appDate
}
