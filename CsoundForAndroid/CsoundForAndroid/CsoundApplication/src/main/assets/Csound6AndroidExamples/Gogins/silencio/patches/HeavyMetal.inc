gk_HeavyMetal_level init 0
instr HeavyMetal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Author: Perry Cook and John ffitch
; Adapted by: Michael Gogins
if p3 == -1 then
  p3 = 1000000
endif
i_instrument = p1
i_time = p2
i_duration = p3
i_midi_key = p4
i_midi_velocity = p5
k_space_front_to_back = p6
k_space_left_to_right = p7
k_space_bottom_to_top = p8
i_phase = p9
i_overall_amps = (135 - 67) + 6
i_normalization = ampdb(-i_overall_amps) / 2
i_amplitude = ampdb(i_midi_velocity) * i_normalization
i_frequency = cpsmidinn(i_midi_key)
k_gain = ampdb(gk_HeavyMetal_level)
iindex = 1.1
icrossfade = 2
ivibedepth = 0.02
iviberate = 4.8
isine ftgenonce 0, 0, 65536, 10, 1
icosine ftgenonce 0, 0, 65536, 11, 1
iexponentialrise ftgenonce 0, 0, 65536, 5, .001, 513, 1 ; Exponential rise.
ithirteen ftgenonce 0, 0, 65536, 9, 1, .3, 0
ifn1 = isine
ifn2 = iexponentialrise
ifn3 = ithirteen
ifn4 = isine
ivibefn = icosine
iattack = 0.003
idecay = 3.0
isustain = p3
irelease = 0.05
adecay transeg 0.0, iattack, -4, 1.0, idecay, -4, 0.1, isustain, -4, 0.1, irelease, -4, 0.0
asignal fmmetal 1.0, i_frequency, iindex, icrossfade, ivibedepth, iviberate, ifn1, ifn2, ifn3, ifn4, ivibefn
adeclick linsegr 0, iattack, 1, isustain, 1, irelease, 0
a_signal = asignal * adeclick * i_amplitude * k_gain
i_attack = .002
i_sustain = p3
i_release = 0.01
p3 = i_attack + i_sustain + i_release
a_declicking linsegr 0, i_attack, 1, i_sustain, 1, i_release, 0
a_signal = a_signal * i_amplitude * a_declicking * k_gain
#ifdef USE_SPATIALIZATION
a_spatial_reverb_send init 0
a_bsignal[] init 16
a_bsignal, a_spatial_reverb_send Spatialize a_signal, k_space_front_to_back, k_space_left_to_right, k_space_bottom_to_top
outletv "outbformat", a_bsignal
outleta "out", a_spatial_reverb_send
#else
a_out_left, a_out_right pan2 a_signal, k_space_left_to_right
outleta "outleft", a_out_left
outleta "outright", a_out_right
#endif
prints "HeavyMetal     i %9.4f t %9.4f d %9.4f k %9.4f v %9.4f p %9.4f #%3d\n", p1, p2, p3, p4, p5, p7, active(p1)
endin