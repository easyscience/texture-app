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
        //print('INSETFILENAME: ', dataFile)
        runJavaScript(`set2dThetaRingsData(${JSON.stringify(dataFile)})`)
    }

}
