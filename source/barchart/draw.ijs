NB. draw

NB. =========================================================
draw=: 3 : 0
drawinit''
drawsizes''
pdffill 192+?3#64
drawkeys''
drawbars''
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

NB. bar draw box
Gx=: ycapWid + ylabWid + Mx
Gw=: Pw - keyWid + ylabWid + ycapWid + Mx + Kmx + 2 * Mr
Gy=: + xlabHit + 2 * My
Gh=: Ph - titleHit + xlabHit + 4 * My
Gxywh=: Gx,Gy,Gw,Gh

NB. key draw box
Kx=: Gx + Gw + Kmx
Kw=: keyWid
Kh=: (2*Cy) + keyHit * #Keys
Ky=: Gy + Gh - Kh + My
Kxywh=: Kx,Ky,Kw,Kh

EMPTY
)

NB. =========================================================
NB. key draw box
NB. Kx=: Gx + Gw + Kw
NB. Kw=: keyWid
NB. Kh=: keyHit * #Keys
NB. Ky=: Gy + Gh - Kh
NB. Kxywh=: Kx,Ky,Kw,Kh

NB. =========================================================
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

NB. =========================================================
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
