NB. grid

NB. =========================================================
drawgrid=: 3 : 0
drawgridlines''
drawkeys''
drawxlabel''
drawvalues''
)

NB. =========================================================
drawgridlines=: 3 : 0
y=. Ty + labHit*i.1+#Data
p=. Tx,.y,.(Tx+Tw),.y
pdfline Line;GridColor;p
pdfline Line;GridColor;Tx,Ty,Tx,Ty+Th-xlabHit
x=. (Tx + labWid) + cellWid * i.1+MonthLen
pdfline Line;GridColor;x,.Ty,.x,.Ty+Th
)

NB. =========================================================
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

NB. =========================================================
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

NB. =========================================================
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
