'******************************
'*   MICRO E-FOREST for PC-98 *
'*   EL_BASICà⁄êAî≈           *
'******************************

'History
'ver 0.1 2020.2.24 PC-98 EL_BASICà⁄êAî≈çÏê¨äJén

'***********
' Variables
'***********

INTEGER mypal(16)

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
INTEGER c_enemy31(256)
INTEGER c_enemy32(256)
INTEGER c_enemy41(256)
INTEGER c_enemy42(256)

INTEGER c_buf(256)

INTEGER pX, pY
INTEGER ppX, ppY
INTEGER pD(2)

INTEGER pakX, pakY

INTEGER pH
INTEGER mxpH

INTEGER eX(8), eY(8)
INTEGER peX, peY
INTEGER eD(8,2)

INTEGER eakS
INTEGER eakX(8), eakY(8)
INTEGER peakX, peakY

INTEGER eH(8)
INTEGER mxeH(8)

STRING pK

INTEGER i

'************************
' Subroutine Protoptypes
'************************

SUBDEF createchar1(CONST INTEGER x1, CONST INTEGER y1, CONST INTEGER size)
SUBDEF getchar1(CONST INTEGER x1, CONST INTEGER y1, CONST INTEGER x2, CONST INTEGER y2)
SUBDEF calcpXY(REFERENCE STRING pK, REFERENCE INTEGER pX, REFERENCE INTEGER pY, REFERENCE INTEGER pakX, REFERENCE INTEGER pakY)
SUBDEF calceXY(CONST INTEGER pX, CONST INTEGER pY, REFERENCE INTEGER eX, REFERENCE INTEGER eY)

'************
' Initialize
'************

pX = 200
pY = 100
pakX = pX + 16
pakY = pY
pH = 8
mxpH = 8

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

'************
' Main Codes
'************

'Opening

CLS

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
SLEEP 3

CLS

'Create Map

FOR i=0 to 39
  PUT (16*i,383), c_block, 0
NEXT

SLEEP 3

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
      pY = pY + 8
      pakX = pX
      pakY = pY + 16
    ENDIF
  ELSEIF (pK = "2") THEN
    IF (pY > 0) THEN
      pY = pY - 8
      pakX = pX
      pakY = pY - 16
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

'*******
' Data
'*******

'Characters

'Block
DATA "EEEEEEEE"
DATA "ECCEEEEE"
DATA "EEEECCCE"
DATA "ECCEEEEE"
DATA "EEEEEEEE"
DATA "ECCEEEEE"
DATA "EEEECCCE"
DATA "ECCEEEEE"

'Tree
DATA "CC3333CC"
DATA "CCC33CCC"
DATA "CCC33CCC"
DATA "CC7337CC"
DATA "C773377C"
DATA "C737737C"
DATA "C737737C"
dATA "CC7777CC"

'Player Body
DATA "CCDEEDCC"
DATA "EE9999CC"
DATA "EE999993"
DATA "EE99999E"
DATA "DD3333DE"
DATA "C9C33C9E"
DATA "C999999E"
DATA "CC9999CD"

'Player Attack
DATA "ECCCCCCE"
DATA "CECCCCEC"
DATA "CCECCECC"
DATA "CCCEECCC"
DATA "CCCEECCC"
DATA "CCECCECC"
DATA "CECCCCEC"
DATA "ECCCCCCE"

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
DATA "CCC33CCC"
DATA "CC3333CC"
DATA "C33EE33C"
DATA "33733733"
DATA "3C3333C3"
DATA "3CC333C3"
DATA "3CC333C3"
DATA "CCCC3CCC"

'Enemy1 Attack
DATA "3CCCCCC3"
DATA "C3CCCC3C"
DATA "CC3CC3CC"
DATA "CCC33CCC"
DATA "CCC33CCC"
DATA "CC3CC3CC"
DATA "C3CCCC3C"
DATA "3CCCCCC3"

'Enemy2 Body
DATA "111CC111"
DATA "C111111C"
DATA "C88EE88C"
DATA "88688688"
DATA "8C8888C8"
DATA "8CC888C8"
DATA "8CC888C8"
DATA "11111111"

'Enemy2 Attack
DATA "3CCCCCC3"
DATA "C3CCCC3C"
DATA "CC3CC3CC"
DATA "CCC33CCC"
DATA "CCC33CCC"
DATA "CC3CC3CC"
DATA "C3CCCC3C"
DATA "3CCCCCC3"
