transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {N:/ECE124/Lab2/LogicalStep_Lab2_top.vhd}
vcom -93 -work work {N:/ECE124/Lab2/segment7_mux.vhd}
vcom -93 -work work {N:/ECE124/Lab2/SevenSegment.vhd}
vcom -93 -work work {N:/ECE124/Lab2/output_files/Adder.vhd}
vcom -93 -work work {N:/ECE124/Lab2/output_files/Concatenate.vhd}
vcom -93 -work work {N:/ECE124/Lab2/output_files/mux_1.vhd}
vcom -93 -work work {N:/ECE124/Lab2/output_files/Logic_Processor.vhd}
vcom -93 -work work {N:/ECE124/Lab2/output_files/mux_2.vhd}
vcom -93 -work work {N:/ECE124/Lab2/output_files/errorCheck.vhd}

