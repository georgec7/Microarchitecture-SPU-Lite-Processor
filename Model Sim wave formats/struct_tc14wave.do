onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Fetch
add wave -noupdate /tb_part2/dut/fetch1/clock
add wave -noupdate /tb_part2/dut/fetch1/ins1
add wave -noupdate /tb_part2/dut/fetch1/ins2
add wave -noupdate -radix decimal /tb_part2/dut/fetch1/pc_out
add wave -noupdate -divider Decode
add wave -noupdate /tb_part2/dut/decode1/opcode_ep
add wave -noupdate /tb_part2/dut/decode1/opcode_op
add wave -noupdate /tb_part2/dut/decode1/stall_done_r
add wave -noupdate /tb_part2/dut/decode1/raw_haz_ins1
add wave -noupdate /tb_part2/dut/decode1/struct_haz_ins2
add wave -noupdate /tb_part2/dut/decode1/waw_haz_ins2
add wave -noupdate /tb_part2/dut/decode1/raw_haz_ins2
add wave -noupdate /tb_part2/dut/decode1/stall
add wave -noupdate /tb_part2/dut/decode1/clear
add wave -noupdate -divider {Odd Pipe}
add wave -noupdate /tb_part2/dut/o1/pc_out
add wave -noupdate /tb_part2/dut/o1/flush
add wave -noupdate -divider {Register File}
add wave -noupdate /tb_part2/dut/r1/wrbe_op
add wave -noupdate /tb_part2/dut/r1/reg_file_mem
add wave -noupdate /tb_part2/dut/e1/rt_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {65 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 136
configure wave -valuecolwidth 275
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ns} {86 ns}
