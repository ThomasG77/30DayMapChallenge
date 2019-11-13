import os

from qgis.utils import iface
from qgis.core import (
    QgsCoordinateReferenceSystem,
    QgsFeature, QgsField, QgsFields,
    QgsGeometry, QgsPointXY, QgsProject,
    QgsVectorFileWriter, QgsVectorLayer, QgsWkbTypes)
from qgis.PyQt.QtCore import QVariant
import processing
from h3 import h3

projectPath = os.path.dirname(QgsProject.instance().fileName())
accumulator = {}
r = range(3, 14)
for i in r:
    accumulator[str(i)] = []

mylayer = QgsProject.instance().mapLayersByName('Tous les commerces')[0]

for feature in mylayer.getFeatures():
    x = feature.geometry().asPoint()[0]
    y = feature.geometry().asPoint()[1]
    for i in r:
        accumulator[str(i)].append(h3.geo_to_h3(x, y, i))

for i in r:
    accumulator[str(i)] = set(accumulator[str(i)])
    fields = QgsFields()
    fields.append(QgsField("id", QVariant.String))
    writer = QgsVectorFileWriter(
        os.path.join(projectPath, "data/hexagon_" + str(i) + ".shp"),
        "UTF8", fields, QgsWkbTypes.Polygon,
        QgsCoordinateReferenceSystem('EPSG:4326'),
        "ESRI Shapefile"
    )
    features = []
    for j in accumulator[str(i)]:
        f = QgsFeature()
        f.setGeometry(QgsGeometry.fromPolygonXY([
            [QgsPointXY(c[0], c[1]) for c in h3.h3_to_geo_boundary(j)]
        ]))
        f.setAttributes([j])
        features.append(f)
    writer.addFeatures(features)

for i in r:
    layer = QgsVectorLayer(
        os.path.join(projectPath, "data/hexagon_" + str(i) + ".shp"),
        "Hexagons " + str(i), "ogr"
    )
    QgsProject.instance().addMapLayer(layer)

for i in r:
    processing.run('qgis:countpointsinpolygon', {
        'CLASSFIELD' : None,
        'FIELD' : 'numpoints',
        'POLYGONS': os.path.join(projectPath, "data/hexagon_" + str(i) + ".shp"), 
        'OUTPUT' : os.path.join(projectPath, "data/hexagon_" + str(i) + "_count.shp"),
        'POINTS' : mylayer,
        'WEIGHT' : None
    })

for i in r:
    layer = QgsVectorLayer(
        os.path.join(projectPath, "data/hexagon_" + str(i) + "_count.shp"),
        "Hexagons count " + str(i), "ogr"
    )
    QgsProject.instance().addMapLayer(layer)
