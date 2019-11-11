wget https://download.geofabrik.de/europe/france/pays-de-la-loire-latest.osm.pbf
osmium tags-filter -o network_tan.osm.pbf pays-de-la-loire-latest.osm.pbf /network=TAN
osmium tags-filter -o network_tan__type_route.osm.pbf network_tan.osm.pbf /type=route
ogr2ogr -f GPKG -nln all transports.gpkg -oo CONFIG_FILE=osmconf.ini network_tan__type_route.osm.pbf -dialect sqlite -sql "SELECT * FROM multilinestrings"
# After export from atlas
# convert -delay 250 -loop 0 *.png animation-transports.gif