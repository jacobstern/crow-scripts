-- dreammachine.lua

function intro()
  output[3].volts = 2.5
  output[2].volts = -1
  output[4].volts = 1
end

function body()
  output[3].volts = 0
  output[2].volts = 0
  output[4].volts = 0
end

function outro()
  output[3].volts = 6.5
  output[2].volts = -.5
  output[4].volts = 2.5
end

function random_sample()
  output[1].volts = math.random() * 5.0
end

function init()
  input[1]{ mode = 'change', threshold = 2.0, direction = 'rising' }
  input[1].change = random_sample
  
  output[2].slew = 1.75
  output[3].slew = 2.25
  output[4].slew = 0

  intro()
end

