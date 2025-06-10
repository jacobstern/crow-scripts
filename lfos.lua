-- lfos.lua

function init()
  output[1](lfo(55))
  output[2](lfo(35, 2.5))
  output[3](lfo(35, 5, 'square'))
end
