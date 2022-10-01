file_list=$(cat files.lst)
for files in $file_list
do
	sed -i -e 's/# II/# I/g' -e 's/# III/# II/g' $files
done
