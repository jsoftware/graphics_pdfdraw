NB. init

load 'graphics/pdfdraw'

Font=: 0 0 12 0 0
TitleFont=: 0 1 20 90 0
SubTitleFont=: 0 0 16 90 0

NB. =========================================================
NB. Ax title left margin
NB. Cx, Cy cell margins
NB. grid label margins
NB. Mx, My outer margins
NB. Kw  Key width
Ax=: 10
Cx=: 2
Cy=: 2
Lx=: 3
Ly=: 4
Mx=: 20
My=: 6
Mr=: 5
Ms=: 12
Kw=: 30

xSep=: 2
xTic=: 5

Line=: 0

NB. =========================================================
Colors=: ".;._2 (0 : 0)
153 204 0
153 51 0
192 192 192
255 0 0
255 255 0
0 128 204
255 0 255
)

DrawBack=: White
ExportColor=: 128 255 204
GridColor=: 3#150
GraphBack=: White
