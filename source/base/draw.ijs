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
