import QtQuick
import QtQuick.Controls
import QtWebEngine

import Gui.Globals as Globals

WebEngineView {
    id: chartView

    property bool loadSucceededStatus: false
    property string xAxisTitle: ''
    property string yAxisTitle: ''
    property string dataFile: ''

    property real sliderValue

    width: parent.width
    height: parent.height

    url:  Qt.resolvedUrl('../Html/RawDataView/Plotly2dTwoThetaRingsRaw.html')

    property int currentFile2DIndex: 0
    property var files2D: [Qt.resolvedUrl("./../Data/LiveDataView/user_voxels_2D_live_1.json"), Qt.resolvedUrl("./../Data/LiveDataView/user_voxels_2D_live_2.json"), Qt.resolvedUrl("./../Data/LiveDataView/user_voxels_2D_live_3.json")]

    Timer {
        id: switchTimer2D
        interval: 3000  // 3 seconds
        repeat: true
        running: Globals.Proxies.main.liveView.isLiveViewSelected && !Globals.Proxies.main.liveView.is3DTabSelected
        onTriggered: {
            chartView.dataFile = next2DFile()
        }
    }

    onDataFileChanged: {
        if (loadSucceededStatus) {
            setHTMLData()
        }
    }

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            setXAxisTitle()
            setYAxisTitle()
            //redrawPlot()
            setHTMLData()
        }
    }

    onLoadingChanged:  (loadRequest) => {
       loadSucceededStatus = false
       if (loadRequest.status === WebEngineView.LoadSucceededStatus) {
           loadSucceededStatus = true
       }
    }

    onSliderValueChanged: {
        if (loadSucceededStatus) {
            redrawFrame()
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

    function getMinTT() {
        chartView.runJavaScript(`getMinTT()`)
    }

    function redrawFrame() {
        //print(`redrawFrame is started: `)
        runJavaScript(`redrawFrame(${JSON.stringify(sliderValue)})`)
    }

    function setHTMLData() {
        print('INSETFILENAME: ', dataFile)
        runJavaScript(`set2dThetaRingsData(${JSON.stringify(dataFile)})`)
    }

    function next2DFile() {
        currentFile2DIndex = (currentFile2DIndex + 1) % files2D.length
        return files2D[currentFile2DIndex]
    }
}
