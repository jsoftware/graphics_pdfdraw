NB. build

mkdir_j_ '~Addons/demos/publish'
mkdir_j_ '~addons/demos/publish'

NB. =========================================================
f=. 3 : 0
'fm to'=. 2$boxxopen y
dat=. freads '~Addons/graphics/pdfdraw/publish/',fm
dat fwritenew '~Addons/demos/publish/',to
dat fwritenew '~addons/demos/publish/',to
)

NB. =========================================================
f each cutopen 0 : 0
manifest.ijs
master.sty
master.txt
pdfdraw1.jpf
pdfdraw2.jpf
pdfdraw3.jpf
publish.jproj
run.ijs
section1.txt
section2.txt
section3.txt
)
