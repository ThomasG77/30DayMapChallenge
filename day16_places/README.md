## Data sources

* GeoFLA 2015 communes
* GeoFLA 2015 départements

* Data "Nombre d’exploitations et surface par espèce fruitière, par région, par département et commune" (Excel : 1.2 Mo) available on http://agreste.agriculture.gouv.fr/enquetes/productions-vegetales-528/vergers-et-fruits/

* Manual corrections due to town merging (in French, no corresponding naming in English)

  * 49199 => 49092 (rattachement commune nouvelle)
  * 49213 => 49018 (rattachement commune nouvelle)
  * 49303 => 49018 (rattachement commune nouvelle)
  * 72207 => 72137 (rattachement commune nouvelle)

* String 's' for statistical secret changed to -9999

## PyQGIS recipe to print one map with multiples themes

theme1 = QgsProject.instance().mapThemeCollection().mapThemes()[0]

layout1 = QgsProject.instance().layoutManager().layouts()[0]
layoutItemMap = [i for i in layout1.items() if isinstance(i, QgsLayoutItemMap)][0]

layoutItemMap.setFollowVisibilityPresetName(theme1)
layoutItemMap.setFollowVisibilityPreset(True)

layoutItemMap.followVisibilityPreset()

filepath = '/tmp/out.pdf'
QgsLayoutExporter(layout1).exportToPdf(filepath, QgsLayoutExporter.PdfExportSettings())
