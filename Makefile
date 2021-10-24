WORKDIR := "./src"
ifeq ($(PREFIX),)
	PREFIX := /usr/local
endif

compile:
	gcc -c -I $(WORKDIR) $(WORKDIR)/*.c

library:
	gcc -shared -o libquaternion.so *.o

all: compile library

install: all
	install -d $(PREFIX)/lib/
	install -m 644 libquaternion.so $(PREFIX)/lib/
	install -d $(PREFIX)/include/
	install -m 644 $(WORKDIR)/quaternion.h $(PREFIX)/include/

uninstall:
	rm -f $(PREFIX)/lib/libquaternion.so
	rm -f $(PREFIX)/include/quaternion.h

clean:
	rm -f *.o
clear: clean
	rm -f *.so