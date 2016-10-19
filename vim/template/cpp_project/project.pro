#-------------------------------------------------
#
# Project created by QtCreator 2013-06-08T22:34:13
#
#-------------------------------------------------

TARGET = project

SOURCES += main.cpp
HEADERS += foo.hpp

#QMAKE_CXX = clang

CONFIG -= qt
QMAKE_CXXFLAGS += -std=c++11

QMAKE_CXXFLAGS_DEBUG -= -g 
QMAKE_CXXFLAGS_DEBUG += -ggdb 
QMAKE_CXXFLAGS_DEBUG += -Wpedantic 
#QMAKE_CXXFLAGS_DEBUG += -Weverything #clang only



#LIBS += -L/usr/lib -lpthread 
