-- patch_25apr2025.lua

s = sequins
transpose = 6

tape = s{
  {0, 6, 1.5},
  {5, 5, .75},
  {{7, 12}, 4, 7.75},
}

fake_delay_fb = .45

function fake_delay(pitch, vel)
  for i = 1,3 do
    vel = vel * (fake_delay_fb + math.random() * .1 - .05)
    clock.sleep(0.41)
    do_play_note(pitch, vel)
  end
end

function do_play_note(pitch, vel)
  if type(pitch) == 'table' then
    for _, p in ipairs(pitch) do
      ii.wsyn.play_note((p + transpose) / 12, vel)
    end
  else
    ii.wsyn.play_note((pitch + transpose) / 12, vel)
  end
end

function play_note(pitch, vel)
  do_play_note(pitch, vel)
  clock.run(fake_delay, pitch, vel)
end

function play_chord(pitches, vel)
  for _, pitch in ipairs(pitches) do
    ii.wsyn.play_note((pitch + transpose) / 12, vel)
  end
end

function do_voice()
  while true do
    note, vel, duration = table.unpack(tape())
    if vel > 0 then
      play_note(note, vel)
    end
    clock.sync(duration)
  end
end

function init()
  output[1].action = lfo(10.5)
  output[1]()

  voice_coro = clock.run(do_voice)
  ii.wsyn.ar_mode(1)
  ii.wsyn.lpg_time(-1.8)
  ii.wsyn.fm_index(0.8)
  ii.wsyn.fm_env(1.2)
  ii.wsyn.fm_ratio(4)
end
