onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Fetch
add wave -noupdate /tb_part2/dut/fetch1/clock
add wave -noupdate /tb_part2/dut/fetch1/reset
add wave -noupdate /tb_part2/dut/fetch1/ins1
add wave -noupdate /tb_part2/dut/fetch1/ins2
add wave -noupdate -divider Decode
add wave -noupdate /tb_part2/dut/decode1/opcode_ep
add wave -noupdate /tb_part2/dut/decode1/opcode_op
add wave -noupdate /tb_part2/dut/decode1/stall
add wave -noupdate /tb_part2/dut/decode1/stall_done
add wave -noupdate /tb_part2/dut/decode1/stall_done_r
add wave -noupdate /tb_part2/dut/decode1/raw_haz_ins1
add wave -noupdate /tb_part2/dut/decode1/struct_haz_ins2
add wave -noupdate /tb_part2/dut/decode1/waw_haz_ins2
add wave -noupdate /tb_part2/dut/decode1/raw_haz_ins2
add wave -noupdate /tb_part2/dut/decode1/ra_addr_ins1
add wave -noupdate /tb_part2/dut/decode1/fw_op_01_addr
add wave -noupdate /tb_part2/dut/decode1/fw_op_02_addr
add wave -noupdate /tb_part2/dut/decode1/fw_op_03_addr
add wave -noupdate /tb_part2/dut/decode1/fw_op_04_addr
add wave -noupdate /tb_part2/dut/decode1/fw_op_05_addr
add wave -noupdate /tb_part2/dut/decode1/fw_op_06_addr
add wave -noupdate /tb_part2/dut/decode1/fw_op_07_addr
add wave -noupdate /tb_part2/dut/decode1/out_op_rt_addr
add wave -noupdate -divider {Register Forward}
add wave -noupdate /tb_part2/dut/rf1/ra_addr_ep_r
add wave -noupdate /tb_part2/dut/rf1/fw_op_02_data
add wave -noupdate /tb_part2/dut/rf1/fw_op_03_data
add wave -noupdate /tb_part2/dut/rf1/fw_op_04_data
add wave -noupdate /tb_part2/dut/rf1/fw_op_05_data
add wave -noupdate /tb_part2/dut/rf1/fw_op_06_data
add wave -noupdate /tb_part2/dut/rf1/fw_op_07_data
add wave -noupdate /tb_part2/dut/rf1/out_op_rt_data
add wave -noupdate -divider {Even Pipe Stage 1}
add wave -noupdate /tb_part2/dut/e1/ra
add wave -noupdate -divider {Register File}
add wave -noupdate /tb_part2/dut/r1/wrbe_ep
add wave -noupdate /tb_part2/dut/r1/wrbe_op
add wave -noupdate /tb_part2/dut/r1/reg_file_mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {85 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 258
configure wave -valuecolwidth 38
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
WaveRestoreZoom {30 ns} {120 ns}
