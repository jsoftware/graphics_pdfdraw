NB. source for pdfdraw demo1

require 'graphics/pdfdraw'

NB. =========================================================
draw=: 3 : 0
setsize 400 200
pdffill 255 239 223
pdfline 1;255 0 0;10 190 390 190
pdfpline 1;2;0 196 0;10 180 390 180
pdfrect 0 128 255;10 150 50 20
pdfrect 4;0 0 0;0 128 255;70 150 50 20
pdfmarker 1;'diamond';0 192 0;150 160
pdfmarker 1;'triangle';192 0 192;170 160
clr=. Red,Brown,Blue,Green,:Yellow
pos=. 280 120 40 ,"1 [ 338 90,231 338,197 231,189 197,:90 189
pdfpie 1;64 64 64;clr;pos
pdfpoly 1;64 64 64;64 255 192;50 70,30 100,40 120,80 115
txt=. 'In the very middle of the court was a table,'
pdftext txt;0 0 12 0 0;0;Black;200 70
txt=. 'with a large dish of tarts upon it ...'
pdftext txt;0 0 12 0 0;0;Black;200 60
txt=. 'Rotated text'
pdftext txt;0 0 12 90 0;10;Black;180 50
pdfcircle 1;Orchid;'';120 50 26
pdfdot 10;0 0 255;120 50
pdftext 'test pdfdraw';0 2 8 0 0;0;Black;350 12
)

NB. =========================================================
runtest=: 3 : 0
draw''
f=. jpath '~temp/pdfdraw.pdf'
(buildpdf buf) fwrite f
viewpdf_j_ f
)

runtest''