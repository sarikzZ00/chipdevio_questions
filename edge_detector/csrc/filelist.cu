LDVERSION= $(shell $(PIC_LD) -v | grep -q 2.30 ;echo $$?)
ifeq ($(LDVERSION), 0)
     LD_NORELAX_FLAG= --no-relax
endif

ARCHIVE_OBJS=
ARCHIVE_OBJS += _2103315_archive_1.so
_2103315_archive_1.so : archive.0/_2103315_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -Bsymbolic $(LD_NORELAX_FLAG)  -o .//../sim.daidir//_2103315_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../sim.daidir//_2103315_archive_1.so $@




VCS_CU_ARC_OBJS = 


O0_OBJS =

$(O0_OBJS) : %.o: %.c
	$(CC_CG) $(CFLAGS_O0) -c -o $@ $<


%.o: %.c
	$(CC_CG) $(CFLAGS_CG) -c -o $@ $<
CU_UDP_OBJS = \
objs/udps/exIG1.o objs/udps/Cpxa2.o objs/udps/uYEPC.o objs/udps/D2wHf.o objs/udps/IEZrF.o  \
objs/udps/vCfas.o objs/udps/U7Vwg.o objs/udps/CjLsY.o objs/udps/gSqMj.o objs/udps/i2VqJ.o  \
objs/udps/sk4QJ.o objs/udps/AubIW.o 

CU_LVL_OBJS = \
SIM_l.o 

MAIN_OBJS = \
objs/amcQw_d.o 

CU_OBJS = $(MAIN_OBJS) $(ARCHIVE_OBJS) $(CU_UDP_OBJS) $(CU_LVL_OBJS)

