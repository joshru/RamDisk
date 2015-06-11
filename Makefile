# Comment/uncomment the following line to disable/enable debugging
# DEBUG = y


# Add your debugging flag (or not) to CFLAGS
ifeq ($(DEBUG),y)
  DEBFLAGS = -O -g -DSBULL_DEBUG # "-O" is needed to expand inlines
else
  DEBFLAGS = -O2
endif

ccflags-y += $(DEBFLAGS)
ccflags-y += -I..

ifneq ($(KERNELRELEASE),)
# call from kernel build system

#
# FIXME - Change this to follow your naming convention.  
obj-m	:= rd-uwt.o
obj-m	+= rd-uwt.o
# obj-m := rdtest.o
# obj-m := sculld.o

else

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
#KERNELDIR ?= /lib/modules/3.11.0/build
# FIXME - Change this for you kernel version you are building against or  uname -r
# KERNELDIR ?= /lib/modules/3.19/build
PWD       := $(shell pwd)

default:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

endif

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions

depend .depend dep:
	$(CC) $(CFLAGS) -M *.c > .depend


ifeq (.depend,$(wildcard .depend))
include .depend
endif
