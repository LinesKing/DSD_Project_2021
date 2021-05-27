transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/cassi/Desktop/verilog\ code/Digital-System-Design-ELEN30010_2021_SM1/WS1/Exercise3 {C:/Users/cassi/Desktop/verilog code/Digital-System-Design-ELEN30010_2021_SM1/WS1/Exercise3/Exercise3.v}

