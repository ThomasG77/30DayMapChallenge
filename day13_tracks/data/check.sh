cut -d ';' -f3 wikidata-f1-identifier-2019.txt | sed 's#https://www.wikidata.org/wiki/##g' | sort | tee /tmp/ids.txt
ls *.overpassql | sed 's/.overpassql//g' | sort | tee /tmp/files-ql.txt
diff /tmp/files-ql.txt /tmp/ids.txt
