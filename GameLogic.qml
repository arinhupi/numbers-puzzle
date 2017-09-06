import QtQuick 2.0

Item {
    id: ntabFunc
    property var numTable: []
    property int moveCount: 0

    function initNumTable(rows, cols){
         for (var i=0;i<rows;i++) {
            numTable[i] = [];
         }         
         for (i=0; i<rows; i++){
             for (var j=0; j<cols; j++){
                 numTable[i][j] = {};
                 numTable[i][j].numValue = i*4+j+1;
                 ntab.setValue(i, j, i*4+j+1);
            }
        }
        numTable[3][3].numValue = 0; 
        ntab.setEmpty(3,3);
    }

    function shuffleNums(){
        var iarray = [], counter = 0;
        for (var i = 0; i<16; i++)
            iarray[i] = i;
        shuffleArray(iarray);

        for (i=0; i<4; i++){
            for (var j=0; j<4; j++){
                numTable[i][j] = {};
                numTable[i][j].numValue = iarray[counter];
                ntab.setValue(i, j, iarray[counter++]);
           }
        }        
    }

    function shuffleArray(array) {
        var counter = array.length;
        while (counter > 0) {            
            var index = Math.floor(Math.random() * counter);
            counter--;
            // swap last element and index
            var temp = array[counter];
            array[counter] = array[index];
            array[index] = temp;
        }
        return array;
    }

    // check if table is in correct order
    function checkTable(){
        var value = 1;
        for (var i=0; i<4; i++){
            for (var j=0; j<4; j++){
                if (numTable[i][j].numValue !== value++){
                    if (i === 3 && j === 3)
                        return true;
                    else
                        return false;
                }
            }
        }
        return true;
    }

    function randomMove(iters){
        var ecloc = {};
        var possibleMoves = [];

        for (var i=0; i<iters; i++){
            ecloc = findValue(0);
            if (ecloc.row-1 >= 0)
                possibleMoves.push({row: ecloc.row-1, col: ecloc.col});
            if (ecloc.row+1 < 4)
                possibleMoves.push({row: ecloc.row+1, col: ecloc.col});
            if (ecloc.col-1 >= 0)
                possibleMoves.push({row: ecloc.row, col: ecloc.col-1});
            if (ecloc.col+1 < 4)
                possibleMoves.push({row: ecloc.row, col: ecloc.col+1});

            //console.log("random move possibilities:" +possibleMoves.length);
            var choice = Math.floor(Math.random() * possibleMoves.length);
            moveNum(possibleMoves[choice].row, possibleMoves[choice].col, ecloc.row, ecloc.col);           
        }
        moveCount = 0;
    }

    function findValue(searchVal){
        var location = {};
        for (var i=0; i<4; i++){
            for (var j=0; j<4; j++){
                if (numTable[i][j].numValue === searchVal){
                    location.row = i;
                    location.col = j;
                    return location;
                }
            }
        }
        return {row: -1, col: -1};
    }

    function handleMouse(row, col){
        //console.log("mouse clicked at " + row + "," + col);

        if (makeMoveDown(row, col) || makeMoveUp(row, col) || makeMoveRight(row, col) || makeMoveLeft(row, col)) {
            if (checkTable() === true){
                //console.log("table ready!");
                gameReadyInfo.visible = true;
                gameReadyInfo.startReadyTimer();
            }
        }
    }


    function makeMoveUp(row, col){
        var found = false;
        for (var i = 0; i < row; i++){
            if (numTable[i][col].numValue === 0){
                found = true;
                break;
             }
        }
        if (found === true){
            for (var j = i+1; j <= row; j++)
                moveNum(j, col, j-1, col);
            return true;
        }
        return false;
    }

    function makeMoveDown(row, col){
        var found = false;
        for (var i = row; i < 3 ; i++){
            if (numTable[i+1][col].numValue === 0){
                found = true;
                break;
            }
        }
        if (found === true){
            for (var j = i; j >= row; j--)
                moveNum(j, col, j+1, col);
            return true;
        }
        return false;
    }

    function makeMoveLeft(row, col){
        var found = false;
        for (var i = 0; i < col ; i++){
            if (numTable[row][i].numValue === 0){
                found = true;
                break;
            }
        }
        if (found === true){
            for (var j = i+1; j <= col; j++)
                moveNum(row, j, row, j-1);
            return true;
        }
        return false;
    }

    function makeMoveRight(row, col){
        var found = false;
        for (var i = col; i < 3 ; i++){
            if (numTable[row][i+1].numValue === 0){
                found = true;
                break;
            }
        }
        if (found === true){
            for (var j = i; j >= col; j--)
                moveNum(row, j, row, j+1);
            return true;
        }
        return false;
    }

    function moveNum(row, col, newRow, newCol){
        var oldVal = numTable[row][col].numValue;
        numTable[row][col].numValue = 0;
        numTable[newRow][newCol].numValue = oldVal;        
        ntab.setValue(newRow, newCol, oldVal);
        ntab.setEmpty(row, col);
        moveCount ++;
    }

}

