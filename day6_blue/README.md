You need to get the GEBCO data as it was not possible to store the data here

```bash
cd data
wget --content-disposition https://www.bodc.ac.uk/data/open_download/gebco/GEBCO_15SEC/zip/
unp GEBCO_2019.zip
gdal_translate "NETCDF:GEBCO_2019.nc:elevation" gebco-elevation.tif
```

You may need to add Equal Earth custom projection using the GUI or these PyQGIS instructions

```python
my_crs = QgsCoordinateReferenceSystem()
my_crs.createFromProj4("+proj=eqearth +datum=WGS84 +wktext")
my_crs.saveAsUserCrs("Equal Earth")
```

You may need to change project CRS property as for custom CRS the identifier may change from one computer to another.