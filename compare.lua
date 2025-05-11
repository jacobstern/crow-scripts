-- compare.lua

s = sequins
d = ii.wdel

trans_bag = {0, 0, 0, 0, 0, 0, 0, -7/12, 5/12, 12/12, -2/12}
count = 0
trans_frequency = 1

function init()
  ii.wdel.mix(-4.8)
  ii.wdel.feedback(-3)
  ii.wdel.filter(100)
  ii.wdel.time(0.5)
  ii.wdel.mod_rate(-5)
  ii.wdel.mod_amount(0.25)

  input[1].mode('change')
  input[1].change = function (on)
    if on then
      output[1](lfo(.21, 1/12, 'linear'))
      count = count + 1
      if count % trans_frequency == 0 then
        output[2].volts = trans_bag[math.random(#trans_bag)]
      else
        output[2].volts = 0
      end
    else
      output[1].volts = 0
    end
  end
end

