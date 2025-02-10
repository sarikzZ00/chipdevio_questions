STD_CELLS = /afs/umich.edu/class/eecs627/ibm13/artisan/2005q3v1/aci/sc-x/verilog/ibm13_neg.v
TESTBENCH = simple_router_tb.sv
SIMFILES = simple_router.sv


VV         = vcs
VVOPTS     = -o $@ +v2k +vc -sverilog -timescale=1ns/1ps +vcs+lic+wait +multisource_int_delays                    \
	       	+neg_tchk +incdir+$(VERIF) +plusarg_save +overlap +warn=noSDFCOM_UHICD,noSDFCOM_IWSBA,noSDFCOM_IANE,noSDFCOM_PONF -full64 -cc gcc +libext+.v+.vlib+.vh 

ifdef WAVES
VVOPTS += +define+DUMP_VCD=1 +memcbk +vcs+dumparrays +sdfverbose
endif

ifdef GUI
VVOPTS += -gui
endif


sim:
	$(VV) $(VVOPTS) +define+SIM=1 $(STD_CELLS) $(SIMFILES) $(TESTBENCH); ./$@


clean:
	rm -f ucli.key
	rm -f sim
	rm -f sim_synth
	rm -fr sim.daidir
	rm -fr sim_synth.daidir
	rm -f *.log
	rm -fr csrc

simvision:
	simvision simple_router.dump
