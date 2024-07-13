#!/bin/ash

cd garglk
export QT_QPA_PLATFORM=pocketbook2
LD_LIBRARY_PATH=. ./gargoyle -platform pocketbook2
