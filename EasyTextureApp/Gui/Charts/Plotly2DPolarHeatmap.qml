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

    url:  Qt.resolvedUrl('../Html/RawDataView/Plotly2dPolarHeatmap.html')

    property int currentFile2DIndex: 0
    property var files2D: [
        Qt.resolvedUrl("./../../Examples/BioSample_POWTEX@MLZ/LiveDataView/user_voxels_2D_live_1.json"),
        Qt.resolvedUrl("./../../Examples/BioSample_POWTEX@MLZ/LiveDataView/user_voxels_2D_live_2.json"),
        Qt.resolvedUrl("./../../Examples/BioSample_POWTEX@MLZ/LiveDataView/user_voxels_2D_live_3.json")
    ]

    // Is activated only for LiveView
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
            if (Globals.Vars.explorePageEnabled){
                setExploreRingStat()
                setExploreTotalStat()
            }
        }
    }

    onLoadSucceededStatusChanged: {
        if (loadSucceededStatus) {
            if (Globals.Vars.explorePageEnabled){
                setExploreRingStat()
                setExploreTotalStat()
            }
            //setXAxisTitle()
            //setYAxisTitle()
            //redrawPlot()
            //setHTMLData()
            //setExploreTotalStat()
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
            if (Globals.Vars.explorePageEnabled){
                setExploreRingStat()
            }
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

    function redrawFrame() {
        //print(`redrawFrame is started: `)
        runJavaScript(`redrawFrame(${JSON.stringify(sliderValue)})`)
    }

    function setHTMLData() {
        print('IN setHTMLData 2D PolarHeatmap: ', dataFile)
        runJavaScript(`set2dPolarHeatmap(${JSON.stringify(dataFile)})`)
    }

    function setExploreTotalStat() {
        runJavaScript(`getStatisticsWholeDataset(${JSON.stringify(dataFile)})`,
            function(result) {
                Globals.Proxies.main.explore.totalCountMin = result.min
                Globals.Proxies.main.explore.totalCountMax = result.max
                Globals.Proxies.main.explore.totalCountSum = result.sum
            }
        )
    }

    function setExploreRingStat() {
        runJavaScript(`getStatisticsCurrentRing(${JSON.stringify(dataFile)}, ${JSON.stringify(sliderValue)})`,
            function(result) {
                Globals.Proxies.main.explore.twoThetaRingCountMin = result.min
                Globals.Proxies.main.explore.twoThetaRingCountMax = result.max
                Globals.Proxies.main.explore.twoThetaRingCountSum = result.sum
            }
        )
    }

    function next2DFile() {
        currentFile2DIndex = (currentFile2DIndex + 1) % files2D.length
        return files2D[currentFile2DIndex]
    }
}
