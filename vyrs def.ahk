goToAltar(){
    Random, x ,45 , 113
    Random, y , 395, 489
    MouseMove, x, y 
    Random, RandomDelay1, 1000, 10000
    Sleep, RandomDelay1
    Click
    Random, RandomDelay, 4500, 6000
    Sleep, RandomDelay
}

moveToBlueSquare(){
    PixelSearch, blueSquareX, blueSquareY, 0, 0, 1280, 1024, 0x000AFF, 0, Fast RGB
    If (ErrorLevel = 0)
    {
        Random, posX , 7, 17,5
        Random, posY , 7, 18,5
        new3X := blueSquareX + posX
        new3Y := blueSquareY + posY
        MouseMove, new3X, new3Y
        Sleep, 200
        Click
        Sleep, 5000
    }
}

dropCheck(){
    state := 0
    Loop
    {
        If (state = 1){
            ;si encuentro otro bloodshard o no lo agarre
            PixelSearch, out1x, out1y, 0, 0, 1280, 1024, 0xCD528F, 2, Fast RGB
            If (ErrorLevel = 0)
            {
                state := 0
            } Else{
                PixelSearch, out2x, out2y, 0, 0, 1280, 1024, 0x528FCD, 3, Fast RGB
                If (ErrorLevel = 0)
                {
                    state := 0
                } Else{
                    moveToBlueSquare()
                    Break
                }
            }

        }
        ;BLOODSHARD
        PixelSearch, bloodShardX, bloodShardY, 0, 0, 1280, 1024, 0xCD528F, 2, Fast RGB
        If (ErrorLevel = 0)
        {
            Sleep, 1000
            Random, itemPick1X , 7, 20,5
            Random, itemPick1Y , 7, 21,5
            new1X := bloodShardX + itemPick1X
            new1Y := bloodShardY + itemPick1Y
            ;MUEVO EL MOUSE AL CENTRO DEL SQUARE
            MouseMove, new1X, new1Y
            Sleep, 300
            Click
            Sleep, 3000
            state := 1
        } 
        ;BLUE DROPS
        PixelSearch, blueDropX, blueDropY, 0, 0, 1280, 1024, 0x528FCD, 3, Fast RGB
        If (ErrorLevel = 0)
        {
            Sleep, 1000
            Random, itemPick2X , 7, 17,5
            Random, itemPick2Y , 7, 18,5
            new2X := blueDropX + itemPick2X
            new2Y := blueDropY + itemPick2Y
            MouseMove, new2X, new2Y
            Click
            Sleep, 3000
            state := 1
        }

    }
}

F1::
    ;check prayer level
    Loop{
        Loop
        {
            ;checkeo si hay prayer
            PixelSearch, FoundX, FoundY, 0, 0, 565, 423, 0x35E4A7, 0, Fast RGB
            If (ErrorLevel = 0)
            {
                PixelSearch, test1X, test1Y, 0, 0, 1280, 1024, 0xCD528F, 2, Fast RGB
                If (ErrorLevel = 0)
                {
                    dropCheck()
                }
                PixelSearch, test2X, test2Y, 0, 0, 1280, 1024, 0x528FCD, 3, Fast RGB
                If (ErrorLevel = 0)
                {
                    dropCheck()
                }
            } Else{
                Random, breakSleep, 100, 1500
                Sleep, breakSleep
                Break
            }
            Random, OutputVar , 500, 2200
            Sleep, OutputVar
        }
        ;si la puerta está cerrada
        PixelSearch, FoundX, FoundY, 0, 0, 1280, 1024, 0x8E1900, 0, Fast RGB
        If (ErrorLevel = 0)
        {
            Random, doorX, 1, 17
            Random, doorY, 1, 38
            newFoundX := FoundX + doorX
            newFoundY := FoundY + doorY
            MouseMove, newFoundX ,newFoundY 
            Click
            Random, RandomDelay2, 2000, 3000
            Sleep, RandomDelay2
        } Else{
            ;sino esta cerrada voy directo
            goToAltar()
            moveToBlueSquare()
        }
        ;go to altas if was closed previuosly
    }

F2::
    Reload
Return
