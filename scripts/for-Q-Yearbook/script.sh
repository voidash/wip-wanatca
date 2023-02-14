#! /usr/bin/bash

for file in Y[1-9]*.htm
do
	echo "working on $file"
	new_filename=${file%*.htm}.md
	python3 convert.py "$file" | pandoc --from=html --to=markdown -o "$new_filename"
	sed -i '1,4d' "$new_filename"
	{
		echo " "
		echo "### [Dowload it here](/yearbooks/${new_filename%T*}all.pdf)" 
		echo " "
		echo "{{< embed-pdf url=\"/yearbooks/${new_filename%T*}all.pdf\" >}}"
	} >> "$new_filename"
	
done


