
## First install (if you have installed conda)

```
conda create -n mygeopandas python=3.7
conda activate mygeopandas
conda install jupyter matplotlib mapclassify descartes pysal shapely xlrd
conda install --channel conda-forge geopandas jupyterlab geoplot
```

## After first install

```
conda activate mygeopandas
```

## Data sources

* "Table d'appartenance géographique des communes au 1ᵉʳ janvier 2019" <https://www.insee.fr/fr/information/2028028>
* polygons for French towns <http://professionnels.ign.fr/adminexpress>

## Going further

* schools divisions https://www.data.gouv.fr/fr/datasets/contours-geographiques-des-academies/ (also official info at https://www.legifrance.gouv.fr/eli/decret/2015/12/10/MENG1523843D/jo)
* police divisions
* law divisions
* water division (management not natural area) <https://www.gesteau.fr/telecharger/sage>, <http://www.sandre.eaufrance.fr/atlas/srv/eng/catalog.search#/metadata/10e2ca67-f915-42ba-8416-26a4e8151ae4>, <http://www.sandre.eaufrance.fr/atlas/srv/eng/catalog.search#/search?resultType=details&any=sage&fast=index&_content_type=json&from=1&to=20&sortBy=relevance>
* culture <https://www.culture.gouv.fr/Regions>
