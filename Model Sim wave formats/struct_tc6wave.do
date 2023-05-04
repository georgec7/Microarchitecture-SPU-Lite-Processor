onerror {resume}
quietly WaveActivateNextPane {} 0
WaveRestoreCursors {{Cursor 1} {165 ns} 0} {{Cursor 2} {245 ns} 0} {{Cursor 3} {112 ns} 1}
quietly wave cursor active 1
configure wave -namecolwidth 267
configure wave -valuecolwidth 56
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {113 ns} {209 ns}
