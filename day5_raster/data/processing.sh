wget https://download.geofabrik.de/europe/france/pays-de-la-loire-latest.osm.pbf
osmium extract --bbox=-1.9734,47.0739,-1.2895,47.4374 pays-de-la-loire-latest.osm.pbf \
    -o nantes-metropole-extended.osm.pbf
sudo su -p postgres
psql -c "CREATE DATABASE nantes_metro"
psql nantes_metro -c "CREATE EXTENSION postgis"
psql nantes_metro -c "CREATE EXTENSION hstore"
osm2pgsql -G --latlong -U osm -d nantes_metro nantes-metropole-extended.osm.pbf -C 4000 --number-processes=6 --slim --hstore-all
psql nantes_metro < waters.sql
psql nantes_metro < buffer_waters.sql
exit

