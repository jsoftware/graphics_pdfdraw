NB. main

Title=: 'GWh / month'
SubTitle=: ''

NB. =========================================================
Begin=: 7 13
End=: 12 15

NB. =========================================================
Names=: cutopen 0 : 0
Biofuels
Others
Natural Gas
Peat
Oil
Coal
Total
Electricity Exports
)

d=. 1 0.1 0.2 0.2 0.05 0.9 0.2 * 500+?. 7 26$702
d=. <. d *"1[ 1 + | 1 o. 2p1 * (i.26)%24
e=. {:d
d=. }:d
Data=: d,(+/d),:e

NB. =========================================================
NB. builds pdf and jpf files
rundemo=: 3 : 0
'Rws Cls'=: $Data
b=. +/ 1 12 * Begin - 1 0
e=. +/ 1 12 * End - 1 0
Months=: |."1[ 0 1 +"1 [ 0 12 #: b + i. 1 + e - b
MonthLen=: #Months
draw''
f=. jpath '~Addons/graphics/pdfdraw/source/publish/pdfdraw1.jpf'
(buildjpf buf) fwritenew f
f=. jpath '~temp/pdfdraw.pdf'
(buildpdf buf) fwritenew f
viewpdf_j_ f
)
