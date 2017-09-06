import QtQuick 2.0

Rectangle {
    id: readyInfo
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter    
    width: 300; height: 200
    color: "blue"
    border.color: "black"

    function startReadyTimer(){ readyTimer.start()}

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
        font.pixelSize: 20
        text: qsTr("READY!\n" +
                   "You solved it in " + ntabFunc.moveCount + " moves.\n" +
                   "Click shuffle to play again.")
    }
    Timer {
        id: readyTimer
        interval: 3000
        onTriggered: {
            readyInfo.visible = false;
            ntabFunc.moveCount = 0;
        }
    }
}

