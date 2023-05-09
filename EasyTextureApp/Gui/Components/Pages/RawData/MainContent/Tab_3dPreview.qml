// SPDX-FileCopyrightText: 2022 EasyTexture contributors
// SPDX-License-Identifier: BSD-3-Clause
// © 2022 Contributors to the EasyTexture project <https://github.com/EasyScience/EasyTextureApp>

import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    anchors.fill: parent

    Image {
        anchors.fill: parent
        anchors.margins: 20
        fillMode: Image.PreserveAspectFit
        source: "biosample.3d_projection.home.png"
    }

}
