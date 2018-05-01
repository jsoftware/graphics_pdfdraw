NB. build all pdfdraw

f=: 3 : 0
load '~Addons/graphics/pdfdraw/source/',y,'/build.ijs'
)

f each ;: 'base barchart demo'

load '~Addons/graphics/pdfdraw/source/publish/build.ijs'

NB. =========================================================
dat=. 0 : 0
NB. run barchart example

load 'graphics/pdfdraw'
load 'graphics/pdfdraw/barchart'

XXX
NB. =========================================================
barchart gentest''

f=. jpath '~temp/pdfdraw_demo3.pdf'
(buildpdf buf) fwritenew f

viewpdf_j_ f
)

dat=. dat rplc 'XXX';freads '~Addons/graphics/pdfdraw/source/barchart/test.ijs'
dat fwritenew '~Addons/graphics/pdfdraw/source/demo3.ijs'

NB. =========================================================
mkdir_j_ '~Addons/graphics/pdfdraw/publish'
mkdir_j_ '~addons/graphics/pdfdraw/publish'

f=. 3 : 0
dat=. freads '~Addons/graphics/pdfdraw/source/',y
dat fwritenew '~Addons/graphics/pdfdraw/',y
dat fwritenew '~addons/graphics/pdfdraw/',y
)

f 'barchart.ijs'
f 'demo1.ijs'
f 'demo2.ijs'
f 'demo3.ijs'
f 'pdfdraw.ijs'
f 'manifest.ijs'
f 'readme.txt'
