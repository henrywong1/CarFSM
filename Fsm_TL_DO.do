if {[file exists work]} {
	vdel -lib work -all
}
vlib work
vmap work work

### ---------------------------------------------- ###
### Compile code ###
### Enter files here; copy line for multiple files ###
vcom -work work [pwd]/fsm_tl.vhd

### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelEntity with the name of your top level entity (no .vhd) ###
### Do not duplicate! ###
vsim fsm_tl

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals ###
add wave *
### Force waves here ###

force clk 0 0, 1 50 -repeat 100
force reset 0 0, 1 1300
force L 0 0, 1 60
force R 0 0, 1 410
force H 0 0, 1 800, 0 1200
### ---------------------------------------------- ###
### Run simulation ###
### Do not modify ###
# to see your design hierarchy and signals 
view structure

# to see all signal names and current values
view signals

### ---------------------------------------------- ###
### Edit run time ###
run 1400 
