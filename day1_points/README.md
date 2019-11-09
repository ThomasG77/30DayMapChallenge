# Day 1 - Points

## Data coming from:

* https://www.data.gouv.fr/fr/datasets/referentiel-des-gares-de-voyageurs/
* https://www.data.gouv.fr/fr/datasets/frequentation-en-gares/
* http://professionnels.ign.fr/adminexpress

## Get Rank (ignoring same values)

```
array_find(array_filter(array_sort(array_agg("fg_Total Voyageurs 2018"), false), @element IS NOT NULL),
attribute( $currentfeature, 'fg_Total Voyageurs 2018'))
```