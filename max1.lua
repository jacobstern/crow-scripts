--- max1.lua
route = {
  {0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0},
}
held_note = {0, 0, 0, 0, 0, 0}

function init()
  for i = 1,2 do
    input[i]{
      mode = 'change',
      direction = 'both',
      threshold = 2,
    }
  end
end

function trigger_high(i)
  for j = 1,6 do
    volts = route[i][j]
    if volts > 0 and held_note[j] == 0 then
      ii.jf.vtrigger(j, volts)
      held_note[j] = i
    end
  end
end

function trigger_low(i)
  for j = 1,6 do
    if held_note[j] == i then
      ii.jf.vtrigger(j, 0)
      held_note[j] = 0
    end
  end
end

for i = 1,2 do
  input[i].change = function(d)
    if d then
      trigger_high(i)
    else
      trigger_low(i)
    end
  end
end

