--- patch 4
presets = {
  [1] = {
    volts = {0, 5, 0, 5},
    route = {
      {1, 0, 0, 0, 0, 0},
      {0, 0, 0, 1, 0, 0},
    }
  },
  [2] = {
    volts = {5, 0, 5, 0},
    route = {
      {1, 0, 0, 0, 1, 0},
      {0, 0, 0, 1, 0, 0},
    }
  }
}
default_preset = 1

route = {
  {0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0},
}
held_note = {0, 0, 0, 0, 0, 0}
current_preset = 0

function print_preset(p)
  for o = 1,4 do
    print(p.volts[o])
  end
  for i = 1,2 do
    local r = ""
    for j = 1,6 do
      if p.route[i][j] == 1 then
        r = r .. "X"
      else
        r = r .. ","
      end
    end
    print(r)
  end
end

function print_current_preset()
  p = presets[current_preset]
  if p == nil then
    return
  end
  print_preset(p)
end

function preset(n)
  p = presets[n]
  if p == nil then
    return
  end
  for o = 1,4 do
    output[o].volts = p.volts[o]
  end
  route = p.route
  current_preset = n
  print_preset(p)
end

x = preset

function init()
  for i = 1,2 do
    input[i]{
      mode = 'change',
      direction = 'both',
      threshold = 2,
    }
  end

  if default_preset > 0 then
    preset(default_preset)
  end
end

function trigger_high(i)
  for j = 1,6 do
    if route[i][j] == 1 and held_note[j] == 0 then
      ii.jf.trigger(j, 1)
      held_note[j] = i
    end
  end
end

function trigger_low(i)
  for j = 1,6 do
    if held_note[j] == i then
      ii.jf.trigger(j, 0)
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

