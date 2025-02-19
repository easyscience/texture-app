import QtQuick
import QtQuick.Controls
import QtWebEngine

import Gui.Globals as Globals

WebEngineView {
    id: chartView

    property bool loadSucceededStatus: false
    property string xAxisTitle: ''
    property string yAxisTitle: ''
    property string zAxisTitle: ''
    property string dataFile: ''

    width: parent.width
    height: parent.height

    url: Qt.resolvedUrl('../Html/RawDataView/Plotly3dSurfaceRaw.html')

    property int currentFile3DIndex: 0
    property var files3D: [
        Qt.resolvedUrl("./../../Examples/BioSample_POWTEX@MLZ/LiveDataView/user_voxels_3D_live_1.json"),
        Qt.resolvedUrl("./../../Examples/BioSample_POWTEX@MLZ/LiveDataView/user_voxels_3D_live_2.json"),
        Qt.resolvedUrl("./../../Examples/BioSample_POWTEX@MLZ/LiveDataView/user_voxels_3D_live_3.json")
    ]

    Timer {
        id: switchTimer3D
        interval: 3000  // 3 seconds
        repeat: true
        running: Globals.Proxies.main.liveView.isLiveViewSelected && Globals.Proxies.main.liveView.is3DTabSelected
        onTriggered: {
            chartView.dataFile = next3DFile()
        }
    }

    onDataFileChanged: {
        if (loadSucceededStatus) {
            setHTMLData()
        }
    }

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            //setXAxisTitle()
            //setYAxisTitle()
            //setZAxisTitle()
            //redrawPlot()
            //setHTMLData()
        }
    }

    onLoadingChanged:  (loadRequest) => {
       loadSucceededStatus = false
       if (loadRequest.status === WebEngineView.LoadSucceededStatus) {
            loadSucceededStatus = true
       }
    }

    onXAxisTitleChanged: {
        if (loadSucceededStatus) {
            setXAxisTitle()
            redrawPlot()
        }
    }

    onYAxisTitleChanged: {
        if (loadSucceededStatus) {
            setYAxisTitle()
            redrawPlot()
        }
    }

    onZAxisTitleChanged: {
        if (loadSucceededStatus) {
            setZAxisTitle()
            redrawPlot()
        }
    }

    // Logic

    function redrawPlot() {
        chartView.runJavaScript(`redrawPlot()`)
    }

    function setXAxisTitle() {
        runJavaScript(`setXAxisTitle(${JSON.stringify(xAxisTitle)})`)
    }

    function setYAxisTitle() {
        runJavaScript(`setYAxisTitle(${JSON.stringify(yAxisTitle)})`)
    }

    function setZAxisTitle() {
        runJavaScript(`setZAxisTitle(${JSON.stringify(zAxisTitle)})`)
    }

    function setHTMLData() {
        //print('IN setHTMLData 3DSurface: ', dataFile)
        runJavaScript(`setData3DSurface(${JSON.stringify(dataFile)})`)
    }

    function next3DFile() {
        currentFile3DIndex = (currentFile3DIndex + 1) % files3D.length
        return files3D[currentFile3DIndex]
    }

}
