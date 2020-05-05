'******************************
'*   MICRO E-FOREST for PC-98 *
'*   EL_BASICà⁄êAî≈           *
'******************************

'History
'ver 0.1 2020.2.24 PC-98 EL_BASICà⁄êAî≈çÏê¨äJén
'ver 0.2 2020.5.5  Add Pallet configuration 

'***********
' Variables
'***********

INTEGER size

INTEGER c_block(256)
INTEGER c_tree(256)
INTEGER c_player11(256)
INTEGER c_player12(256)
INTEGER c_erase(256)
INTEGER c_enemy11(256)
INTEGER c_enemy12(256)
INTEGER c_enemy21(256)
INTEGER c_enemy22(256)

INTEGER c_buf(256)

INTEGER tree_x, tree_y

INTEGER pX, pY
INTEGER ppX, ppY

INTEGER pakX, pakY

INTEGER pH
INTEGER mxpH

INTEGER eX(8), eY(8)
INTEGER eX_buf, eY_buf
INTEGER peX, peY

INTEGER eakS
INTEGER eakX(8), eakY(8)
INTEGER peakX, peakY

INTEGER eH(8)
INTEGER mxeH(8)
INTEGER ept1, ept2, ept3, ept4

STRING pK

INTEGER i

'************************
' Subroutine Protoptypes
'************************

SUBDEF createchar1(CONST INTEGER x1, CONST INTEGER y1, CONST INTEGER size)
SUBDEF getchar1(CONST INTEGER x1, CONST INTEGER y1, CONST INTEGER x2, CONST INTEGER y2)
SUBDEF calcpXY(REFERENCE STRING pK, REFERENCE INTEGER pX, REFERENCE INTEGER pY, REFERENCE INTEGER pakX, REFERENCE INTEGER pakY)
SUBDEF calceXY(CONST INTEGER pX, CONST INTEGER pY, REFERENCE INTEGER eX, REFERENCE INTEGER eY)

SUBDEF set6A(CONST INTEGER dat)
SUBDEF setApal(CONST INTEGER palN, CONST INTEGER R, CONST INTEGER G, CONST INTEGER B)

'************
' Initialize
'************

pX = 200
pY = 100
pakX = pX + 16
pakY = pY
pH = 30
mxpH = 30

eX(0) = 280
eY(0) = 100
eakX(0) = eX(0) + 16
eakY(0) = eY(0)
eH(0) = 3
mxeH(0) = 3

eX(1) = 100
eY(1) = 150
eakX(1) = eX(1) + 16
eakY(1) = eY(1)
eH(1) = 5
mxeH(1) = 5

'**********
' Settings
'**********

'Screen

'Palette

CALL set6A(&h01)
CALL setApal(0, &h00, &h00, &h00) '0
CALL setApal(1, &h03, &h05, &h05) '1
CALL setApal(2, &h0F, &h06, &h04) '4
CALL setApal(3, &h0C, &h0C, &h0C) '5
CALL setApal(4, &h02, &h09, &h02) '2
CALL setApal(5, &h0F, &h0A, &h06) '3
CALL setApal(6, &h09, &h04, &h01) '6
CALL setApal(7, &h00, &h06, &h00) '7

'************
' Main Codes
'************

'Opening

CLS 3

FOR i = 0 TO 2
  TEXTCOLOR 18 + i
  LOCATE 30, 8
  PRINT "MICRO E-FOREST for PC-98"
  LOCATE 35, 10
  PRINT "EL_BASICà⁄êAî≈"
  SLEEP 1
NEXT

TEXTCOLOR 47
LOCATE 30, 18
PRINT "Press Any Key to Start."

'Create Character

size = 2
CALL createchar1(100,220,size)
CALL createchar1(200,220,size)
CALL createchar1(300,220,size)
CALL createchar1(320,220,size)
CALL createchar1(400,220,size)
CALL createchar1(100,240,size)
CALL createchar1(120,240,size)
CALL createchar1(140,240,size)
CALL createchar1(160,240,size)

CALL getchar1(100, 220, 100+size*8, 220+size*8)
FOR i=0 TO 255
  SWAP c_buf(i), c_block(i)
NEXT

CALL getchar1(200, 220, 200+size*8, 220+size*8 )
FOR i=0 TO 255
  SWAP c_buf(i), c_tree(i)
NEXT

CALL getchar1(300, 220, 300+size*8, 220+size*8 )
FOR i=0 TO 255
  SWAP c_buf(i), c_player11(i)
NEXT

CALL getchar1(320, 220, 320+size*8, 220+size*8 )
FOR i=0 TO 255
  SWAP c_buf(i), c_player12(i)
NEXT

CALL getchar1(400, 220, 400+size*8, 220+size*8 )
FOR i=0 TO 255
  SWAP c_buf(i), c_erase(i)
NEXT

CALL getchar1(100, 240, 100+size*8, 240+size*8 )
FOR i=0 TO 255
  SWAP c_buf(i), c_enemy11(i)
NEXT

CALL getchar1(120, 240, 120+size*8, 240+size*8 )
FOR i=0 TO 255
  SWAP c_buf(i), c_enemy12(i)
NEXT

CALL getchar1(140, 240, 140+size*8, 240+size*8 )
FOR i=0 TO 255
  SWAP c_buf(i), c_enemy21(i)
NEXT

CALL getchar1(160, 240, 160+size*8, 240+size*8 )
FOR i=0 TO 255
  SWAP c_buf(i), c_enemy22(i)
NEXT

WHILE INKEY$ = "" WEND

CLS 3

'Create Map

FOR i=0 to 39
  PUT (16*i,384), c_block, 0
NEXT
FOR i=0 to 18
  PUT (624,368-16*i), c_block, 0
NEXT
FOR i=0 to 39
  PUT (16*i,64), c_block, 0
NEXT
FOR i= 0 to 18
  PUT (0,368-16*i), c_block, 0
NEXT
FOR i=0 to 29
  tree_x = RND(592)+16
  tree_y = RND(288)+80
  PUT (tree_x,tree_y), c_tree, 0
NEXT

'Place Character

PUT (pX,pY), c_player11, 1
PUT (eX(0), eY(0)), c_enemy11, 1
PUT (eakX(0), eakY(0)), c_enemy12, 1
PUT (eX(1), eY(1)), c_enemy21, 1
PUT (eakX(1), eakY(1)), c_enemy22, 1

'Instruction

WHILE INKEY$ <> "" WEND

LOCATE 30, 8
PRINT "è„à⁄ìÆ  : Key 8"
LOCATE 30, 9
PRINT "â∫à⁄ìÆ  : Key 2"
LOCATE 30, 10
PRINT "ç∂à⁄ìÆ  : Key 4"
LOCATE 30, 11
PRINT "âEà⁄ìÆ  : Key 6"
LOCATE 30, 12
PRINT "çUåÇ    : Key a"

SLEEP 1

WHILE INKEY$ = "" WEND

CLS 1

'Player Action

pK = ""

WHILE (pK <> "Q" AND pK <> "q")
  pK = INKEY$

  ppX = pX
  ppY = pY

  CALL calcpXY(pK, pX, pY, pakX, pakY)

  IF (pX <> ppX or pY <> ppY) THEN
    PUT (ppX,ppY), c_erase, 0
    PUT (pX,pY), c_player11, 1
  ENDIF

  IF (pk = "A" OR pK = "a") THEN
    PUT (pakX,pakY), c_player12, 0
      FOR i=0 to 1
        ept1 = POINT (eX(i), eY(i))
        ept2 = POINT (eX(i)+15, eY(i))
        ept3 = POINT (eX(i), eY(i)+15)
        ept4 = POINT (eX(i)+15, eY(i)+15)
        IF ept1 = 6 THEN
          eH(i) = eH(i) - 1
        ELSEIF ept2 = 6 THEN
          eH(i) = eH(i) - 1
        ELSEIF ept3 = 6 THEN
          eH(i) = eH(i) - 1
        ELSEIF ept4 = 6 THEN
          eH(i) = eH(i) - 1
        ENDIF
        SLEEP 1
        IF (eH(i) = 0) THEN
          PUT (eX(i),eY(i)), c_erase, 0
          PUT (eakX(i),eakY(i)), c_erase, 0
        ENDIF

        PUT (pakX,pakY), c_erase, 0
      NEXT
  ENDIF

'Enemy Action

  FOR i=0 to 1
    IF (pX <> ppX OR pY <> ppY) THEN
      IF (eH(i) > 0) THEN
        peX = eX(i)
        peY = eY(i)

        peakX = eakX(i)
        peakY = eakY(i)
        PUT (peakX,peakY), c_erase, 0

        eX_buf = eX(i)
        eY_buf = eY(i)
        CALL calceXY(pX, pY, eX_buf, eY_buf)
        eX(i) = eX_buf
        eY(i) = eY_buf

        IF (eX(i) <> peX OR eY(i) <> peY) THEN
          PUT (peX,peY), c_erase, 0
          IF (i = 0) THEN
            PUT (eX(i),eY(i)), c_enemy11, 1
          ELSEIF (i = 1) THEN
            PUT (eX(i),eY(i)), c_enemy21, 1
          ENDIF
        ENDIF

        eakS = (RND 4) - 1

        IF (eakS = 0) THEN
          eakX(i) = eX(i)
          eakY(i) = eY(i)-16
        ELSEIF (eakS = 1) THEN
          eakX(i) = eX(i)
          eakY(i) = eY(i)+16
        ELSEIF (eakS = 2) THEN
          eakX(i) = eX(i)-16
          eakY(i) = eY(i)
        ELSEIF (eakS = 3) THEN
          eakX(i) = eX(i)+16
          eakY(i) = eY(i)
        ENDIF

        IF (i = 0) THEN
          PUT (eakX(i),eakY(i)), c_enemy12, 1
        ELSEIF (i = 1) THEN
          PUT (eakX(i),eakY(i)), c_enemy22, 1
        ENDIF

        IF POINT (pX, pY) = 3 THEN
          pH = pH - 1
        ELSEIF POINT (pX+15, pY) = 3 THEN
          pH = pH - 1
        ELSEIF POINT (pX, pY+15) = 3 THEN
          pH = pH - 1
        ELSEIF POINT (pX+15, pY+15) = 3 THEN
          pH = pH - 1
        ENDIF

      ENDIF
    ENDIF
  NEXT

'Update Status

  LOCATE 1, 1
  PRINT "Player HP:"; pH; "/"; mxpH

  LOCATE 19, 1
  IF (eH(0) > 0) THEN
    IF (ABS pX-eX(0) < 32) THEN
      PRINT "Enemy1 HP:"; eH(0); "/"; mxeH(0)
    ENDIF
  ENDIF

  LOCATE 19, 1
  IF (eH(1) > 0) THEN
    IF (ABS pX-eX(1) < 32) THEN
      PRINT "Enemy2 HP:"; eH(1); "/"; mxeH(1)
    ENDIF
  ENDIF

  IF (pH = 0) THEN
    LOCATE 30,8
    PRINT "Game Over!!"
    SLEEP 1
    WHILE INKEY$ <> "" WEND
    LOCATE 30,18
    PRINT "Press Any Key."
    WHILE INKEY$ = "" WEND
    pK = "q"
  ENDIF

  IF (eH(0) = 0 AND eH(1) = 0) THEN
    LOCATE 30,8
    PRINT "You saved the world!!"
    SLEEP 1
    WHILE INKEY$ <> "" WEND
    LOCATE 30,18
    PRINT "Press Any Key."
    WHILE INKEY$ = "" WEND
    pK = "q"
  ENDIF


WEND

'Ending

CLS 3
CALL setApal(0, &h00, &h00, &h00)
CALL setApal(1, &h00, &h00, &h0F)
CALL setApal(2, &h0F, &h00, &h00)
CALL setApal(3, &h0F, &h00, &h0F)
CALL setApal(4, &h00, &h0F, &h00)
CALL setApal(5, &h00, &h0F, &h0F)
CALL setApal(6, &h0F, &h0F, &h00)
CALL setApal(7, &h0F, &h0F, &h0F)

END

'***************
' Subroutines
'***************

'Create Character
SUB createchar1(CONST INTEGER x1, CONST INTEGER y1, CONST INTEGER size)

  STRING data_s
  STRING c_s
  INTEGER c_val
  INTEGER i, j

  FOR j = 0 TO 7
    READ data_s
    FOR i = 0 TO 7
      c_s = "&h"+MID$(data_s, i+1, 1)
      c_val = INT(VAL(c_s))
      LINE (x1+size*i, y1+size*j)-(x1+size*(i+1), y1+size*(j+1)), c_val, BF
    NEXT
  NEXT

ENDSUB

'Get character
SUB getchar1(CONST INTEGER x1, CONST INTEGER y1, CONST INTEGER x2, CONST INTEGER y2)

  INTEGER w
  INTEGER h
  w = x2-x1+1
  h = y2-y1+1
  'PRINT IMAGESIZE(x1,y1,x2-1,y2-1)

  GET (x1,y1)-(x2-1,y2-1), c_buf

ENDSUB

'Calculate player coordinate
SUB calcpXY(REFERENCE STRING pK, REFERENCE INTEGER pX, REFERENCE INTEGER pY, REFERENCE INTEGER pakX, REFERENCE INTEGER pakY)

  IF (pK = "8") THEN
    IF (pY < 400) THEN
      pY = pY - 8
      pakX = pX
      pakY = pY - 16
    ENDIF
  ELSEIF (pK = "2") THEN
    IF (pY > 0) THEN
      pY = pY + 8
      pakX = pX
      pakY = pY + 16
    ENDIF
  ELSEIF (pK = "4") THEN
    IF (pX > 0) THEN
      pX = pX - 8
      pakX = pX - 16
      pakY = pY
    ENDIF
  ELSEIF (pK = "6") THEN
    IF (pX < 640) THEN
      pX = pX + 8
      pakX = pX + 16
      pakY = pY
    ENDIF
  ENDIF

ENDSUB

'Calculate enemy coordinate
SUB calceXY(CONST INTEGER pX, CONST INTEGER pY, REFERENCE INTEGER eX, REFERENCE INTEGER eY)

  IF (pX - eX > 0) THEN
    eX = eX + 1
  ELSEIF (pX - eX < 0) THEN
    eX = eX - 1
  ENDIF

  IF (pY - eY > 0) THEN
    eY = eY + 1
  ELSEIF (pY - eY < 0) THEN
    eY = eY - 1
  ENDIF

ENDSUB

'Set Port 6Ah
SUB set6A(CONST INTEGER dat)

  OUT &h006A, dat

ENDSUB

'Set Analog Pallet
SUB setApal(CONST INTEGER palN, CONST INTEGER R, CONST INTEGER G, CONST INTEGER B)

  OUT &h00A8, palN
  OUT &h00AA, G
  OUT &h00AC, R
  OUT &h00AE, B

ENDSUB

'*******
' Data
'*******

'Characters

'Block
DATA "60066666"
DATA "66660006"
DATA "60066666"
DATA "66666666"
DATA "60066666"
DATA "66660006"
DATA "60066666"
DATA "66666666"

'Tree
DATA "00222200"
DATA "02622620"
DATA "02622620"
DATA "02266220"
DATA "00766700"
DATA "00066000"
DATA "00066000"
DATA "00666600"

'Player Body
DATA "00111105"
DATA "01111116"
DATA "01033016"
DATA "55333356"
DATA "66111116"
DATA "66111113"
DATA "66111100"
DATA "00566500"

'Player Attack
DATA "66644666"
DATA "66644666"
DATA "46644664"
DATA "44466444"
DATA "44466444"
DATA "46644664"
DATA "66644666"
DATA "66644666"

'Erase
DATA "00000000"
DATA "00000000"
DATA "00000000"
DATA "00000000"
DATA "00000000"
DATA "00000000"
DATA "00000000"
DATA "00000000"

'Enemy1 Body
DATA "00003000"
DATA "30033303"
DATA "30033303"
DATA "30333303"
DATA "33733733"
DATA "03366330"
DATA "00333300"
DATA "00033000"

'Enemy1 Attack
DATA "34444443"
DATA "43444434"
DATA "44344344"
DATA "44433444"
DATA "44433444"
DATA "44344344"
DATA "43444434"
DATA "34444443"

'Enemy2 Body
DATA "00111100"
DATA "04400040"
DATA "04400040"
DATA "04000040"
DATA "00600600"
DATA "40066004"
DATA "41111114"
DATA "01144110"

'Enemy2 Attack
DATA "34444443"
DATA "43444434"
DATA "44344344"
DATA "44433444"
DATA "44433444"
DATA "44344344"
DATA "43444434"
DATA "34444443"
