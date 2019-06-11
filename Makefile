IVERILOG = iverilog
VVP = vvp
module = stack

default:
	@echo "-- COMPILATION -------------"
	$(IVERILOG) -o $(module)_sim $(module)_tb.v $(module).v
	@echo "-- RUN ---------------------"
	$(VVP) -n $(module)_sim 
	@echo "-- DONE --------------------"
