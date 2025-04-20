--- hocket.lua

hocket = 1

input[2].change = function()
  output[hocket * 2 - 1].volts = input[1].volts
  output[hocket * 2]()
  hocket = 3 - hocket
end

function init()
  input[2]{ mode = 'change'
          , direction = 'rising'
          , threshold = 2
          }
  output[1].scale = {0,3,5,7,10}
  output[2].action = pulse()
  output[3].scale = {0,3,5,7,10}
  output[4].action = pulse()
end

