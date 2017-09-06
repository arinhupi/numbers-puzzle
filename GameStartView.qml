import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle {
    id: startView
    width: parent.width; height: parent.height
    color: "#99bb99"    
    visible: true

    Image {
        id: img1
        source: "/images/numbers.png"
        width: 100; height: 100
        anchors.horizontalCenter: parent.horizontalCenter; y: 100

        ScaleAnimator {
               target: img1;
               from: 0.3;
               to: 1.5;
               duration: 1500
               running: true
           }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
        font.pixelSize: 20
        text: qsTr("Ready to start?")
    }

    Button {
        id: startButton
        anchors.horizontalCenter: parent.horizontalCenter
        y: 350
        text: "Yes please"
        onClicked: {  startButton.visible = false; opAnim1.start(); startTimer.start();}
    }

    OpacityAnimator {
            id: opAnim1
            target: startView;
            from: 1; to: 0;
            duration: 1500
            running: false
    }

    Timer {
        id: startTimer
        interval: 1500
        onTriggered: {parent.visible = false; ntab.visible = true;}
    }
}
