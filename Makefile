IVERILOG = iverilog
VVP = vvp
module = onp

default:
	@echo "-- COMPILATION -------------"
	$(IVERILOG) -o $(module)_sim $(module)_tb.v $(module).v stack.v
	@echo "-- RUN ---------------------"
	$(VVP) -n $(module)_sim 
	@echo "-- DONE --------------------"
