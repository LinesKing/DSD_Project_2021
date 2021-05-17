transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/leqin/DSD_Project_2021/MyTestRPN {C:/Users/leqin/DSD_Project_2021/MyTestRPN/MyComputer.v}
vlog -vlog01compat -work work +incdir+C:/Users/leqin/DSD_Project_2021/MyTestRPN {C:/Users/leqin/DSD_Project_2021/MyTestRPN/AuxMod.v}
vlog -vlog01compat -work work +incdir+C:/Users/leqin/DSD_Project_2021/MyTestRPN {C:/Users/leqin/DSD_Project_2021/MyTestRPN/ROM.v}
vlog -vlog01compat -work work +incdir+C:/Users/leqin/DSD_Project_2021/MyTestRPN {C:/Users/leqin/DSD_Project_2021/MyTestRPN/CPU.v}

vlog -vlog01compat -work work +incdir+C:/Users/leqin/DSD_Project_2021/MyTestRPN {C:/Users/leqin/DSD_Project_2021/MyTestRPN/TestCalc.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  TestCalc

add wave *
view structure
view signals
run -all
