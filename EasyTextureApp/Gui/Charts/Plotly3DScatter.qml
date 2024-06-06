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

    url:  Qt.resolvedUrl('../Html/RawDataView/Plotly3dScatterRaw.html')

    onDataFileChanged: {
        if (loadSucceededStatus) {
            setHTMLData()
        }
    }

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            setXAxisTitle()
            setYAxisTitle()
            setZAxisTitle()
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
        //print('INSETFILENAME: ', dataFile)
        runJavaScript(`setData3D(${JSON.stringify(dataFile)})`)
    }

}
