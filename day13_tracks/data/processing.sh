for i in *.overpassql;
  do query-overpass < ${i%.*}".overpassql" > ${i%.*}".geojson";
  ogr2ogr -f GeoJSON ${i%.*}"_lines.geojson" ${i%.*}.geojson -nln ${i%.*}_lines -dialect sqlite -sql "SELECT * FROM "${i%.*}" WHERE ST_GeometryType(GEOMETRY) IN ('LINESTRING', 'MULTILINESTRING')"
done;

cp own/Q17004958_lines.geojson .

for i in $(ls *_lines.geojson | sed 's/_lines//g');
  do ogr2ogr -f GeoJSON ${i%.*}"_lines_union.geojson" ${i%.*}"_lines.geojson" -dialect sqlite -sql 'SELECT "'${i%.*}'" AS identifier, ST_UNION(geometry) As geometry FROM '${i%.*}"_lines";
done;

# Run this part (uncomment) only after export of atlas + export of second layout to output_84.png
cd ../images-output
montage -density 100 -tile 4x6 -geometry +0+0 output_*.png ../quiz-formula-1.png
montage -density 100 -tile 4x6 -geometry +0+0 answer_output_*.png ../answer-formula-1.png
cd ..
convert quiz-formula-1.png -pointsize 512 -font "Tuffy-Bold" -background white label:'Mapping quiz Formula 1 season 2019' \
           +swap  -gravity Center -append    quiz-formula-1-with-title.png
convert answer-formula-1.png -pointsize 512 -font "Tuffy-Bold" -background white label:'Answers mapping quiz Formula 1 season 2019' \
           +swap  -gravity Center -append    answer-formula-1-with-title.png
