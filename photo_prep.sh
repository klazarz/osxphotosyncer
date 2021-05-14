#!/bin/bash

PATH=/Users/kevin/anaconda/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Server.app/Contents/ServerRoot/usr/bin:/Applications/Server.app/Contents/ServerRoot/usr/sbin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Users/kevin/Documents/python_projects/osxphotosyncer

#prep
source /Users/kevin/Documents/python_projects/osxphotosyncer/server.sh

#get new photos from album 'Hafur_select'
python3.9 /Users/kevin/Documents/python_projects/osxphotosyncer/main.py

#convert HEIC format into jpg
if [ -n "$(ls -A /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls/*.HEIC 2>/dev/null)" ]
    then
        mogrify -format jpg /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls/*.HEIC
        rm /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls/*.HEIC
fi;

#remove all HEICs
#if [ -n "$(ls -A /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls/ >/dev/null)" ]
#then
#rm /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls/*.HEIC
#fi;

#resize
mogrify -format jpg -path /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls -resize 2000x2000^ /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls/*.jpg
mogrify -format jpg -path /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls -resize 2000x2000^ /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls/*.JPG

#create thumbnails
mogrify -thumbnail 400x400^ -gravity north -extent 400x400 -path /Users/kevin/Documents/python_projects/osxphotosyncer/export/thumbs -format jpg /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls/*.jpg

#copy everything to hafur@oracle
scp -r /Users/kevin/Documents/python_projects/osxphotosyncer/export/* $ssh_server:input/.

#remove
if [ -n "$(ls -A /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls/ 2>/dev/null)" ]
then
rm /Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls/*
rm /Users/kevin/Documents/python_projects/osxphotosyncer/export/thumbs/*
fi;
