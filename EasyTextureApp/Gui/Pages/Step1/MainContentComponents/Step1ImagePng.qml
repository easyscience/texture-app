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
        source: "Image1.png"
    }

    Label {
        anchors.centerIn: parent
        font.pixelSize: 150
        color: "orange"
        opacity: 0.3
        text: "screenshot"
    }
}
