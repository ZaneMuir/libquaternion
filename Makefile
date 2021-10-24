export WORKDIR="./src"

compile:
	gcc -c -I $(WORKDIR) $(WORKDIR)/*.c

library:
	gcc -shared -o libquaternion.so *.o

clean:
	rm -f *.o
	rm -f *.so