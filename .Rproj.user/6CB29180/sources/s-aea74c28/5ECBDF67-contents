#!/bin/bash

file_list=$(ls *.Rmd)
for files in $file_list
do
	echo $files
#	sed -i 's|" -",params$doc_id|" -- ",params$doc_id|gI' $files
  sed -i 's/4.2.3 Kawalan Dokumen/2.4 Kawalan Dokumen/' $files
  sed -i 's/lihat 4.3.3/lihat 9.2.2/gI' $files
done

# sed -i 's/foo/linux/gI' file.txt
find . -type f | xargs grep --color 'Kawalan Ke Atas Proses Penyampaian Perkhidmatan\|Validasi Proses Penyampaian Perkhidmatan Kepada Pelanggan'
find . -type f -print0 | xargs -0 grep --color '	width'
find . -type f -print0 | xargs -0 sed -i 's/juruAudit/juruaudit/gI'
sed -f color.sed
find Manual_Kualiti.Rmd -type f -print0 | xargs -0 grep --color '(i)'
find iso9001_bm.Rmd -type f -print0 | xargs -0 grep --color '#'
find . -type f -print0 | xargs -0 grep --color '5\.1\.2'
find . -type f | xargs sed -i 's/8\.8\.2/8.8.2/gI' 
find . -type f | xargs grep --color '.Dasar Integriti, Akauntabiliti dan Anti-Rasuah'
diff iso9001_bm.txt mk_seksyen.txt
find iso9001_bm.Rmd -type f -print0 | xargs -0 grep --color '#' > iso9001_bm.txt
find | grep -F -f ~/R/qms/file.txt
find ./PKS_06_Teknologi_Maklumat.Rmd ./PKS_05_Bajet.Rmd ./Manual_Kualiti.Rmd -type f -print0 | xargs -0 grep --color '#' 
cat ~/R/qms/file.txt | sed -n '/(i)/p'
sed 's/i)/./g' ~/R/qms/file.txt
sed 's/i)/a./gI' PKO_01_Sebut_harga_tender_kontrak.Rmd

# !/bin/bash 

file_list=$(cat ~/R/qms/file.txt)
for files in $file_list
do
	echo $files
#	sed -i 's|~/R/qms|/cloud/project|gI' $files
# grep -E --color 'Seksyen' $files
done

file_list=$(cat ~/R/qms/file.txt)
for files in $file_list
do
	echo $files
	sed -i 's/2.4 Kawalan Dokumen./4.4.2 Menyelenggarakan maklumat didokumentasikan;/gI' $files
	sed -i 's/9.2.2 Audit dalaman./9.2 Audit dalaman;/gI' $files
	sed -i 's/9.2.3 Kawalan dan Pengukuran Proses./9.1 Pemantauan, pengukuran, analisis dan penilaian;/gI' $files
	sed -i 's/10.1 Penambahbaikan Berterusan./10.3 Penambahbaikan berterusan;/gI' $files
	sed -i 's/10.2 Tindakan Pembetulan./10.2.1.1 Tindakan pembetulan; dan/gI' $files
	sed -i 's/10.3 Tindakan Pencegahan./10.2.1.2 Tindakan pencegahan./gI' $files
	sed -i 's/5.6.1 Tanggungjawab Dan kuasa./5.3.1 Tanggungjawab dan kuasa;/gI' $files
	sed -i 's/5.1 Komitmen Pengurusan./5.1  Kepimpinan dan komitmen;/gI' $files
	sed -i 's/8.5.1 Kawalan Ke Atas Proses Penyampaian Perkhidmatan./8.5.1 Kawalan penyediaan pengeluaran dan perkhidmatan;/gI' $files
	sed -i 's/8.5.2 Validasi Proses Penyampaian Perkhidmatan Kepada Pelanggan./8.5.2 Pengenalpastian dan kebolehkesanan;dan/gI' $files
	sed -i 's/8.5.3 Identifikasi dan Kemudahan Pengesanan Dokumen./8.5.2 Pengenalpastian dan kebolehkesanan; dan/gI' $files
	sed -i 's/9.2.4 Pemantauan Dan Pengukuran Produk./d' $files
	sed -i 's/8.8.5 Pemuliharaan Dokumen./8.5.4 Pemeliharaan;/gI' $files
	sed -i 's/8.7 Kawalan output tak akur./8.7 Kawalan output tak akur;/gI' $files
	sed -i 's/9.4 Analisis Data./9.1.3  Analisis dan penilaian; dan/gI' $files
	sed -i 's/10.0 Penambahbaikan./10.2 Ketakakuran dan tindakan pembetulan./gI' $files
	sed -i 's/2.6 Kawalan Rekod Kualiti./4.4.2 Menyelenggarakan maklumat didokumentasikan;/gI' $files
	sed -i 's/5.2 - Keutamaan Pelanggan./5.1.2 Fokus kepada pelanggan;/gI' $files
	sed -i 's/8.2.3 Komunikasi Dengan Pelanggan./8.2.1 Komunikasi dengan pelanggan; dan/gI' $files
	sed -i 's/9.2.1 Kepuasan Pelanggan./9.1.2 Kepuasan pelanggan./gI' $files
	sed -i 's/2.6 Kawalan Rekod Kualiti./4.4.2 Menyelenggarakan maklumat didokumentasikan;/gI' $files
	sed -i 's/5.2 Dasar Kualiti./5.2.1 Membangunkan dasar kualiti dan dasar integriti, akauntabiliti dan anti-rasuah;/gI' $files
	sed -i 's/5.2 Dasar Integriti, Akauntabiliti dan Anti-Rasuah./d' $files
	sed -i 's/9.3. Kajian Semula Pengurusan./9.3. Kajian Semula Pengurusan;/gI' $files
	sed -i 's/6.1   Pengurusan Risiko./6.1 Tindakan menyatakan risiko dan peluang; dan/gI' $files
	sed -i 's/6.2   Objektif Kualiti./6.2  Objektif kualiti dan perancangan untuk mencapainya./gI' $files
	sed -i 's/keperluan sumber Seksyen 5.6.3/keperluan sumber (seksyen 7.1)./gI' $files
	sed -i 's/8.5 Proses Perolehan./8.4.1 Proses perolehan; dan/gI' $files
	sed -i 's/8.4.2 Verifikasi ke atas bahan yang diperolehi./8.5.1 Kawalan penyediaan pengeluaran dan perkhidmatan./gI' $files
	sed -i 's/Seksyen 7.2.2 Kompetensi, Latihan dan Kesedaran./7.2 Kekompetenan./gI' $files
	sed -i 's/5.1 - Komitmen Pengurusan./5.1  Kepimpinan dan komitmen; dan/gI' $files
	sed -i 's/7.1 Peruntukan Dan Penyediaan Sumber./7.1 Sumber./gI' $files
	sed -i 's/7.3 Infrastruktur./7.1.3 Prasarana./gI' $files
	sed -i 's/7.4 Persekitaran Kerja./7.1.4. Persekitaran untuk operasi proses./gI' $files
done

file_list=$(cat ~/qms/file.txt)
for files in $file_list
do
	echo $files
done
#	sed -i -e 's/\bi)/a\./g' $files
#	sed -i 's/{width=70\%}/width/g' $files
#	sed -i 's/	width//g' $files
# sed -i '22,25d' $files
#	sed -i '22i ```{r init, include=FALSE}' $files
# sed -i '28d' $files
# sed -i '28i \\\fancyhead[L]{\\textbf{MS ISO 9001:2015\\\\OpenApps Sdn Bhd (548151-W)\\\\`r params$doc_id`}}' $files
# sed -i 's/{MS ISO 9001:2015/{\textbf{MS ISO 9001:2015/gI' $files
# sed -i 's/i)/a./g' $files
# sed -i '19i\ \ \doc_date: ""' $files
# sed -i 's/\*\*Feb 2021\*\*/`r params$doc_date/gI' $files
done