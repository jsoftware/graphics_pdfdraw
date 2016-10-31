Size=: 550 275
barchart=: 3 : 0
'Title SubTitle YCaption Cols Keys Vals'=: y
draw''
)
Font=: 0 0 12 0 0
TitleFont=: 0 1 14 0 0
SubTitleFont=: 0 0 13 0 0
YCaptionFont=: 0 1 12 90 0
Cx=: 2
Cy=: 2
Lx=: 3
Ly=: 4
Mx=: 20
My=: 6
Mr=: 5
Ms=: 12
Kmx=: 15
keyBar=: 16 6

xSep=: 2
xTic=: 1
yTic=: 4
Line=: 0
Colors=: ".;._2 (0 : 0)
0 128 204
255 100 60
153 204 0
255 127 80
153 51 0
0 128 204
255 0 0
255 255 0
255 0 255
)

DrawBack=: White
GridColor=: 3#150
BarBack=: 240 240 248
KeyBack=: 255 255 255
draw=: 3 : 0
drawinit''
drawsizes''
pdffill 192+?3#64
drawkeys''
drawbars''
drawtitle''
)
drawinit=: 3 : 0
buf=: ''
FontHit=: Font vextent 'X'
'Px Py Pw Ph'=: Pxywh=: 0 0,Size
)
drawsizes=: 3 : 0
'Max Tics'=: 2 4 { getticpos 0;0;0;(>./+/Vals);10

'w h'=. >.>./"1 Font & pextent ": each Tics
ylabWid=: 20 >. w
xlabHit=: 20 >. h
ycapWid=: 16 >. h

'w h'=. TitleFont pextent  <Title
titleHit=: 35 >. 10 + h * 1 + 0<#SubTitle

'w h'=. >.>./"1 Font & pextent Keys
keyWid=: w + ({.keyBar) + 4 * Cx
keyHit=: h + 2 * Cy
Gx=: ycapWid + ylabWid + Mx
Gw=: Pw - keyWid + ylabWid + ycapWid + Mx + Kmx + 2 * Mr
Gy=: + xlabHit + 2 * My
Gh=: Ph - titleHit + xlabHit + 4 * My
Gxywh=: Gx,Gy,Gw,Gh
Kx=: Gx + Gw + Kmx
Kw=: keyWid
Kh=: (2*Cy) + keyHit * #Keys
Ky=: Gy + Gh - Kh + My
Kxywh=: Kx,Ky,Kw,Kh

EMPTY
)
drawkeys=: 3 : 0
pdfrect KeyBack;Kxywh
x=. Kx+Cx
y=. Ky+Cy+<.-:keyHit-{:keyBar
x1=. x+(2*Cx)+{.keyBar
y1=. Ky+keyHit-Cy
for_i. i.#Keys do.
  p=. i*keyHit
  pdfrect (i{Colors);x,(y+p),keyBar
  pdftext (i{Keys),Font;10;Black;x1,y1+p
end.
EMPTY
)
drawtitle=: 3 : 0
x=. Gx + <.Gw%2
y=. Ph - Ms
ext=. TitleFont hextent <Title
pdftext Title;TitleFont;0;Black;(x-ext%2),y
if. 0=#SubTitle do. EMPTY return. end.
y=. y - Cy + TitleFont vextent <Title
ext=. SubTitleFont hextent <SubTitle
pdftext SubTitle;SubTitleFont;0;Black;(x-ext%2),y
)
drawbars=: 3 : 0
pdfrect 1;GridColor;BarBack;Gxywh
drawtrim''
drawycaption''
w=. Gw % #Cols
x=. Gx + <.w%2
pw=. <.w*0.7
po=. <.w*0.35
for_i. i.#Cols do.
  px=. x + w*i
  pdfline 1;Black;px,Gy,px,Gy-yTic
  tx=. px - 0.5*Font hextent i{Cols
  pdftext (i{Cols),Font;10;Black;tx,Gy-yTic+2
  bx=. px-po
  by=. Gy
  val=. i{"1 Vals
  for_j. i.#Keys do.
    h=. <.Gh*(j{val)%Max
    pdfrect (j{Colors);bx,by,pw,h
    by=. by+h
  end.
end.
)
drawkeys=: 3 : 0
pdfrect KeyBack;Kxywh
x=. Kx+Cx
y=. Ky+Cy+<.-:keyHit-{:keyBar
x1=. x+(2*Cx)+{.keyBar
y1=. Ky+keyHit-Cy
for_i. i.#Keys do.
  p=. i*keyHit
  pdfrect (i{Colors);x,(y+p),keyBar
  pdftext (i{Keys),Font;10;Black;x1,y1+p
end.
EMPTY
)
drawtrim=: 3 : 0
tics=. }.Tics
lab=. ": each tics
ext=. Font hextent lab
x=. Gx
y=. Gy + roundint tics * Gh % Max
pdfline Line;GridColor;x,.y,.(Gx+Gw),.y
pdfline Line;GridColor;Gx,Gy,Gx,Gy+Gh
pdfline Line;GridColor;(Gx+Gw),Gy,(Gx+Gw),Gy+Gh
x=. Gx - ext + xTic + Cx
y=. y + FontHit%3
xy=. x,.y
for_i. i.#lab do.
  pdftext (i{lab),Font;0;Black;i{xy
end.
)
drawycaption=: 3 : 0
'w h'=. Font pextent <YCaption
x=. Mx
y=. Gy + <. -: Gh - w
pdftext YCaption;YCaptionFont;0;Black;x,y
)
