# will find the current erlang include path
ERL_INCLUDE_PATH = $(shell erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)

CFLAGS += -I$(ERL_INCLUDE_PATH) -g -O3 -pedantic -Wall -Wextra -Wno-unused-parameter -Wno-unused-function
CFLAGS += -lraylib

ifneq ($(OS),Windows_NT)
	CFLAGS += -fPIC

	ifeq ($(shell uname),Darwin)
		LDFLAGS += -dynamiclib -undefined dynamic_lookup
	endif
endif

.PHONY: all pre clean

all: pre priv/raylib_core.so

pre:
	mkdir -p priv

clean:
	mix clean
	rm -r priv

priv/raylib_core.so: src/raylib_core.c
	$(CC) $(CFLAGS) -shared $(LDFLAGS) -o $@ src/raylib_core.c
