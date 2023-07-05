# CC=g++
CC=clang++
CDEFINES=
SOURCES=Dispatcher.cpp Mode.cpp precomp.cpp profanity.cpp SpeedSample.cpp
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=profanity2.exe

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	LDFLAGS=-framework OpenCL
	CFLAGS=-c -std=c++17 -Wall -mmmx -O2
else
	LDFLAGS=-s -lOpenCL -mcmodel=large -L.\OpenCL-Wrapper\src\OpenCL\lib
	CFLAGS=-c -std=c++17 -Wall -mmmx -O2 -mcmodel=large -I.\OpenCL-Wrapper\src\OpenCL\include
endif

all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $(CDEFINES) $< -o $@

clean:
	rm -rf *.o

