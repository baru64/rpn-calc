IVERILOG = iverilog
VVP = vvp
<<<<<<< HEAD
module = onp
=======
module = alu
>>>>>>> alu-dev

default:
	@echo "-- COMPILATION -------------"
	$(IVERILOG) -o $(module)_sim $(module)_tb.v $(module).v stack.v
	@echo "-- RUN ---------------------"
	$(VVP) -n $(module)_sim 
	@echo "-- DONE --------------------"
