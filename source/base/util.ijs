NB. util

FontSizeMin=: 0
PDFFonts=: ,<'Helvetica'
PDFClip=: 0 NB. count of clip stack
CIDFONTS=: 'MSung-Light';'STSong-Light'

buf=: ''

('i',each ;: 'LEFT CENTER RIGHT')=: i. 3

". COLORTABLE

NB. =========================================================
is1color=: 3 = */@$
citemize=: ,:^:(2 > #@$)
getfontsize=: 13 : '{.1{._1 -.~ _1 ". y'
isempty=: 0 e. $
log10=: 10&^.
pbuf=: 3 : 'buf=: buf,,y,"1 LF'
pow10=: 10&^
rectcolor=: [: glpen 1 1 [ glbrush @ glrgb
round=: [ * [: <. 0.5 + %~
rounddown=: [ * [: <. %~
roundint=: <. @ (0.5&+)
roundup=: [ * [: >. %~
scale01=: (% {:) @: (0: , +/\)
toucode1=: ''&,@:,@:(|."1@(_2: ]\ 1&(3!:4)))@(3&u:)@u:
u2a=: (1 u: 7 u: ]) :: ]

pextent=: 0.75 * getextent
hextent=: {. @ pextent
vextent=: {: @ pextent

NB. =========================================================
getplotfontsize=: 3 : 0
if. 2 131072 e.~ 3!:0 y do.
  FontScale * FontSizeMin >. getfontsize y
else.
  FontScale * FontSizeMin >. 2 { y
end.
)


NB. =========================================================
NB. pattern linepattern1 (x0,y0), (x1,y1)
NB. blank at end
linepattern1=: 4 : 0
len=. - -/ y
n=. roundint (%: +/ *: len) % +/ x
if. n=0 do. y
else.
  j=. +/\ 0 , , n # ,: x
  |: ({.y) + len */ (}: % {:) j
end.
)

NB. =========================================================
NB. pattern linepattern2 (x0,y0), (x1,y1)
NB. line at end
linepattern2=: 4 : 0
len=. - -/ y
n=. roundint (%: +/ *: len) % +/ x
if. n=0 do. y
else.
  j=. +/\ 0 , , n # ,: x
  |: ({.y) + len */ (% {:) }: j
end.
)

NB. =========================================================
NB. pattern linepattern lines
NB. expects vector of xy points
NB. returns matrix with 4 cols: x0,y0,x1,y1
NB. special cases solid "pattern" of 1 0
linepattern=: 4 : 0
nap=. ,`[@.('' -: ])`]@.('' -: [)  NB. null appendable without effect
x=. > x
y=. _2 [\ y
if. x -: 1 0 do.
  <. 2 ,\ y
else.
  a=. ; 2 < @ (x&linepattern1) \ }: y
  <. _2 ,\ a nap x linepattern2 _2 {. y  NB. changed simple append into nap
NB. see http://www.jsoftware.com/pipermail/programming/2009-April/014528.html
end.
)

NB. =========================================================
NB. format numbers for layout
NB. values are rounded to avoid
NB. - spurious accuracy in layout
NB. - exponential notation not supported by PDF
pfmt=: 3 : 0
dat=. ": 0.0001 round y
txt=. ,dat
($dat) $ '-' (I. txt='_') } txt
)

NB. =========================================================
pgetascender=: 3 : 0
FontScale * getascender y
)

NB. =========================================================
setsize=: 3 : 0
Pxywh=: 0 0,Size=: y
EMPTY
)
