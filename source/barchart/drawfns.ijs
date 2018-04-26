NB.draw fns

NB. =========================================================
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

NB. =========================================================
drawycaption=: 3 : 0
'w h'=. Font pextent <YCaption
x=. Mx
y=. Gy + <. -: Gh - w
pdftext YCaption;YCaptionFont;0;Black;x,y
)
