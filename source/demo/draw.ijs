NB. draw

NB. =========================================================
draw=: 3 : 0
drawinit''
drawsizes''
pdffill DrawBack
drawgraph''
drawgrid''
drawtitle''
)

NB. =========================================================
drawinit=: 3 : 0
buf=: ''
FontHit=: Font vextent 'X'
'Px Py Pw Ph'=: Pxywh=: 0 0,Size
)

NB. =========================================================
drawsizes=: 3 : 0
'w h'=. >.>./"1 Font & pextent Names
labWid=: Kw + w + 4 * Lx
labHit=: h + 2 * Cy

'w h'=. >.>./"1 Font & pextent '15 15';":>./,Data
cellWid=: w + 2 * Cx

xlabHit=: (h*2) + 3 * Cy
tabHit=: xlabHit + labHit * #Data
tabWid=: labWid + cellWid*MonthLen

setsize (tabWid + Mx + Mr),My + Ms + cellWid*14

NB. draw box
Gx=: Mx + labWid
Gw=: tabWid - labWid
Gy=: My + tabHit
Gh=: Ph - Gy + Ms
Gxywh=: Gx,Gy,Gw,Gh

NB. table box
Tx=: Mx
Ty=: My
Tw=: tabWid
Th=: tabHit
Txywh=: Tx,Ty,Tw,Th

EMPTY
)
