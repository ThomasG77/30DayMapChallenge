wget https://adresse.data.gouv.fr/data/ban/adresses-odbl/latest/addok/adresses-addok-france.ndjson.gz
unp adresses-addok-france.ndjson.gz
ack -i thomas adresses-addok-france.ndjson | grep '"type":"street"' > name-thomas.ndjson
echo "lat,lon,name" > headers.csv
jq -r '[.lat,.lon,.name] | @csv' < name-thomas.ndjson > name-thomas.csv
cat name-thomas.csv | grep -i ' thomas \| thomas"\|"thomas \|"thomas"\|Saint-thomas\|St-thomas' > name-thomas-cleaning.csv
cat headers.csv name-thomas-cleaning.csv > name-thomas-cleaned.csv