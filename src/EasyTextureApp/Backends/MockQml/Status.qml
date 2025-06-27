// SPDX-FileCopyrightText: 2024 EasyApp contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2024 Contributors to the EasyApp project <https://github.com/easyscience/EasyApp>

pragma Singleton

import QtQuick

QtObject {

    property string project: 'Undefined'
    property string rawDataFile: 'Undefined'
    property string gammaSliceWidth: 'None'

    property bool projectVisible: false
    property bool rawDataFileVisible: false
    property bool gammaSliceWidthVisible: false
}
