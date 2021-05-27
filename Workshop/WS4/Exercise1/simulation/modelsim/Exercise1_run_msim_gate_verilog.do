transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {Exercise1_6_1200mv_85c_slow.vo}

vlog -vlog01compat -work work +incdir+C:/Users/cassi/Desktop/verilog\ code/WS4/Exercise1 {C:/Users/cassi/Desktop/verilog code/WS4/Exercise1/test_MyMult.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  test_MyMult1

add wave *
view structure
view signals
run -all
