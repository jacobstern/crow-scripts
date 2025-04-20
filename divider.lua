divisors = {2, 5, 11, 17}
count = 0

input[1].change = function(d)
  if d then
    for i = 1,4 do
      if count % divisors[i] == 0 then
        output[i].volts = 5
      end
    end
    count = count + 1
  else
    for o = 1,4 do
      output[o].volts = 0
    end
  end
end

input[2].change = function()
  count = 0
end

function init()
  input[1]{
    mode = 'change',
    direction = 'both',
    threshold = 2,
  }
  input[2]{
    mode = 'change',
    direction = 'rising',
    threshold = 2,
  }
end
