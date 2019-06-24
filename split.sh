#!/usr/bin/bash

mkdir songs

prev_n=0

beginning=$(grep -no "%% .* SONGS" zpevnik.tex | awk -F: '{print $1}')
sed -n -e 1,$((beginning))p zpevnik.tex > zpevnik_split.tex

for n in $(grep -n -e "\\toftagthis" zpevnik.tex | awk -F: '{print $1}'); do
	name=$(sed -n $((prev_n+1)),$((prev_n+1))p zpevnik.tex | grep -Po -e "(?<=song{).*?(?=})" | sed -e 's/\(.*\)/\L\1/' | sed -e 's/\s/_/g' | sed -e "s/[,']//g" | iconv -f utf8 -t ascii//TRANSLIT)

	sed -n -e ${prev_n},$((n-1))p zpevnik.tex > songs/$name.txt
	echo "\input{songs/$name.txt}" >> zpevnik_split.tex
	prev_n=$n
done;
echo "\end{document}" >> zpevnik_split.tex
