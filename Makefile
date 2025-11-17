IVERILOG = iverilog
VVP     = vvp
SRC_DIR = src
TB_DIR  = tb
OUT     = sim.out

# list sources explicitly to avoid missing files
SOURCES = $(SRC_DIR)/multiplier_wallace.v $(SRC_DIR)/csa3_16.v $(SRC_DIR)/full_adder.v $(SRC_DIR)/half_adder.v $(SRC_DIR)/mac_unit.v
TB      = $(TB_DIR)/tb_mac.v

all: run

$(OUT): $(SOURCES) $(TB)
	$(IVERILOG) -o $(OUT) $(SOURCES) $(TB)

run: $(OUT)
	$(VVP) $(OUT)

clean:
	-rm -f $(OUT) waves/*.vcd

.PHONY: all run clean
