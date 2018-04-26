NB. graph

NB. =========================================================
drawgraph=: 3 : 0
pdfrect GraphBack;Gxywh
graphsizes''
drawlabels''
drawbars''
drawexport''
drawsides''
)

NB. =========================================================
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

NB. =========================================================
drawexport=: 3 : 0
x=. (Gx + roundint -: cellWid) + cellWid * i. Cls
y=. Gy + roundint Gh * ({:Data) % Ytop
pdfline 6;ExportColor;,x,.y
)

NB. =========================================================
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

NB. =========================================================
drawsides=: 3 : 0
pdfline Line;GridColor;(Gx,Gx+Gw),.Gy,.(Gx,Gx+Gw),.Gy+Gh
pdfline Line;GridColor;Gx,.(Gy,Gy+Gh),.(Gx+Gw),.Gy,Gy+Gh
)

NB. =========================================================
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
