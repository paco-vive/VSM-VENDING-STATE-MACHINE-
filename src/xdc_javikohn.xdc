#--------pacok
set_property PACKAGE_PIN W16 [get_ports {SW_confirm}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SW_confirm}]

#-------pacok
set_property PACKAGE_PIN W5 [get_ports CLK]
	set_property IOSTANDARD LVCMOS33 [get_ports CLK]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK]

create_generated_clock -name clk_lento_1hz [get_pins U0_CLK_DIV/clk_internal_reg/Q] -source [get_ports CLK] -divide_by 50000000

#  ciclar el producto
set_property PACKAGE_PIN V17 [get_ports SW_PROD]
	set_property IOSTANDARD LVCMOS33 [get_ports SW_PROD]

# siguiente estado boton
set_property PACKAGE_PIN U18 [get_ports BTN_CONFIRM]
	set_property IOSTANDARD LVCMOS33 [get_ports BTN_CONFIRM]

# reset 
set_property PACKAGE_PIN V16 [get_ports RST_BTN]
	set_property IOSTANDARD LVCMOS33 [get_ports RST_BTN]

#1
set_property PACKAGE_PIN R2 [get_ports {BTN_MONEDAS[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {BTN_MONEDAS[0]}]

# 2 
set_property PACKAGE_PIN T1 [get_ports {BTN_MONEDAS[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {BTN_MONEDAS[1]}]

#  5 
set_property PACKAGE_PIN U1 [get_ports {BTN_MONEDAS[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {BTN_MONEDAS[2]}]

# 10 
set_property PACKAGE_PIN W2 [get_ports {BTN_MONEDAS[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {BTN_MONEDAS[3]}]



# a
set_property PACKAGE_PIN W7 [get_ports {SEG[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEG[6]}]
# b
set_property PACKAGE_PIN W6 [get_ports {SEG[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEG[5]}]
# c
set_property PACKAGE_PIN U8 [get_ports {SEG[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEG[4]}]
# d
set_property PACKAGE_PIN V8 [get_ports {SEG[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEG[3]}]
# e
set_property PACKAGE_PIN U5 [get_ports {SEG[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEG[2]}]
# f
set_property PACKAGE_PIN V5 [get_ports {SEG[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEG[1]}]
# g
set_property PACKAGE_PIN U7 [get_ports {SEG[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {SEG[0]}]
# unidadess
set_property PACKAGE_PIN U2 [get_ports {AN[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {AN[0]}]
# decenas
set_property PACKAGE_PIN U4 [get_ports {AN[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {AN[1]}]

set_property PACKAGE_PIN V4 [get_ports {AN[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {AN[2]}]

set_property PACKAGE_PIN W4 [get_ports {AN[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {AN[3]}]


set_property PACKAGE_PIN U16 [get_ports LED_OUT]
	set_property IOSTANDARD LVCMOS33 [get_ports LED_OUT]
set_property PACKAGE_PIN L1 [get_ports LEDXD]
	set_property IOSTANDARD LVCMOS33 [get_ports LEDXD]
	
set_property PACKAGE_PIN E19 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]

set_property PACKAGE_PIN U19 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]

set_property PACKAGE_PIN V19 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]

set_property PACKAGE_PIN W18 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]

set_property PACKAGE_PIN U15 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]

set_property PACKAGE_PIN U14 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]

set_property PACKAGE_PIN V14 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]

set_property PACKAGE_PIN V13 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]

set_property PACKAGE_PIN V3  [get_ports {led[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]

set_property PACKAGE_PIN W3  [get_ports {led[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]

set_property PACKAGE_PIN U3  [get_ports {led[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]

set_property PACKAGE_PIN P3  [get_ports {led[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]

set_property PACKAGE_PIN N3  [get_ports {led[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]

set_property PACKAGE_PIN P1  [get_ports {led[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]


