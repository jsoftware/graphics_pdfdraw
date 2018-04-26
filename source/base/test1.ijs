NB. wiki example

load 'graphics/pdfdraw'

setsize 250 100
pdffill 255 239 223
pdfline 1;255 0 0;10 90 240 90
pdfpoly 1;64 64 64;64 255 192;50 30,30 60,40 80,80 75
pdfrect 0 128 255;150 50 50 20
txt=. 'In the very middle of the court was a table'
pdftext txt;0 0 12 0 0;0;Black;10 20

(buildpdf buf) fwrite f=. jpath '~temp/pdfdraw.pdf'
viewpdf_j_ f
