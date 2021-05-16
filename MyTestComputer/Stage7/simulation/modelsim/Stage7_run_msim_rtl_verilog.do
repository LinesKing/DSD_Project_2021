transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/cassi/Desktop/verilog\ code/MyTestComputer/Stage7 {C:/Users/cassi/Desktop/verilog code/MyTestComputer/Stage7/MyComputer.v}
vlog -vlog01compat -work work +incdir+C:/Users/cassi/Desktop/verilog\ code/MyTestComputer/Stage7 {C:/Users/cassi/Desktop/verilog code/MyTestComputer/Stage7/AuxMod.v}
vlog -vlog01compat -work work +incdir+C:/Users/cassi/Desktop/verilog\ code/MyTestComputer/Stage7 {C:/Users/cassi/Desktop/verilog code/MyTestComputer/Stage7/ROM.v}
vlog -vlog01compat -work work +incdir+C:/Users/cassi/Desktop/verilog\ code/MyTestComputer/Stage7 {C:/Users/cassi/Desktop/verilog code/MyTestComputer/Stage7/CPU.v}

vlog -vlog01compat -work work +incdir+C:/Users/cassi/Desktop/verilog\ code/MyTestComputer/Stage7 {C:/Users/cassi/Desktop/verilog code/MyTestComputer/Stage7/testS7.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  testS7

add wave *
view structure
view signals
run -all
