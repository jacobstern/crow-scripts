-- airports.lua 

s = sequins
d = ii.wdel

function init()
  output[1](lfo(10.5))
  ii.wdel.mix(1)
  ii.wdel.feedback(0.2)
  ii.wdel.filter(1000)
  ii.wdel.time(.8)
end

