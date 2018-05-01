NB. build base pdfdraw

P=: jpath '~Addons/graphics/pdfdraw/'

f=. 3 : 0
freads '~Plot/out/pdf/',y,'.ijs'
)

plotsrc=. ; f each ;: 'util bezier cid cmds esc mark pdfbuild'

dat=. readsource_jp_ P,'source/base'
dat=. dat,plotsrc
dat=. dat,freads P,'source/base/fini.ijs'
dat fwritenew P,'pdfdraw.ijs'

(P,'demo1.ijs') fcopynew P,'source/base/test.ijs'
