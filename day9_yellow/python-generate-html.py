l = [[i['rank'], i['NAME_FR'], i['Stats_Valeur'], i['ISO_A2']] for i in iface.activeLayer().getFeatures() if i['rank'] is not None and i['rank'] < 10]
l_sorted = [i for i in sorted(l, key=lambda x: x[0])]
html = '''
<html>

<head>
</head>
<style type="text/css">
table tr td:nth-child(4) {
    text-align: right;
}
table tr td:nth-child(1) {
    text-align: center;
}
</style>
<body>
<table style="border-collapse: collapse;border: 1px solid black;">
       <tr style="border: 1px solid black;">
         <td style="border: 1px solid black;"><b>Rang</b></td>
         <td style="border: 1px solid black;"></td>
         <td style="border: 1px solid black;"><b>Pays</b></td>
         <td style="border: 1px solid black;"><b>Production (en tonnes)</b></tr>'''
html = html + ''.join(['<tr style="border: 1px solid black;"><td style="border: 1px solid black;">' + '</td><td style="border: 1px solid black;">'.join([str(i[0])] + ['<img width="30px" src="data/' + i[3].lower() + '.svg" />'] + [str(i[1])] + [str(i[2])]) + '</td></tr>' for i in l_sorted]) + '''</table>
</body>

</html>'''

with open('/tmp/mystats.html', 'w') as inputfile:
    inputfile.write(html)
