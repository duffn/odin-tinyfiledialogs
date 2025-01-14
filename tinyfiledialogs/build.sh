#!/bin/bash

case $(uname) in
"Darwin")
	case $(uname -m) in
	"arm64") lib_path="macos-arm64" ;;
	*) lib_path="macos" ;;
	esac

	# Static
	clang -c -o tinyfiledialogs.o tinyfiledialogs.c -fPIC
	ar r tinyfiledialogs.a tinyfiledialogs.o
	rm tinyfiledialogs.o
	mv tinyfiledialogs.a $lib_path/tinyfiledialogs.a

	# Shared
	clang -dynamiclib -undefined dynamic_lookup -o tinyfiledialogs.dylib tinyfiledialogs.c
	mv tinyfiledialogs.dylib $lib_path/tinyfiledialogs.dylib
	;;
*)
	gcc -c tinyfiledialogs.c -o linux/tinyfiledialogs.o
	ar rcs linux/tinyfiledialogs.a linux/tinyfiledialogs.o
	gcc -fPIC -shared tinyfiledialogs.c -o linux/tinyfiledialogs.so
	rm linux/tinyfiledialogs.o
	;;
esac
