NB. init

require 'colortab trig graphics/afm'

coinsert 'jafm'

Size=: 480 360 NB. window size
FontScale=: 0.75 NB. scale screen fonts to PDF fonts
PenScale=: 0.4 NB. pen size
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
NB. draw
NB.
NB. these are the main pdfdraw functions
NB.
NB. position: x,y
NB. color: RGB as values 0-255

NB. =========================================================
NB.*pdfcircle v draw circle
NB.-v=pen size
NB.-e=edge color
NB.-c=unused
NB.-p=position, radius
pdfcircle=: 3 : 0
'v e c p'=. y
p=. citemize p
if. isempty c do.
  if. is1color e do.
    pbuf e pdf_pen v
    clr=. (#p) $ citemize pdf_color e
    for_i. i.#p do.
      pbuf i{clr
      pos=. pdf_circle i{p
      mov=. (pfmt 2 {. {. pos) , ' m '
      pbuf mov
      crv=. (pfmt 2 }."1 pos) ,"1 ' c '
      pbuf crv
      pbuf 'S'
    end.
  end.
end.
)

NB. =========================================================
NB.*pdfdot v draw dot
NB.-v=pen size
NB.-e=color
NB.-p=position
pdfdot=: 3 : 0
'v e p'=. y
p=. citemize p
pbuf e pdf_pen v
for_i. i.#p do.
  pos=. pdf_circle (i{p), v
  pbuf (pfmt 2 {. {. pos) , ' m '
  pbuf (pfmt 2 }."1 pos) ,"1 ' c '
  pbuf 'B'
end.
)

NB. =========================================================
NB.*set graph box clipping
NB.-y = xywh box
pdffxywh=: 3 : 0
if. #y do.
  PDFClip=: >: PDFClip
  pbuf 'q ',(":y),' re W n'
else.
  if. PDFClip do.
    PDFClip=: <: PDFClip
    pbuf 'Q'
  end.
end.
)

NB. =========================================================
NB.*pdffill v fill background
NB.-y-color
pdffill=: 3 : 0
pdfrect y;Pxywh
)

NB. =========================================================
NB.*pdfline
NB.-v=pen size
NB.-e=color
NB.-p=points
pdfline=: 3 : 0
'v e p'=. y
if. is1color e do.
  pbuf e pdf_pen v
  pbuf pdf_lines p
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  pen=. e pdf_pens v
  pbuf pen ,. pdf_lines p
end.
)

NB. =========================================================
NB.*pdfmarker
NB.-s=size
NB.-m=marker type
NB.-e=color
NB.-p=position
pdfmarker=: 3 : 0
's m e p'=. y
pbuf e pdf_pen 1
s ('pdfmark_',m)~ citemize p
)

NB. =========================================================
NB.*pdfpie v draw pie chart
NB.-v=edge pen size
NB.-e=edge color
NB.-c=slice colors
NB.-p=slice begin/end angles
pdfpie=: 3 : 0
'v e c p'=. y
pbuf e pdf_pen v
clr=. (pdf_colorfill c),"1 pdf_colorstroke e
clr=. (#p) $ citemize clr
for_i. i.#p do.
  pbuf i{clr
  pos=. bezierarc i{p
  pbuf (pfmt 2{.i{p), ' m ',(pfmt 2{.{.pos),' l '
  pbuf (pfmt 2}."1 pos),"1 ' c '
  pbuf 'b'
end.
)

NB. =========================================================
NB.*pdfline - draw patterned line
NB.-v=pen size
NB.-s=pattern style index
NB.-e=pen color
NB.-p=line positions
pdfpline=: 3 : 0
'v s e p'=. y
if. *./ s = 0 do.
  pdfline y return.
end.
pat=. 1 0;12 6;2 4;12 6 2 4;12 6 2 4 2 4
s=. s { pat
if. (is1color e) *. 1 = #v do.
  pos=. s linepattern"0 1 p
  pdfline v;e;<pos
else.
  rws=. #p
  e=. rws $ citemize e
  v=. rws $ v
  s=. rws $ s
  for_i. i.#p do.
    pos=. (i{s) linepattern i{p
    pdfline (i{v);(i{e);pos
  end.
end.
)

NB. =========================================================
NB.*pdfpoly - draw polygon
NB.-v=pen size
NB.-e=edge color
NB.-c=fill color
NB.-p=vertex positions
pdfpoly=: 3 : 0
'v e c p'=. y
if. v=0 do. e=. c end.
c=. citemize c
e=. citemize e
pbuf ({.e) pdf_pen v
pos=. (pdf_makelines p) ,"1 (v=0) pick ' b';' h f'
if. (1 = # ~.e) *. 1 = # ~.c do.
  pbuf (pdf_colorfill {.c), pdf_colorstroke {.e
  pbuf pos
else.
  c=. pos cmatch pdf_colorfill c
  e=. pos cmatch pdf_colorstroke e
  pbuf c,.e,.pos
end.
)

NB. =========================================================
NB.*pdfrect v draw rectangle
NB.-argument has length 2 or 4
NB.-if 2 elements given, these are fill and xywh with no border
NB.-otherwise:
NB.-  v=border width
NB.-  e=border color
NB.-  c=fill color
NB.-  p=xywh matrix
pdfrect=: 3 : 0
if. 2=#y do.
  'c p'=. y
  e=. c
else.
  'v e c p'=. y
  pbuf e pdf_pen v
end.
clr=. (pdf_colorfill c),"1 pdf_colorstroke e
pbuf clr ,"1 (pfmt p) ,"1 ' re B'
)

NB. =========================================================
NB.*pdftext
NB.-y is text;font;alignment;pencolor;position
NB.-assumes single alignment, single font
pdftext=: 3 : 0
't f a e p'=. y

NB. ---------------------------------------------------------
NB. set up fonts
'fnx fst fsz fan und'=. f
rot=. 3 | 0 90 270 i. fan
asc=. pgetascender f
fnm=. <getfntname fnx,fst
PDFFonts=: ~. PDFFonts,fnm

NB. ---------------------------------------------------------
fnx=. 1 + PDFFonts i. fnm
txt=. '/F',(":fnx),' ',(": getplotfontsize f),' Tf '

NB. ---------------------------------------------------------
NB. adjust position to PDF baseline
select. rot
case. 0 do. p=. 0 >. p -"1 [ 0, asc
case. 1 do. p=. p +"1 asc, 0
case. 2 do. p=. p -"1 asc, 0
end.

lin=. ''

NB. ---------------------------------------------------------
if. is1color e do.
  'rtxt rlin'=. (fnm e. CIDFONTS) pdf_text f;e;t;p;a;rot;und
  txt=. txt,,LF ,"1 rtxt
  lin=. lin,rlin,(0<#rlin)#LF
else.
  for_i. i.#e do.
    'rtxt rlin'=. (fnm e. CIDFONTS) pdf_text f;(i{e);(i{t);(i{p);a;rot;und
    txt=. txt,,LF ,"1 rtxt
    lin=. lin,rlin,(0<#rlin)#LF
  end.
end.

NB. ---------------------------------------------------------
pbuf pdf_wraptext txt
pbuf rlin
)
NB. tics

NB. =========================================================
NB. getticpos
NB. get tic positions for data
NB.
NB. form: getticpos int;tic;min;max;cnt
NB.   int  axis intercept
NB.   tic  tic step size or 0=calculated
NB.   min  minumum value
NB.   max  maximum value
NB.   cnt  maximum number of tic subdivisions
NB. returns: min;max;step;int;pos
getticpos=: 3 : 0

'int tic min max cnt'=. y

NB. ---------------------------------------------------------
NB. nudge min, max in case near a nice boundary:
nmm=. 10 ^ <. <: 10 ^. max - min
min=. nmm rounddown min
max=. nmm roundup max

wid=. max - min

NB. ---------------------------------------------------------
if. wid=0 do.
  if. #int do.
    if. int=min do.
      'min max'=. straddle min
    else.
      'min max'=. sort int, min
    end.
  else.
    'min max'=. straddle int=. min
  end.
end.

NB. ---------------------------------------------------------
if. #int do.
  max=. max >. int
  min=. min <. int
else.
  if. (min <: 0) *. max >: 0 do.
    int=. 0
  end.
end.

NB. ---------------------------------------------------------
if. tic > 0 do.
  s=. tic * 1 + i.10
else.
  s=. 1 2 5 10 20 50 100 * pow10 <: <. log10 max - min
end.

if. min < 0 do.
  x=. s roundup min
else.
  x=. s rounddown min
end.
if. max > 0 do.
  y=. s rounddown max
else.
  y=. s roundup max
end.

NB. ---------------------------------------------------------
c=. <. (y - x) % s
ndx=. (c <: cnt) i. 1
step=. ndx { s,0

if. (step=0) +. ndx = #x do.
  pos=. ''
else.
  pos=. (ndx{x) + step * i. 1 + ndx{c
  min=. min <. {. pos
  max=. max >. {: pos
end.

NB. ---------------------------------------------------------
if. 0=#int do.
  if. max > 0 do.
    int=. 0 >. min
  else.
    int=. max
  end.
end.

NB. ---------------------------------------------------------
step;min;max;int;pos
)
NB. util

NB. pdf always use big endian
endian=. ({.a.)={. 1&(3!:4) 1  NB. 0 little endian   1 big endian
toucodem=: ''&,@(1&(3!:4))@(3&u:)@u:
toucoder=: ''&,@:,@:(|."1@(_2: ]\ 1&(3!:4)))@(3&u:)@u:
toucode1=: toucodem`toucoder@.(-.endian) f.
4!:55 <'endian'  NB. Remove definition of 'endian' to avoid problems if the name is publicly assigned later

NB. =========================================================
NB. jpf_getparms
jpf_getparms=: 3 : 0
(PDF_DEFSIZE;JPF_DEFFILE) output_parms y
)

NB. =========================================================
pdf_boxrs2wh=: 3 : 0
a=. 2 {."1 y
b=. 2 }."1 y
(a <. b) ,"1 | a - b
)

NB. =========================================================
NB. pdf_getparms
pdf_getparms=: 3 : 0
(PDF_DEFSIZE;PDF_DEFFILE) output_parms y
)

NB. =========================================================
NB. pdf_dict
pdf_dict=: 3 : 0
if. L. y do.
  s=. ; y ,each <LF
else.
  s=. y , (LF ~: {: y) # LF
end.
'<<',LF,s,'>>',LF
)

NB. =========================================================
pdf_rotxy=: 3 : 0
if. ROT do.
  'px py'=. y
  (Sh-py),px
else.
  y
end.
)

NB. =========================================================
pdf_rotxym=: 3 : 0
if. ROT do.
  'px py'=. |:y
  (Sh-py),.px
else.
  y
end.
)

NB. =========================================================
pdf_wraptext=: 3 : 0
'BT ',y,' ET '
)

NB. =========================================================
pdf_write=: 4 : 0
dat=. x
file=. y
while. _1 -: dat flwrite file do.
  msg=. 'Unable to write to file: ',file,LF,LF
  if. #d=. 1!:0 file do.
    msg=. msg, 'If the file is open in Adobe, close the file and try again.'
    if. 1 query msg do. return. end.
  else.
    info msg,'The file name is invalid.' return. end.
end.
if. VISIBLE do.
  viewpdf_j_ file
end.
)
NB. bezier

NB. =========================================================
NB. bezierarc
NB.
NB. original from Oleg Kobchenko
NB.
NB. y is:
NB.   xy center, radius, angle1, angle2 (degrees)
bezierarc=: 3 : 0
'x y h a b'=. y
off=. 90
t1=. rfd 360 | a - off
t2=. rfd 360 | b - off
th=. 6 %~ 2p1 | t2 - t1
'c c1 s s1'=. (cos , sin) th,t1
x0=. x1=. 1 [ y0=. 0
'x3 y3'=. c,s
x2=. 3%~ (8*cos-:th)-x0+x3+3*x1
y2=. y3-(-x2-x3)%-tan th
y1=. 3%~ (8*sin-:th)-y0+y3+3*y2
r=. (x0,x1,x2,x3),:y0,y1,y2,y3
r=. r +/ . *~ (c1,-s1),:s1,c1
r=. r (+/ . *)^:(i.6)~ (c,-s),:s,c
,@|:"2 (x,y)+"2 h*r
)
NB. cid
NB.
NB. Each asian font is a text string in 3 parts,
NB. written to 3 objects.
NB.
NB. This is fixed up by:
NB.   %prev is replaced with the previous object number.
NB.   /Name F has the font number appended

MSUNGLIGHT=: 0 : 0
/Type /FontDescriptor
/FontName /MSung-Light
/Flags 5
/FontBBox [ -260 -174 1043 826 ]
/MissingWidth 600
/StemV 93
/ItalicAngle 0
/CapHeight 625
/Ascent 826
/Descent -174

/Type /Font
/Subtype /CIDFontType0
/BaseFont /MSung-Light
/FontDescriptor %prev 0 R
/CIDSystemInfo << /Registry (Adobe)/Ordering (CNS1)/Supplement 4 >>
/DW 1200
/W [ 1 255 600 ]

/Type /Font
/Subtype /Type0
/Name /F
/BaseFont /MSung-Light
/DescendantFonts [ %prev 0 R ]
/Encoding /UniCNS-UTF16-H
)

NB. =========================================================
STSONGLIGHT=: 0 : 0
/Type /FontDescriptor
/FontName /STSong-Light
/Flags 5
/FontBBox [ -260 -174 1043 826 ]
/MissingWidth 600
/StemV 93
/ItalicAngle 0
/CapHeight 625
/Ascent 826
/Descent -174

/Type /Font
/Subtype /CIDFontType0
/BaseFont /STSong-Light
/FontDescriptor %prev 0 R
/CIDSystemInfo << /Registry (Adobe)/Ordering (GB1)/Supplement 4 >>
/DW 1200
/W [ 1 255 600 ]

/Type /Font
/Subtype /Type0
/Name /F
/BaseFont /STSong-Light
/DescendantFonts [ %prev 0 R ]
/Encoding /UniGB-UTF16-H
)
NB. pdf cmds
NB.
NB. pdf graphics command utilities

NB. =========================================================
NB. pdf_circle
NB.
NB. returns bezier points to draw circle
NB. with given center and radius
NB.
NB. result is 4 row table, each row being a 90 degree arc.
pdf_circle=: 3 : 0
'x y r'=. y
arc=. _2 [\ 0 1 2 1 1 2 1 0 { 0 1, 4r3*<:%:2
arr=. |."1 arc *"1 [ _1 1
mat=. _4 ,\ arc,arr,-arc,arr
(mat * r) + ($mat) $ x,y
)


NB. =========================================================
pdf_colorstroke=: 3 : 0
(": y % 255),"1 ' RG '
)

NB. =========================================================
pdf_colorfill=: 3 : 0
(": y % 255),"1 ' rg '
)

NB. =========================================================
pdf_color=: 3 : 0
clr=. ": y % 255
clr ,"1 ' RG ' ,"1 clr ,"1 ' rg '
)

NB. =========================================================
pdf_makelines=: 3 : 0
if. 2 > #$y do.
  ,: (pfmt 2 {. y),' m ',,(pfmt _2 [\ 2 }. y) ,"1 ' l '
else.
  mov=. (pfmt 2 {."1 y) ,"1 ' m '
  lns=. ,"2 (pfmt _2 [\"1 [ 2 }."1 y) ,"1 ' l '
  mov,.lns
end.
)

NB. =========================================================
NB. codes to set pen
NB.
NB. pdf_pen    one color, one size
NB. pdf_pens   several colors, several sizes
pdf_pens=: 4 : 0
(pdf_color x) ,"1 (":,.PDF_PENSCALE*y) ,"1 ' w '
)

NB. =========================================================
pdf_pen=: 4 : 0
(pdf_color ,x), (":PDF_PENSCALE*y) ,' w '
)

NB. =========================================================
pdf_lines=: 3 : 0
(pdf_makelines y) ,"1 ' S'
)

NB. =========================================================
NB. pdf_text
NB.
NB. single alignment, single font
pdf_text=: 4 : 0
0 pdf_text y  NB. x  1=use cid font
:
'fnt clr txt pos align rot und'=. y

clr=. pdf_color clr

txt=. ,each boxopen txt

NB. ---------------------------------------------------------
if. und +. align e. iCENTER, iRIGHT do.
  len=. fnt pgetstringlen txt
end.

NB. ---------------------------------------------------------
NB. convert utf8 to ucs2, then big endian encoding
if. x do.
  txt=. toucode1@(7&u:) each txt
else.
  tx=. 0$<''
  for_t. txt do.
    if. 0-: t1=. 7&u: ::0: t=. >t do.
      tx=. tx, <u2a t
    else.
      if. *./ 256 > 3&u: t1 do.
        tx=. tx, < 1&u: t1
      else.
        tx=. tx, <u2a t
      end.
    end.
  end.
  txt=. tx
end.

txt=. pdfesc each txt

NB. ---------------------------------------------------------
select. rot

case. 0 do.
  select. align
  case. iCENTER do.
    pos=. pos -"1 (-:len),.0
  case. iRIGHT do.
    pos=. pos -"1 len,.0
  end.
  txt=. (<' Tm (') ,each txt ,each <') Tj '
  res=. clr,(<"1 '1 0 0 1 ' ,"1 pfmt pos >. 0) ,&> txt
case. 1 do.
  select. align
  case. iCENTER do.
    pos=. pos -"1 [ 0,.-:len
  case. iRIGHT do.
    pos=. pos -"1 [ 0,.len
  end.
  txt=. (<' Tm (') ,each txt ,each <') Tj '
  res=. clr,(<"1 '0 1 -1 0 ' ,"1 pfmt pos >. 0) ,&> txt
case. 2 do.
  select. align
  case. iCENTER do.
    pos=. pos +"1 [ 0,.-:len
  case. iRIGHT do.
    pos=. pos +"1 [ 0,.len
  end.
  txt=. (<' Tm (') ,each txt ,each <') Tj '
  res=. clr,(<"1 '0 -1 1 0 ' ,"1 pfmt pos >. 0) ,&> txt
end.

NB. ---------------------------------------------------------
if. -. und do. res;'' return. end.

NB. ---------------------------------------------------------
NB. underline
pos=. citemize pos
len=. , len

'off lwd'=. getunderline fnt
lin=. clr,' ',(":lwd) ,' w '

select. rot
case. 0 do.
  bgn=. 0 >. pos -"1 [ 0,.-off
  end=. bgn + len,.0
case. 1 do.
  bgn=. 0 >. pos -"1 off,.0
  end=. bgn + 0,.len
case. 2 do.
  bgn=. 0 >. pos +"1 off,.0
  end=. bgn - 0,.len
end.

lin=. lin,(pdf_makelines bgn,.end) ,"1 ' b'
res;lin

)
NB. escape sequence of pdf
NB.
NB. \n linefeed
NB. \r carriage return
NB. \t horizontal tab
NB. \f formfeed
NB. \b backspace
NB. \\ backslash
NB. \( left parenthesis
NB. \) right parenthesis
NB. \ddd character code ddd (octal)

PDFESC0=: LF,CR,TAB,FF,(8{a.),'\()'
PDFESC1=: 'nrtfb\()'
PDFASC=: PDFESC0,32}.127{.a.

NB. =========================================================
NB. pdfesc
NB.
NB. fixes backslash in text and adds any escape sequences
pdfesc=: 3 : 0

NB. add backslash
txt=. y
msk=. txt e. PDFESC0
if. 1 e. msk do.
  ndx=. , ((I. msk) + i. +/ msk) +/ 0 1
  new=. ,'\',.PDFESC1 {~ PDFESC0 i. msk#txt
  txt=. new ndx } (1 + msk) # txt
end.

NB. convert nonprinting ascii characters to ddd
msk=. -. txt e. PDFASC
if. 1 e. msk do.
  new=. 1 ": 8 8 8 #: a. i. msk # txt
  ndx=. ,((I. msk) + 3 * i. +/ msk) +/ i. 4
  txt=. (,'\',"1 new) ndx } (1 + msk * 3) # txt
end.

txt
)
NB. markers

NB. =========================================================
pdfmark_circle=: 4 : 0
s=. 3.5 * x
p=. y ,. s
for_d. p do.
  pos=. pdf_circle d
  pbuf (pfmt 2 {. {. pos) , ' m '
  pbuf (pfmt 2 }."1 pos) ,"1 ' c '
  pbuf 'B'
end.
)

NB. =========================================================
pdfmark_diamond=: 4 : 0
p=. 8 $"1 y
d=. (3.5 * x) * _1 0 0 1 1 0 0 _1
p=. p +"1 d
pbuf (pdf_makelines p) ,"1 ' b'
)

NB. =========================================================
NB. following only used for key markers, given singly
pdfmark_line=: 4 : 0
'x y'=. , y
p=. (x--:KeyLen),(y--:KeyPen),KeyLen,KeyPen
pbuf (pfmt p) ,"1 ' re B'
)

NB. =========================================================
pdfmark_plus=: 4 : 0
s=. 0, x * 4
t=. |. s
p=. (y -"1 t) ,. y +"1 t
p=. p, (y -"1 s) ,. y +"1 s
pbuf (":PDF_PENSCALE * 5 * x) , ' w '
pbuf (pdf_makelines p) ,"1 ' b'
)

NB. =========================================================
pdfmark_square=: 4 : 0
s=. 3 * x
p=. (y - s) ,"1 +: s,s
pbuf (pfmt p) ,"1 ' re B'
)

NB. =========================================================
pdfmark_times=: 4 : 0
s=. _1 + 3 * x
p=. y
r=. (p - s) ,. p + s
s=. (p +"1 s * 1 _1) ,. p +"1 s * _1 1
pbuf (":PDF_PENSCALE * 5 * x) , ' w '
pbuf (pdf_makelines r,s) ,"1 ' b'
)

NB. =========================================================
pdfmark_triangle=: 4 : 0
p=. 6 $"1 y
d=. (4 * x) * , (sin,.cos) 2p1 * 0 1 2 % 3
p=. p +"1 d
pbuf (pdf_makelines p) ,"1 ' b'
)
NB. build

NB. =========================================================
NB. fonts
PDF_FONTOBJ=: 0 : 0
<<
/Type /Font
/Subtype /Type1
/Name /FXX
>>
)

NB. =========================================================
PDF_TRAILER=: 0 : 0
trailer
<<
/Size {z}
/Info 1 0 R
/Root 2 0 R
>>
startxref
)

NB. =========================================================
NB. build
NB.  1 Info
NB.  2 Catalog
NB.  3+ Fonts
NB.  +4 Pages
NB.  +5 Page
NB.  +6 Content
NB.
NB. pdf_wrap adds:
NB.  Xref
NB.  Trailer
pdf_build=: 3 : 0
PDFFontpages=: pdf_fontpages ''
pdf_wrap (pdf_header''),pdf_page y
)

NB. =========================================================
NB. pdf_creationdate
pdf_creationdate=: 3 : 0
t=. '20', ; _2 {.each '0' ,each ": each <. 6!:0''
'/CreationDate (D:',t,')'
)

NB. =========================================================
pdf_cidfont=: 4 : 0
txt=. LF;<;.2 ". toupper y -. '-'
msk=. 1 = #&> txt
txt=. msk<@;;._1 txt
txt=. (<'<<',LF) ,each txt ,each <'>>',LF
'a b c'=. txt
prev=. x { 3 + 0 0, +/\PDFFontpages
b=. b rplc '%prev';":prev
c=. c rplc '%prev';":prev+1
c=. c rplc '/Name /F';'/Name /F',":x
a;b;c
)

NB. =========================================================
NB. fonts
pdf_fonts=: 3 : 0
ndx=. 1 i.~ 'XX' E. PDF_FONTOBJ
hdr=. ndx {. PDF_FONTOBJ
ftr=. (ndx+2) }. PDF_FONTOBJ
r=. ''
for_f. PDFFonts do.
  if. f e. CIDFONTS do.
    r=. r, ( 1+f_index) pdf_cidfont >f
  else.
    fnt=. (": 1 + f_index),LF,'/BaseFont /', >f
    fnt=. fnt,LF,'/Encoding /WinAnsiEncoding'
    r=. r, <hdr, fnt, ftr
  end.
end.
)

NB. =========================================================
NB. count of pages used for fonts
NB. each cid font use 3 obj
pdf_fontpages=: 3 : 0
1 + 2 * PDFFonts e. CIDFONTS
)

NB. =========================================================
pdf_header=: 3 : 0
t=. '/Title (Plot)'
a=. '/Author (',(9!:14''),')'
p=. '/Producer (J Plot)'
d=. pdf_creationdate''
tit=. pdf_dict t;a;p;d
pag=. ": 3 + +/ PDFFontpages
cat=. pdf_dict '/Type /Catalog',LF,'/Pages ',pag,' 0 R',LF
fnt=. pdf_fonts ''
tit;cat;fnt
)

NB. =========================================================
NB. pdf_pages
pdf_page=: 3 : 0
kp=. 4 + +/ PDFFontpages
r=. '/Type /Pages',LF
r=. r, pdf_pageheader''
r=. r, '/MediaBox [',(pfmt Pxywh),']',LF
r=. r,'/Kids [',(":kp),' 0 R]',LF
r=. r, '/Count 1',LF
res=. pdf_dict r

NB. ---------------------------------------------------------
r=. '/Type /Page',LF
r=. r,'/Parent ',(":kp-1),' 0 R',LF
r=. r,'/Contents ',(":kp+1),' 0 R',LF
res=. res ; pdf_dict r

NB. ---------------------------------------------------------
t=. y
s=. '<< /Length ',(":#t),' >>',LF
res ,< s,'stream',LF,t,'endstream',LF
)

NB. =========================================================
NB. pdf_pages header
pdf_pageheader=: 3 : 0
r=. '/Resources',LF,'<<',LF,' /ProcSet [/PDF /Text]',LF
r=. r,' /Font <<',LF
fx=. ' /F'&, &> ": each 1 + i.#PDFFonts
px=. ' ',. ": &> 2 + +/\ PDFFontpages
r=. r, ,fx ,"1 px ,"1 ' 0 R',LF
r=. r,' >>',LF,'>>',LF
)

NB. =========================================================
pdf_wrap=: 3 : 0
z=. ": 1 + #y
r=. '%PDF-1.3',LF
r=. r, '%', (a. {~128 + a. i. 'elmo'),LF

NB. ---------------------------------------------------------
NB. note the xref section must have exactly 20 characters
NB. per line - otherwise Adobe rebuilds the xref when
NB. the file is loaded
s=. 'xref',LF,'0 ',z,LF
s=. s,(10#'0'),' 65535 f ',LF

for_i. i.#y do.
  s=. s,(_10 {.!.'0' ": #r),' 00000 n ',LF
  c=. LF,(>i{y)
  r=. r,(":1+i),' 0 obj',c,'endobj',LF,LF
end.

NB. ---------------------------------------------------------
ndx=. I. '{z}' E. PDF_TRAILER
tr=. (ndx {. PDF_TRAILER), z, (ndx+3) }. PDF_TRAILER
r,s,LF,tr,(":#r),LF,'%%EOF'
)
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
