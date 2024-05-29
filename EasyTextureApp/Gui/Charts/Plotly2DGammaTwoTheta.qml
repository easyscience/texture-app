import QtQuick
import QtQuick.Controls
import QtWebEngine

import EasyApp.Gui.Style as EaStyle

import Gui.Globals as Globals

WebEngineView {
    id: chartView

    visible: false

    property bool loadSucceededStatus: false

    property string xAxisTitle: ''
    property string yAxisTitle: ''
    property string dataFile: qsTr(Globals.Proxies.main.rawData.selectedRawFile)

    property int theme: EaStyle.Colors.theme
    property bool useWebGL: false


    width: parent.width
    height: parent.height

    backgroundColor: EaStyle.Colors.chartBackground

    url:  Qt.resolvedUrl('../Html/RawDataView/Plotly2dGammaTwoThetaRaw.html')

    onDataFileChanged: {
        setHTMLData()
    }

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            setXAxisTitle()
            setYAxisTitle()
            setHTMLData()
            visible = true
        }
    }

    onLoadingChanged: (loadRequest) => {
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

    onThemeChanged: {
        if (loadSucceededStatus) {
            setChartColors()
            redrawPlot()
        }
    }

    onUseWebGLChanged: {
        if (loadSucceededStatus) {
            toggleUseWebGL()
        }
    }

    // Logic
    function setChartColors() {
        //print('setChartColors is started')
        const colors = {
            'chartBackground': String(EaStyle.Colors.chartBackground),
            'chartPlotAreaBackground': String(EaStyle.Colors.chartPlotAreaBackground),
            'chartForeground': String(EaStyle.Colors.chartForeground),

            'chartAxis': String(EaStyle.Colors.chartAxis),
            'chartGrid': String(EaStyle.Colors.chartGridLine),

            'measuredScatter': EaStyle.Colors.chartForegroundsExtra[2],
            'measuredLine': EaStyle.Colors.chartForegroundsExtra[2],
            'calculatedLine': EaStyle.Colors.chartForegrounds[0]
        }
        runJavaScript(`setChartColors(${JSON.stringify(colors)})`,
                      function(result) { print(result) })
    }

    function toggleUseWebGL() {
        //print(`toggleUseWebGL is started: '${useWebGL}'`)
        runJavaScript(`toggleUseWebGL(${JSON.stringify(useWebGL)})`,
                      function(result) { print(result) })
    }

    function redrawPlot() {
        chartView.runJavaScript(`redrawPlot()`)
    }

    function setXAxisTitle() {
        runJavaScript(`setXAxisTitle(${JSON.stringify(xAxisTitle)})`)
    }

    function setYAxisTitle() {
        runJavaScript(`setYAxisTitle(${JSON.stringify(yAxisTitle)})`)
    }

    function setHTMLData() {
        //print('INSETFILENAME: ', dataFile)
        runJavaScript(`set2dGamaTwoThetaData(${JSON.stringify(dataFile)})`)
    }
}
