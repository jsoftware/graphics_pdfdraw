load 'graphics/pdfdraw'

Font=: 0 0 12 0 0
TitleFont=: 0 1 20 90 0
SubTitleFont=: 0 0 16 90 0
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
draw=: 3 : 0
drawinit''
drawsizes''
pdffill DrawBack
drawgraph''
drawgrid''
drawtitle''
)
drawinit=: 3 : 0
buf=: ''
FontHit=: Font vextent 'X'
'Px Py Pw Ph'=: Pxywh=: 0 0,Size
)
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
Gx=: Mx + labWid
Gw=: tabWid - labWid
Gy=: My + tabHit
Gh=: Ph - Gy + Ms
Gxywh=: Gx,Gy,Gw,Gh
Tx=: Mx
Ty=: My
Tw=: tabWid
Th=: tabHit
Txywh=: Tx,Ty,Tw,Th

EMPTY
)
drawgraph=: 3 : 0
pdfrect GraphBack;Gxywh
graphsizes''
drawlabels''
drawbars''
drawexport''
drawsides''
)
drawbars=: 3 : 0
dat=. roundint Gh * (_2 }. Data) % Ytop
sum=. +/\. }.dat,0
dat=. dat
sum=. sum
'rws cls'=. #dat
x=. (Gx + xSep) + cellWid * i. Cls
w=. cellWid - 2 * xSep
y=. Gy + Gh - sum
y=. Gy + sum
h=. dat
for_i. i.#dat do.
  pdfrect (i{Colors);x,.(i{y),.w,.i{h
end.
EMPTY
)
drawexport=: 3 : 0
x=. (Gx + roundint -: cellWid) + cellWid * i. Cls
y=. Gy + roundint Gh * ({:Data) % Ytop
pdfline 6;ExportColor;,x,.y
)
drawlabels=: 3 : 0
ndx=. (i. 1 + Ysteps) % Ysteps
lab=. ": each Ytop * ndx
ext=. Font hextent lab
x=. Gx - xTic
y=. Gy + roundint Gh * ndx
pdfline Line;GridColor;x,.y,.(Gx+Gw),.y
x=. Gx - ext + xTic + Cx
y=. (Gy + FontHit%3) + Gh * ndx
xy=. x,.y
for_i. i.#lab do.
  pdftext (i{lab),Font;0;Black;i{xy
end.
)
drawsides=: 3 : 0
pdfline Line;GridColor;(Gx,Gx+Gw),.Gy,.(Gx,Gx+Gw),.Gy+Gh
pdfline Line;GridColor;Gx,.(Gy,Gy+Gh),.(Gx+Gw),.Gy,Gy+Gh
)
graphsizes=: 3 : 0
tot=. _2 { Data
max=. >./tot
nmm=. 10 ^ <. 10 ^. max
Ytop=: nmm * >. max % nmm
step=. 1 2 5 10 20 50 100 * 10 ^ <: <. 10 ^. Ytop
cnt=. Ytop % step
ndx=. (cnt<10) i. 1
Ysteps=: ndx{cnt
)
drawgrid=: 3 : 0
drawgridlines''
drawkeys''
drawxlabel''
drawvalues''
)
drawgridlines=: 3 : 0
y=. Ty + labHit*i.1+#Data
p=. Tx,.y,.(Tx+Tw),.y
pdfline Line;GridColor;p
pdfline Line;GridColor;Tx,Ty,Tx,Ty+Th-xlabHit
x=. (Tx + labWid) + cellWid * i.1+MonthLen
pdfline Line;GridColor;x,.Ty,.x,.Ty+Th
)
drawkeys=: 3 : 0
h=. labHit - 2 * Ly
x=. Tx + Lx
y=. Ty + 1 * Ly
r=. #Data
for_i. i.r-2 do.
  pdfrect (i{Colors);x,(y+labHit*r-i+1),Kw,h
end.
  pdfrect ExportColor;x,y,Kw,h
x=. x + Kw + Lx
y=. Ty - 2 * Cy
for_i. i.r do.
  pdftext (i{Names),Font;0;Black;x,y+labHit*r-i
end.
)
drawvalues=: 3 : 0
txt=. ,":each |.Data
ext=. Font hextent txt
x=. (Gx + cellWid%2) + (cellWid * Cls | i.#txt) - ext % 2
y=. (Ty + labHit - 2 * Cy) + Cls # labHit * i.Rws
xy=. x,.y
for_i. i.#txt do.
  pdftext (i{txt),Font;0;Black;i{xy
end.
)
drawxlabel=: 3 : 0
txt=. ": each ;/Months
ext=. Font hextent txt
msk=. 4 = # &> txt
x=. (Gx + cellWid%2) + (cellWid * i. MonthLen) - ext % 2
y=. Ty + Th - Cy + <. -: xlabHit - FontHit
for_i. I.msk do.
  pdftext (i{txt),Font;10;Black;(i{x),y
end.
msk=. -.msk
ndx=. I. msk
sel=. 2 {.each msk#txt
ext=. Font hextent sel
x=. (Gx + cellWid%2) + (cellWid * ndx) - ext % 2
y=. Ty + Th - Cy + <. (-:xlabHit) - FontHit
for_i. i.#sel do.
  pdftext (i{sel),Font;10;Black;(i{x),y
end.
sel=. _2 {.each msk#txt
ext=. Font hextent sel
x=. (Gx + cellWid%2) + (cellWid * ndx) - ext % 2
y=. Ty + Th - Cy + <. -:xlabHit
for_i. i.#sel do.
  pdftext (i{sel),Font;10;Black;(i{x),y
end.
)
Title=: 'GWh / month'
SubTitle=: ''
Begin=: 7 13
End=: 12 15
Names=: cutopen 0 : 0
Biofuels
Others
Natural Gas
Peat
Oil
Coal
Total
Electricity Exports
)

d=. 1 0.1 0.2 0.2 0.05 0.9 0.2 * 500+?. 7 26$702
d=. <. d *"1[ 1 + | 1 o. 2p1 * (i.26)%24
e=. {:d
d=. }:d
Data=: d,(+/d),:e
rundemo=: 3 : 0
'Rws Cls'=: $Data
b=. +/ 1 12 * Begin - 1 0
e=. +/ 1 12 * End - 1 0
Months=: |."1[ 0 1 +"1 [ 0 12 #: b + i. 1 + e - b
MonthLen=: #Months
draw''
f=. jpath '~Addons/graphics/pdfdraw/source/publish/pdfdraw1.jpf'
(buildjpf buf) fwritenew f
f=. jpath '~temp/pdfdraw.pdf'
(buildpdf buf) fwritenew f
viewpdf_j_ f
)
drawtitle=: 3 : 0
if. 0=#Title do. EMPTY return. end.

'w h'=. TitleFont pextent <Title
x=. Ax
y=. Gy + <. -: Gh - w
pdftext Title;TitleFont;0;Black;x,y

if. 0=#SubTitle do. EMPTY return. end.

x=. x + h
'w h'=. SubTitleFont pextent <SubTitle
y=. Gy + <. -: Gh - w
pdftext SubTitle;SubTitleFont;0;Black;x,y
)

rundemo''
