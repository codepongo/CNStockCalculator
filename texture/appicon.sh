#/bin/sh
imageresizer -i $1x512.png -s 180x180 -png $1x180.png 
imageresizer -i $1x512.png -s 120x120 -png $1x120.png 
imageresizer -i $1x512.png -s 87x87 -png $1x87.png 
imageresizer -i $1x512.png -s 80x80 -png $1x80.png 
imageresizer -i $1x512.png -s 58x58 -png $1x58.png 

