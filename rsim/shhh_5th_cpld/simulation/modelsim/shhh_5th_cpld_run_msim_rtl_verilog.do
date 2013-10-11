transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Dropbox/Electronics/VHS/SHBHH-5th/shhh_5th_cpld {C:/Dropbox/Electronics/VHS/SHBHH-5th/shhh_5th_cpld/shhh_5th_cpld.v}

