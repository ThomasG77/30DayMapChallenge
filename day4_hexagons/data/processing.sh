wget https://download.geofabrik.de/europe/france/pays-de-la-loire-latest.osm.pbf
query-overpass query.overpassql > pays-de-la-loire.geojson

# Commerces
ogr2ogr -f GPKG -nln commerces commerces_all.gpkg pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'shop') AS shop, geometry"\
" FROM points WHERE hstore_get_value(other_tags, 'shop') IS NOT NULL"

ogr2ogr -f GPKG -nln commerces commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'shop') AS shop, ST_PointOnSurface(geometry)"\
" FROM lines WHERE hstore_get_value(other_tags, 'shop') IS NOT NULL"

ogr2ogr -f GPKG -nln commerces commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'shop') AS shop, ST_PointOnSurface(geometry)"\
" FROM multilinestrings WHERE hstore_get_value(other_tags, 'shop') IS NOT NULL"

ogr2ogr -f GPKG -nln commerces commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, shop, ST_PointOnSurface(geometry)"\
" FROM multipolygons WHERE shop IS NOT NULL"

ogr2ogr -f GPKG -nln commerces commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'shop') AS shop, ST_PointOnSurface(geometry)"\
" FROM other_relations WHERE hstore_get_value(other_tags, 'shop') IS NOT NULL"

# Restauration
ogr2ogr -f GPKG -nln restauration commerces_all.gpkg pays-de-la-loire-latest.osm.pbf \
-update \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, geometry"\
" FROM points WHERE hstore_get_value(other_tags, 'amenity') IN ('restaurant', 'fast_food')"

ogr2ogr -f GPKG -nln restauration commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM lines WHERE hstore_get_value(other_tags, 'amenity')  IN ('restaurant', 'fast_food')"

ogr2ogr -f GPKG -nln restauration commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM multilinestrings WHERE hstore_get_value(other_tags, 'amenity')  IN ('restaurant', 'fast_food')"

ogr2ogr -f GPKG -nln restauration commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, amenity, ST_PointOnSurface(geometry)"\
" FROM multipolygons WHERE amenity  IN ('restaurant', 'fast_food')"

ogr2ogr -f GPKG -nln restauration commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM other_relations WHERE hstore_get_value(other_tags, 'amenity')  IN ('restaurant', 'fast_food')"

# Bistrots
ogr2ogr -f GPKG -nln bistrots commerces_all.gpkg pays-de-la-loire-latest.osm.pbf \
-update \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, geometry"\
" FROM points WHERE hstore_get_value(other_tags, 'amenity') IN ('bar', 'cafe', 'pub')"

ogr2ogr -f GPKG -nln bistrots commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM lines WHERE hstore_get_value(other_tags, 'amenity')  IN ('bar', 'cafe', 'pub')"

ogr2ogr -f GPKG -nln bistrots commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM multilinestrings WHERE hstore_get_value(other_tags, 'amenity')  IN ('bar', 'cafe', 'pub')"

ogr2ogr -f GPKG -nln bistrots commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, amenity, ST_PointOnSurface(geometry)"\
" FROM multipolygons WHERE amenity  IN ('bar', 'cafe', 'pub')"

ogr2ogr -f GPKG -nln bistrots commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM other_relations WHERE hstore_get_value(other_tags, 'amenity')  IN ('bar', 'cafe', 'pub')"

# Hébergements
ogr2ogr -f GPKG -nln hebergements commerces_all.gpkg pays-de-la-loire-latest.osm.pbf \
-update \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'tourism') AS tourism, geometry"\
" FROM points WHERE hstore_get_value(other_tags, 'tourism') = 'hotel'"

ogr2ogr -f GPKG -nln hebergements commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'tourism') AS tourism, ST_PointOnSurface(geometry)"\
" FROM lines WHERE hstore_get_value(other_tags, 'tourism')  = 'hotel'"

ogr2ogr -f GPKG -nln hebergements commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'tourism') AS tourism, ST_PointOnSurface(geometry)"\
" FROM multilinestrings WHERE hstore_get_value(other_tags, 'tourism')  = 'hotel'"

ogr2ogr -f GPKG -nln hebergements commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, tourism, ST_PointOnSurface(geometry)"\
" FROM multipolygons WHERE tourism  = 'hotel'"

ogr2ogr -f GPKG -nln hebergements commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'tourism') AS tourism, ST_PointOnSurface(geometry)"\
" FROM other_relations WHERE hstore_get_value(other_tags, 'tourism')  = 'hotel'"

# Pharmacies
ogr2ogr -f GPKG -nln pharmacies commerces_all.gpkg pays-de-la-loire-latest.osm.pbf \
-update \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, geometry"\
" FROM points WHERE hstore_get_value(other_tags, 'amenity') = 'pharmacy'"

ogr2ogr -f GPKG -nln pharmacies commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM lines WHERE hstore_get_value(other_tags, 'amenity')  = 'pharmacy'"

ogr2ogr -f GPKG -nln pharmacies commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM multilinestrings WHERE hstore_get_value(other_tags, 'amenity')  = 'pharmacy'"

ogr2ogr -f GPKG -nln pharmacies commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, amenity, ST_PointOnSurface(geometry)"\
" FROM multipolygons WHERE amenity  = 'pharmacy'"

ogr2ogr -f GPKG -nln pharmacies commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM other_relations WHERE hstore_get_value(other_tags, 'amenity')  = 'pharmacy'"

# Immobilier
ogr2ogr -f GPKG -nln immobilier commerces_all.gpkg pays-de-la-loire-latest.osm.pbf \
-update \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, geometry"\
" FROM points WHERE hstore_get_value(other_tags, 'office') IN ('estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

ogr2ogr -f GPKG -nln immobilier commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, ST_PointOnSurface(geometry)"\
" FROM lines WHERE hstore_get_value(other_tags, 'office')  IN ('estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

ogr2ogr -f GPKG -nln immobilier commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, ST_PointOnSurface(geometry)"\
" FROM multilinestrings WHERE hstore_get_value(other_tags, 'office')  IN ('estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

ogr2ogr -f GPKG -nln immobilier commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, office, ST_PointOnSurface(geometry)"\
" FROM multipolygons WHERE office  IN ('estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

ogr2ogr -f GPKG -nln immobilier commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, ST_PointOnSurface(geometry)"\
" FROM other_relations WHERE hstore_get_value(other_tags, 'office')  IN ('estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

# Banques et assurances
ogr2ogr -f GPKG -nln banques_assurances commerces_all.gpkg pays-de-la-loire-latest.osm.pbf \
-update \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, hstore_get_value(other_tags, 'amenity') AS amenity, geometry"\
" FROM points WHERE hstore_get_value(other_tags, 'office') IN ('estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

ogr2ogr -f GPKG -nln banques_assurances commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM lines WHERE hstore_get_value(other_tags, 'office') = 'insurance' OR hstore_get_value(other_tags, 'amenity') = 'bank'"

ogr2ogr -f GPKG -nln banques_assurances commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM multilinestrings WHERE hstore_get_value(other_tags, 'office') = 'insurance' OR hstore_get_value(other_tags, 'amenity') = 'bank'"

ogr2ogr -f GPKG -nln banques_assurances commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, office, amenity, ST_PointOnSurface(geometry)"\
" FROM multipolygons WHERE office = 'insurance' OR amenity = 'bank'"

ogr2ogr -f GPKG -nln banques_assurances commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, hstore_get_value(other_tags, 'amenity') AS amenity, ST_PointOnSurface(geometry)"\
" FROM other_relations WHERE hstore_get_value(other_tags, 'office') = 'insurance' OR hstore_get_value(other_tags, 'amenity') = 'bank'"

# Autres bureaux
ogr2ogr -f GPKG -nln autres_bureaux commerces_all.gpkg pays-de-la-loire-latest.osm.pbf \
-update \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, geometry"\
" FROM points WHERE hstore_get_value(other_tags, 'office') IN ('insurance', 'estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

ogr2ogr -f GPKG -nln autres_bureaux commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, ST_PointOnSurface(geometry)"\
" FROM lines WHERE hstore_get_value(other_tags, 'office') IS NOT NULL AND hstore_get_value(other_tags, 'office') NOT IN ('insurance', 'estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

ogr2ogr -f GPKG -nln autres_bureaux commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, ST_PointOnSurface(geometry)"\
" FROM multilinestrings WHERE hstore_get_value(other_tags, 'office') IS NOT NULL AND hstore_get_value(other_tags, 'office') NOT IN ('insurance', 'estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

ogr2ogr -f GPKG -nln autres_bureaux commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, office, ST_PointOnSurface(geometry)"\
" FROM multipolygons WHERE office IS NOT NULL AND office NOT IN ('insurance', 'estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

ogr2ogr -f GPKG -nln autres_bureaux commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'office') AS office, ST_PointOnSurface(geometry)"\
" FROM other_relations WHERE hstore_get_value(other_tags, 'office') IS NOT NULL AND hstore_get_value(other_tags, 'office') NOT IN ('insurance', 'estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

# Artisans
ogr2ogr -f GPKG -nln artisans commerces_all.gpkg pays-de-la-loire-latest.osm.pbf \
-update \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'craft') AS office, geometry"\
" FROM points WHERE hstore_get_value(other_tags, 'craft') IN ('insurance', 'estate_agent', 'real_estate_broker', 'real_estate_promoter', 'property_management')"

ogr2ogr -f GPKG -nln artisans commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'craft') AS office, ST_PointOnSurface(geometry)"\
" FROM lines WHERE hstore_get_value(other_tags, 'craft') IS NOT NULL AND hstore_get_value(other_tags, 'shop') IS NULL"

ogr2ogr -f GPKG -nln artisans commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'craft') AS office, ST_PointOnSurface(geometry)"\
" FROM multilinestrings WHERE hstore_get_value(other_tags, 'craft') IS NOT NULL AND hstore_get_value(other_tags, 'shop') IS NULL"

ogr2ogr -f GPKG -nln artisans commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, craft, ST_PointOnSurface(geometry)"\
" FROM multipolygons WHERE craft IS NOT NULL AND shop IS NULL"

ogr2ogr -f GPKG -nln artisans commerces_all.gpkg \
-append \
pays-de-la-loire-latest.osm.pbf \
-dialect sqlite \
-sql "SELECT osm_id, name, hstore_get_value(other_tags, 'craft') AS office, ST_PointOnSurface(geometry)"\
" FROM other_relations WHERE hstore_get_value(other_tags, 'craft') IS NOT NULL AND hstore_get_value(other_tags, 'shop') IS NULL"

# All commerces
ogr2ogr -f "ESRI Shapefile" commerces.shp commerces_all.gpkg \
-lco ENCODING=UTF-8 \
-dialect sqlite \
-sql "SELECT osm_id, name, geom FROM commerces
UNION
SELECT osm_id, name, geom FROM restauration
UNION
SELECT osm_id, name, geom FROM bistrots
UNION
SELECT osm_id, name, geom FROM hebergements
UNION
SELECT osm_id, name, geom FROM pharmacies
UNION
SELECT osm_id, name, geom FROM immobilier
UNION
SELECT osm_id, name, geom FROM banques_assurances
UNION
SELECT osm_id, name, geom FROM autres_bureaux
UNION
SELECT osm_id, name, geom FROM artisans"

