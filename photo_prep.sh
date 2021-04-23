#!/usr/bin/env bash

#prep
source server.sh


#get new photos from album 'Hafur_select'
python3.9 main.py

#convert HEIC format into jpg
mogrify -format jpg export/fulls/*.HEIC

#remove all HEICs
rm export/fulls/*.HEIC

#resize
mogrify -format jpg -path export/fulls -resize 2800x2800^ export/fulls/*.jpg

#create thumbnails
mogrify -thumbnail 400x400^ -gravity north -extent 400x400 -path export/thumbs -format jpg export/fulls/*.jpg

#copy everything to hafur@oracle
scp -r export/* $ssh_server:input/.

#remove
rm export/fulls/*
rm export/thumbs/*
