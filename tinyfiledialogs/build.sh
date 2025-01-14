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
	mv tinyfiledialogs.a $lib_path/tinyfiledialogs.a
	rm tinyfiledialogs.o
	;;
*)
	gcc -c tinyfiledialogs.c -o linux/tinyfiledialogs.o
	ar rcs linux/tinyfiledialogs.a linux/tinyfiledialogs.o
	rm linux/tinyfiledialogs.o
	;;
esac
