// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

import Backends.MockQml as MockLogic


QtObject {

    property var project: MockLogic.Project
    property var rawData: MockLogic.RawData
    property var corrections: MockLogic.Corrections
    property var explore: MockLogic.Explore
    property var results: MockLogic.Results
    property var status: MockLogic.Status

}


