-- airports2.lua 

s = sequins
transpose = 6

tape = s{
  {{-2, 0, 2,  5}, 2.5, 1},
  {{5, 7, 12}, 3, 15},
  {{-2, 0, 2,  5}, 2.5, 1},
  {{5, 7, 12}, 3, 21},
}
fm_index_seq = s{1.2, 1.3, 1.1, 0.8, 1.0}

function play_chord(pitches, vel)
  for _, pitch in ipairs(pitches) do
    ii.wsyn.play_note((pitch + transpose) / 12, vel)
  end
end

rests = 0

function do_voice()
  while true do
    ii.wsyn.fm_index(fm_index_seq())
    pitches, vel, duration = table.unpack(tape())
    play_chord(pitches, vel)
    rests = duration

    while rests > 0 do
      clock.sync(1/4)
      rests = rests - 1
    end
  end
end

function init()
  input[1].mode('clock')

  output[1].action = lfo(10.5)
  output[1]()

  voice_coro = clock.run(do_voice)
  ii.wsyn.ar_mode(1)
  ii.wsyn.lpg_time(-2.25)
  ii.wsyn.fm_env(1.2)
  ii.wsyn.fm_ratio(3)
end
