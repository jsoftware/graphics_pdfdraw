NB. fini
NB. additions to plot source

PDF_PENSCALE=: PenScale
PDF_DEFSIZE=: Size

NB. =========================================================
NB. generate builds to PDF and to Publish JPF files
buildpdf=: pdf_build

buildjpf=: 3 : 0
top=. (":Size),';',(;PDFFonts ,each ','),';'
top,LF,dltbs buf
)

NB. =========================================================
NB. standard PDF header
pdf_header=: 3 : 0
t=. '/Title (Pdfdraw)'
a=. '/Author (',(({.~i.&'/') 9!:14''),')'
p=. '/Producer (Pdfdraw)'
d=. pdf_creationdate''
tit=. pdf_dict t;a;p;d
pag=. ": 3 + +/ PDFFontpages
cat=. pdf_dict '/Type /Catalog',LF,'/Pages ',pag,' 0 R',LF
fnt=. pdf_fonts ''
tit;cat;fnt
)
