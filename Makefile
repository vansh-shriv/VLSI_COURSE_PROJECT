IVERILOG = iverilog
VVP = vvp

all: simulate

simulate: mult.out
	$(VVP) mult.out

mult.out: src/multiplier_array.v tb/tb_multiplier.v
	$(IVERILOG) -o mult.out src/multiplier_array.v tb/tb_multiplier.v

clean:
	rm -f mult.out vvp.log
