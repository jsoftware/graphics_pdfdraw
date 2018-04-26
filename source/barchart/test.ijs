NB. test data for barchart (from Barchester)

Titles=: cutopen 0 : 0
Barchester Towers
Doctor Thorne
Framley Parsonage
The Small House at Allington
The Vicar of Bullhampton
Sir Harry Hotspur of Humblethwaite
)

SubTitles=: 6 {. 'Chronicles of Barsetshire '&, each ;:'II III IV V'

Places=: cutopen 0 : 0
Hoggle End
Pomfret Madrigal
Gatherum Castle
Silverbridge
Plumsted Episcopi
Uffley
)

People=: cutopen 0 : 0
Josiah Crawley
Theophilus Grantly
Frank Arabin
Grace Crawley
Lily Dale
)

NB. =========================================================
gentest=: 3 : 0
deal=. (# ? #) :(? #) { ]
t=. ?#Titles
title=. t pick Titles
subtitle=. t pick SubTitles
ycaption=. 0 pick 1 deal 'Names';'Dramatis Personæ';'Cast'
cols=. (3+?+_3+#Places) {.deal Places
keys=. (3+?+_3+#People) {.deal People
vals=. 0.01 * (1+?10) * 10+?((#keys),#cols)$200
title;subtitle;ycaption;cols;keys;vals
)
