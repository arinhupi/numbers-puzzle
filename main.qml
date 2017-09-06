import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0


ApplicationWindow {
    id: appWindow
    visible: true
    width: 400
    height: 500
    maximumWidth: 400
    maximumHeight: 500
    minimumWidth: 400
    minimumHeight: 500

    title: qsTr("NumberPuzzle")
    color: "#66dd99"

    GameLogic {
        id: ntabFunc
    }

    GameStartView {
        id: startInfo       
    }

    NumberTable {
        id: ntab
        visible: false
    }

    GameReadyInfo {
        id: gameReadyInfo
        visible: false
    }

    Component.onCompleted: {
        ntabFunc.initNumTable(4, 4);
    }

}
