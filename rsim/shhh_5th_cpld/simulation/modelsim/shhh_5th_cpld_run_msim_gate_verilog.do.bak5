transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {shhh_5th_cpld.vo}

vlog -vlog01compat -work work +incdir+C:/Dropbox/Electronics/VHS/SHBHH-5th/shhh_5th_cpld {C:/Dropbox/Electronics/VHS/SHBHH-5th/shhh_5th_cpld/shhh_5th_cpld_tb.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L maxv_ver -L gate_work -L work -voptargs="+acc"  shhh_5th_cpld_tb

add wave *
view structure
view signals
run -all
