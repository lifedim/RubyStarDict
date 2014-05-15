MODULE = lookup

lib$(MODULE).so : $(MODULE).c
	gcc -shared -lz -o lib$(MODULE).so $(MODULE).c

clean:
	rm -f lib$(MODULE).so

