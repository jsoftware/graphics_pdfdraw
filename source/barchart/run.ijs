
load 'graphics/pdfdraw'
load '~Addons/graphics/pdfdraw/source/barchart.ijs'
load '~Addons/graphics/pdfdraw/source/barchart/test.ijs'

DAT=: gentest''

NB. =========================================================
NB. write single graph to PDF and view
runpdf=: 3 : 0
barchart DAT
f=. jpath '~temp/pdfdraw3.pdf'
(buildpdf buf) fwritenew f
viewpdf_j_ f
)

NB. =========================================================
NB. write graph to JPF for publish demo
runjpf=: 3 : 0
barchart DAT
(buildjpf buf) fwritenew '~Addons/graphics/pdfdraw/source/publish/pdfdraw3.jpf'
load '~Addons/graphics/pdfdraw/source/publish/run.ijs'
)

NB. =========================================================
NB. these demos use viewpdf_j_ to view the PDF file
NB. ensure this works on your system first. If necessary,
NB. set the PDF reader in Edit|Configure|Base

Note''
runpdf''
runjpf''
)

runpdf''
