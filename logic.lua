-- logic.lua

s = sequins
ws = ii.wsyn

vseq = s{5, 3, 4, 5, 3.5}
transpose = {0, 1, 5/12, 1}
chord = {nil, nil, nil}

function play_synth()
  volts = vseq()
  t = transpose[math.random(#transpose)]
  note = input[2].volts 
  ws.play_note(note + t, volts)
end

function trigger(on)
  if on then
    play_synth()
  end
end

function init()
  output[1](lfo(15))

  input[1].mode('change', 2.0)
  input[1].change = trigger

  ws.fm_index(1.5)
  ws.fm_ratio(2)
  ws.ar_mode(1)
  ws.lpg_time(-2)
end
