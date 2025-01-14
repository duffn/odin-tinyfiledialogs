@echo off

cl /c tinyfiledialogs.c  /Fo:tinyfiledialogs.obj
lib /OUT:tinyfiledialogs.lib tinyfiledialogs.obj
move tinyfiledialogs.lib \windows\
del tinyfiledialogs.obj
