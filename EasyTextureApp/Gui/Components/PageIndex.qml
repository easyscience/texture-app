pragma Singleton

import QtQuick


// substitution for AppBarIndexEnum defined in
// \EasyApp\EasyApp\Gui\Globals\Variables.qml
//
// why? EasyTextureApp has more pages than
//      those defined in the location above


QtObject {

    enum PageIndexEnum {
        HomePageIndex = 0,
        ProjectPageIndex = 1,
        SamplePageIndex = 2,
        RawDataPageIndex = 3,
        ExplorePageIndex = 4,
        ResultsPageIndex = 5,
        SeparatorPageIndex = 6,
        LiveViewPageIndex = 7
    }

}
