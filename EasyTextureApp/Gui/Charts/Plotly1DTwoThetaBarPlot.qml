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
    property string dataFile: ''

    property var xData: []
    property real sliderValue
    //property real numberOfSlices

    property int theme: EaStyle.Colors.theme

    property bool useWebGL: false

    width: parent.width
    height: parent.height

    backgroundColor: EaStyle.Colors.chartBackground

    url: Qt.resolvedUrl("../Html/ResultsView/Plotly1dTwoThetaBarPlot.html")

    onDataFileChanged: {
        if (loadSucceededStatus) {
            setHTMLData()
        }
    }

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            //toggleUseWebGL()
            //setChartSizes()
            //setChartColors()

            setXAxisTitle()
            setYAxisTitle()
            redrawPlot()
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

    onXDataChanged: {
        if (loadSucceededStatus) {
            setXData()
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

    function setChartSizes() {
        //print('setChartSizes is started')
        const sizes = {
            'fontPixelSize': EaStyle.Sizes.fontPixelSize,
            'measuredLineWidth': EaStyle.Sizes.measuredLineWidth,
            'calculatedLineWidth': EaStyle.Sizes.calculatedLineWidth,
            'measuredScatterSize': EaStyle.Sizes.measuredScatterSize
        }
        runJavaScript(`setChartSizes(${JSON.stringify(sizes)})`,
                      function(result) { print(result) })
    }

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

    function redrawPlot() {
        runJavaScript(`redrawPlot()`)
    }

    function toggleUseWebGL() {
        //print(`toggleUseWebGL is started: '${useWebGL}'`)
        runJavaScript(`toggleUseWebGL(${JSON.stringify(useWebGL)})`,
                      function(result) { print(result) })
    }

    function setXAxisTitle() {
        //print(`setXAxisTitle is started: '${xAxisTitle}'`)
        runJavaScript(`setXAxisTitle(${JSON.stringify(xAxisTitle)})`)
    }

    function setYAxisTitle() {
        //print(`setYAxisTitle is started: '${yAxisTitle}'`)
        runJavaScript(`setYAxisTitle(${JSON.stringify(yAxisTitle)})`)
    }

    function emptyData() {
        print(`emptyData HERE is started`)
        runJavaScript(`emptyData()`)
        print('FINISHED')
        /*
        runJavaScript(`emptyData()`,
                      function(result) { print(result) })*/
    }

    function setXData() {
        //print(`setXData is started: ${xData.length} points`)
        runJavaScript(`setXData(${JSON.stringify(xData)})`,
                      function(result) { print(result) })
    }

    function redrawFrame() {
        //print(`redrawFrame is started: `)
        runJavaScript(`redrawFrame(${JSON.stringify(sliderValue)})`)
    }

    function setHTMLData() {
        //print('INSETFILENAME: ', dataFile)
        runJavaScript(`setData(${JSON.stringify(dataFile)})`)
    }
/*
    function setMeasuredYData() {
        //print(`setMeasuredYData is started: ${measuredYData.length} points`)
        runJavaScript(`setMeasuredYData(${JSON.stringify(measuredYData)})`)
    }

    function setCalculatedYData() {
        runJavaScript(`setCalculatedYData(${JSON.stringify(calculatedYData)})`)
    }
*/
}
