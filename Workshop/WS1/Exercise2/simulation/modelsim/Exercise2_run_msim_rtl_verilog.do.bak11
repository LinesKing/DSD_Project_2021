transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/cassi/Desktop/verilog\ code/Digital-System-Design-ELEN30010_2021_SM1/WS1/Exercise2 {C:/Users/cassi/Desktop/verilog code/Digital-System-Design-ELEN30010_2021_SM1/WS1/Exercise2/Exercise2.v}

vlog -vlog01compat -work work +incdir+C:/Users/cassi/Desktop/verilog\ code/Digital-System-Design-ELEN30010_2021_SM1/WS1/Exercise2 {C:/Users/cassi/Desktop/verilog code/Digital-System-Design-ELEN30010_2021_SM1/WS1/Exercise2/test_MyFruitBasket.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  test_MyFruitBasket

add wave *
view structure
view signals
run -all
