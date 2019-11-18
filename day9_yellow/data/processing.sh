# ogr2ogr -f CSV /tmp/out-distinct.csv /vsizip/./ne_10m_admin_0_countries.zip/ne_10m_admin_0_countries.shp -dialect sqlite -sql "SELECT DISTINCT ADM0_A3 from ne_10m_admin_0_countries"

