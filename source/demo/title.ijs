NB. title

NB. =========================================================
drawtitle=: 3 : 0
if. 0=#Title do. EMPTY return. end.

'w h'=. TitleFont pextent <Title
x=. Ax
y=. Gy + <. -: Gh - w
pdftext Title;TitleFont;0;Black;x,y

if. 0=#SubTitle do. EMPTY return. end.

x=. x + h
'w h'=. SubTitleFont pextent <SubTitle
y=. Gy + <. -: Gh - w
pdftext SubTitle;SubTitleFont;0;Black;x,y
)
