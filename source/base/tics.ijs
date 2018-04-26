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
