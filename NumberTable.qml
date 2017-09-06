import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    width: parent.width
    height: parent.height
    color: "#66dd99"

    function setValue(row, col, value){
        var repIndex = row * 4 + col;
        rep.itemAt(repIndex).ntValue = value;
        rep.itemAt(repIndex).color = getColor(value);
        rep.itemAt(repIndex).visible = true;
    }

    function setEmpty(row, col){
        var repIndex = row * 4 + col;
        rep.itemAt(repIndex).ntValue = 0;
        rep.itemAt(repIndex).color = "black";
    }

    function getColor(numValue){
        if (numValue === 0)
            return "black";
        if (numBetween(numValue, 1,4) || numBetween(numValue, 9, 12))
            return (numValue % 2 == 0) ? "red" : "white";
        else
            return (numValue % 2 == 0) ? "white" : "red";
    }

    function numBetween(val, valMin, valMax){
        if (val >= valMin && val <= valMax)
            return true;
        else
            return false;
    }

    Grid {
        id: grid
        anchors.horizontalCenter: parent.horizontalCenter
        y: 50
        rows: 4; columns: 4; spacing: 5

        Repeater {
            id: rep
             model: 16
             Rectangle {
                 id: rec
                 property alias ntValue: numtext.text                 
                  width: 70; height: 70
                  color: "lightgreen"
                  Text {
                      id: numtext
                      text: "0"
                      font.pointSize: 30
                      anchors.centerIn: parent
                  }
                  MouseArea {
                        anchors.fill: parent
                        onClicked: { ntabFunc.handleMouse(Math.floor(index/4), index%4); }
                  }
              }
          }
    }

    Button {
        id: shuffleButton
        anchors.left: grid.left
        y: 400
        text: "shuffle"
        onClicked: ntabFunc.shuffleNums();
    }

    Button {
        anchors.right: grid.right        
        y: 400
        text: "exit"
        onClicked: appWindow.close();
    }
}
