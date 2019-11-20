# Get all French cities https://land.copernicus.eu/local/urban-atlas/urban-atlas-2012?tab=download
unp 4871571f3bb3cd9492bd643cbb4d53bfef2ce377.zip
# Do some cleaning (remove PDF, around half the size of zip content...)
# Work because our files are in France (code FR)
for i in FR*.zip;
  do zip --delete $i ${i%.*}"/Documents/*";
done;

sudo su -p postgres
psql -c "CREATE DATABASE european_atlas_fr"
psql european_atlas_fr -c "CREATE EXTENSION postgis"
psql european_atlas_fr -c "CREATE EXTENSION hstore"
exit

ogr2ogr -f "PostgreSQL" PG:"host=localhost user=osm dbname=european_atlas_fr password=osm" \
-nlt PROMOTE_TO_MULTI \
-nln city_boundaries \
-lco precision=NO \
--config PG_USE_COPY YES \
/vsizip/./FR001L1_PARIS.zip/FR001L1_PARIS/Shapefiles/FR001L1_PARIS_CityBoundary.shp FR001L1_PARIS_CityBoundary

ogr2ogr -f "PostgreSQL" PG:"host=localhost user=osm dbname=european_atlas_fr password=osm" \
-nlt PROMOTE_TO_MULTI \
-nln ua_2012 \
-lco precision=NO \
--config PG_USE_COPY YES \
/vsizip/./FR001L1_PARIS.zip/FR001L1_PARIS/Shapefiles/FR001L1_PARIS_UA2012.shp FR001L1_PARIS_UA2012

ogr2ogr -f "PostgreSQL" PG:"host=localhost user=osm dbname=european_atlas_fr password=osm" \
-nlt PROMOTE_TO_MULTI \
-nln ua_2012_boundaries \
-lco precision=NO \
--config PG_USE_COPY YES \
/vsizip/./FR001L1_PARIS.zip/FR001L1_PARIS/Shapefiles/FR001L1_PARIS_UA2012_Boundary.shp FR001L1_PARIS_UA2012_Boundary


for i in $(ls FR*.zip |grep -v _PARIS.zip);
  do unzip -l $i | grep -q CityBoundary.shp$;
  if [ "$?" == "0" ]
  then
    ogr2ogr -f "PostgreSQL" PG:"host=localhost user=osm dbname=european_atlas_fr password=osm" \
    --config PG_USE_COPY YES \
    -append \
    -nln city_boundaries \
    -nlt PROMOTE_TO_MULTI \
    "/vsizip/./"$i"/"${i%.*}"/Shapefiles/"${i%.*}"_CityBoundary.shp" ${i%.*}"_CityBoundary";
  fi;
  unzip -l $i | grep -q _UA2012_Boundary.shp$;
  if [ "$?" == "0" ]
  then
    ogr2ogr -f "PostgreSQL" PG:"host=localhost user=osm dbname=european_atlas_fr password=osm" \
    --config PG_USE_COPY YES \
    -append \
    -nln ua_2012_boundaries \
    -nlt PROMOTE_TO_MULTI \
    "/vsizip/./"$i"/"${i%.*}"/Shapefiles/"${i%.*}"_UA2012_Boundary.shp" ${i%.*}"_UA2012_Boundary";
  fi;
  unzip -l $i | grep -q _UA2012.shp$;
  if [ "$?" == "0" ]
  then
    ogr2ogr -f "PostgreSQL" PG:"host=localhost user=osm dbname=european_atlas_fr password=osm" \
    --config PG_USE_COPY YES \
    -append \
    -nln ua_2012 \
    -nlt PROMOTE_TO_MULTI \
    "/vsizip/./"$i"/"${i%.*}"/Shapefiles/"${i%.*}"_UA2012.shp" ${i%.*}"_UA2012";
  fi;
done;

# Run this part (uncomment) only after export of atlas + export of second layout to output_84.png
# cd ../images-output
# montage -density 100 -tile 12x7 -geometry +0+0 *.png ../small-multiples.png

# cd ..
# convert small-multiples.png  -pointsize 512 -font "Tuffy-Bold" -background white label:'Green areas of French cities European Urban Atlas 2012' \
#           +swap  -gravity Center -append    small-multiples-with-title.png
# convert small-multiples-with-title.png -resize 3.5% small-multiples-with-title-low-res.png
# convert small-multiples-with-title.png -resize 25% small-multiples-medium.png
