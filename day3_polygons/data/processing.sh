# ogr2ogr -f CSV /tmp/out-distinct.csv /vsizip/./ne_10m_admin_0_countries.zip/ne_10m_admin_0_countries.shp -dialect sqlite -sql "SELECT DISTINCT ADM0_A3 from ne_10m_admin_0_countries"

# for i in $(tail -n +2 /tmp/out-distinct.csv | sort);
#   do ogr2ogr -f "ESRI Shapefile" -lco ENCODING=UTF-8 /tmp/shp/layer-$i.shp /vsizip/./ne_10m_admin_0_countries.zip/ne_10m_admin_0_countries.shp -dialect sqlite -sql "SELECT * from ne_10m_admin_0_countries WHERE ADM0_A3 ='$i'";
# done;

# Recipe from https://deparkes.co.uk/2015/05/01/make-a-grid-of-images-with-imagemagick/
# If memory issue, look at https://blog.bigbinary.com/2018/09/12/configuring-memory-allocation-in-imagemagick.html
# You need to export as images the atlas from QGIS to images-output directory before running this script
cd ../images-output
montage -density 100 -tile 13x20 -geometry +5+5 *.png ../small-multiples.png

cd ..
convert small-multiples.png \
          -pointsize 64 -font "Ubuntu-Bold" -gravity SouthEast -annotate +80+100 '© Thomas Gratier 2019' \
          -pointsize 64 -font "Ubuntu-Bold" -gravity SouthEast -annotate +80+20 'Données Natural Earth Data' \
          small-multiples-with-copyright.png

convert small-multiples-with-copyright.png  -pointsize 256 -font "Ubuntu-Bold" -background white label:'World Countries' \
          +swap  -gravity Center -append    small-multiples-with-copyright-and-title.png

rm small-multiples-with-copyright.png small-multiples.png images-output/*.png small-multiples-with-copyright-and-title-*.png