-- logic.lua

s = sequins
ins = {false, false}

function init()
  output[1](lfo(15))
  output[3].volts = 5

  for i=1,2 do
    input[i].mode('change', 2.0)
    input[i].change = function (on)
      ins[i] = on
      xor = ins[1] ~= ins[2]
      if xor then
        output[2].volts = 8
      else
        output[2].volts = 0
      end
    end
  end
end
