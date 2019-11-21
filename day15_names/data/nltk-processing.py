# Logic mainly retrieved from below article
# https://www.datacamp.com/community/tutorials/text-analytics-beginners-nltk
import csv
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.probability import FreqDist

nltk.download('punkt')
nltk.download('stopwords')

text = """
Roche Thomas
Bac à Thomas
Thomas Riboud
Thomas Edison
Ambroise Thomas
Thomas Riboud
Croix Thomas
La Croix Thomas
Bois Thomas
Thomas
Bois Thomas
Thomas de Paris
Saint Thomas
Albert Thomas
Albert Thomas
Brassette Saint Thomas
Albert Thomas
Ouche Thomas
Moulin Thomas
Place Jean Thomas
Philippe Thomas
Albert Thomas
Thomas
Colonel Thomas Piddington
Place Thomas Guerin
Thomas Garbies
Thomas Decaroli
Thomas et Pallanca
Thomas Edison
Thomas Cresp
Thomas
Saint Thomas
Saint Thomas
Thomas Edison
Louis Thomas Camus
Thomas
Albert Thomas
Lt Colonel Andre Thomas
Henri Thomas
Albert Thomas
Thomas Lavaur
Thomas Sarti
Thomas
Avant Thomas
Quartier Thomas
Ferme de Thomas
Thomas
Albert Thomas
Thomas Edison
Thomas Bouges
Quai Thomas Jefferson
Place Albert Thomas
Clos Saint Thomas
Métairie d'En Thomas
Albert Thomas
Thomas
Abbé G Thomas Raynal
Thomas Edison
Thomas Edison
Maurice Charles Thomas
Guillaume Thomas Raynal
Saint Thomas de Villeneuve
Thomas Alva Edison
Albert Thomas
Thomas Edison
Chap Saint Thomas
Thomas Edison
Thomas Gaspard Fortune Barsotti
Marius Thomas
Thomas
Lieutenant Thomas Windsor
Lucien Thomas
Henri Thomas
Thomas Masaryk
Place Albert Thomas
Saint Thomas
Saint Thomas Becket
Lt Col Thomas Malcom Gray
Thomas Bazin
Thomas
Place Alfred Thomas
Rang Thomas
Thomas
Thomas Dunot
Thomas Jean Montsaint
Jardin Thomas
Place Saint Thomas
Saint Thomas
Saint Thomas
Thomas Edison
Thomas Veillon
Paul Thomas
Chez Pere Thomas
Chez Thomas
Saint Thomas
Thomas Edison
Thomas Souville
Croix Thomas
Croix Thomas
Pas Thomas
Petit Saint Thomas
Thomas Narcejac
Thomas Wilson
Gustave Thomas
Eugene Thomas
Thomas Edison
Thomas Paine
Saint Thomas
Saint Thomas
Thomas Edison
Saint Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Place Thomas Russy
Saint Thomas
Saint Thomas
Saint Thomas
Madame Ferme Thomas
Thomas Edison
Bois Thomas
Les Thomas
Thomas
des Thomas
L'Ouche Thomas
Saint Thomas
Thomas Edison
Louis Thomas
Albert Thomas
Albert Thomas
Thomas
Place Thomas Rougier
Thomas
Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Henri Thomas
Albert Thomas
Alexis Thomas
Saint Thomas
Les Champs Thomas Maroué
Thomas Edison
Ker Thomas
Ker Thomas
Le Port Thomas
Ambroise Thomas
Abbé Thomas
Font Saint Thomas
Saint Thomas
Cote Saint Thomas
Puits Thomas
Parcou Thomas
Louis Thomas
Albert Thomas
Les Aires Thomas
Croix Thomas
Les Thomas
René Thomas
Albert Thomas
Thomas Edison
Thomas Fernandez
Place Thomas Robert Bugeaud
Thomas
Thomas
Hameau de Thomas
Chez Thomas
Thomas
Adrien Thomas
Les Thomas Ouest
Thomas Edison
Albert Thomas
Thomas Edison
les Champs Thomas
Les Champ Thomas
Albert Thomas
Place Albert Thomas
Emile Thomas
Ambroise Thomas
la Croix Thomas
Thomas Edison
des Thomas
Thomas Edison
Saint Thomas
Saint Thomas
Saint Thomas
Thomas Edison
Albert Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Moulin du Bec Thomas
Thomas Lindet
La Vallée Thomas
Bourg Thomas
Friche Pierre Thomas
Thomas Edison
Val Thomas
Saint Thomas
Saint Thomas
Hameau Thomas
Saint Thomas
Bec Thomas
Louis Thomas
Saint Thomas
Bec Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Albert Thomas
Saint Thomas
Albert Thomas
Thomas Joly
Prieuré Saint Thomas
Brice Thomas
Mesnil Thomas
Saint Thomas
Le Mesnil Thomas
Saint Thomas
Saint Thomas
Thomas Edison
Ambroise Thomas
Francis Thomas
Albert Thomas
Place Saint Thomas
Park Thomas
Park Thomas
Minven Parc Thomas
Barthelemy Thomas
Thomas Edison
Parc Thomas
Hent Parc Thomas
Saint thomas
Place Saint Thomas
Saint Thomas
Penhoat Saint Thomas
Saint Thomas
Mathurin Thomas
Thomas Edison
Albert Thomas
Thomas Edison
Roger Thomas
Louis Thomas
Saint Thomas
Thomas
Barry Thomas
Puits Thomas
Thomas Jefferson
Saint Thomas
Thomas
Les Bois de Thomas
Albert Thomas
Saint Thomas
Thomas Costanzo
Thomas
Thomas
François Thomas
Saint Thomas
Thomas
Croix de Thomas
Paul et Thomas Severat
Guilhem Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Thomas Mann
Président Thomas Woodrow Wilson
Thomas Edison
Thomas Dupuy
Saint Thomas d'Aquin
Ambroise Thomas
À Thomas
Thomas
Thomas
Saint Thomas
Saint Thomas
Thomas d'Aquin
Thomas Lussan
Thomas Illyricus
Petit Thomas
Albert Thomas
Albert Thomas
Jardins de Thomas
Thomas Edison
Albert Thomas
Albert Thomas
Francois Thomas Rey
Le Moulin de Thomas
Thomas
Clément Thomas
Thomas
Thomas
Thomas Edison
Thomas Edison
Thomas Edison
Clément Thomas
Clément Thomas
Thomas Illyricus
Saint Thomas d'Aquin
Saint Thomas d'Aquin Pyla
Thomas Edison
Saint Thomas
Place Albert Thomas
Golf Saint Thomas
Golf de Saint Thomas
Marechal Thomas Bugeaud
Guillaume Thomas Raynal
Marechal Thomas Bugeaud
Golf Saint Thomas
Ambroise Thomas
Albert Thomas
Ambroise Thomas
Thomas Millerot
Thomas Edison
Thomas Mann
Thomas Platter
Thomas More
Professeur Louis Thomas
Professeur Louis Thomas
Thomas
Thomas Nunez
les Jardins de Thomas
Pre Saint Thomas
Charles Thomas
Thomas Edison
Les Saints Thomas
Quai Administrateur Chef Thomas
Joseph Thomas
Saint Thomas du Ronceray
Ville Thomas
Thomas Edison
Thomas de la Touche
Champs Thomas
Jean Louis Thomas
Saint Thomas
Thomas d'Anast
Thomas Leroy
Saint Thomas
Croix Thomas
Croix Thomas
Place Thomas Bourcin
Thomas Bourcin
Clos Thomas
Saint Thomas
Croix Thomas des Champs
Croix Thomas
Thomas le Roy
Champ Thomas
Albert Thomas
Saint Thomas
Thomas Connecte
La Thomas
Joseph Thomas
Thomas James
La Planche Thomas
Planche Thomas
Pont Thomas
le Clos Thomas
Clos Thomas
Port Thomas
Saint Thomas
Porte Saint Thomas
Pont Thomas
Saint Thomas
Garenne Saint Thomas
La Garenne de Saint Thomas
Thomas Edison
Les Fosses Thomas
Thomas
Thomas Pactius
Les Thomas
Les Thomas
Marcel Thomas Lavollée
Saint Thomas
Raymond Thomas
Marcel Thomas Lavollée
Albert Thomas
Plan Thomas
Thomas
Thomas
Louis Thomas
René Thomas
Albert Thomas
René Thomas
Thomas Edison
Place Leon Thomas
Louis Thomas
Place Thomas Léon
Louis Thomas
Coteau Thomas
Le Thomas
Thomas
Albert Thomas
Thomas
Thomas
Thomas la Platane
Thomas
Thomas
Thomas Diaz
Les Plants Saint Thomas
Clos Thomas
Thomas Jefferson
Albert Thomas
Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Thomas Edison
Albert Thomas
Albert Thomas
Le Thomas
le Thomas
Thomas Dubouchet
Thomas Edison
Place Albert Thomas
Albert Thomas
Col Saint Thomas
Emilien et Marguerite Thomas
Marguerite et Emilien Thomas
Ambroise Thomas
M et E Thomas
Thomas Edison
Thomas Edison
Saint Thomas
Thomas Edison
Albert Thomas
Jean-françois Thomas
Albert Thomas
Thomas Edison
Thomas Edison
Thomas Narcejac
Saint Thomas
Thomas Maisonneuve
Félix Thomas
Thomas Russel Crampton
Eugène Thomas
Albert Thomas
Thomas Narcejac
Saint Thomas
Bois Thomas
Le Bois Thomas
Thomas Edison
Albert Thomas
Thomas Maisonneuve
Le Clos Thomas
Place Saint Thomas
Place Chanoine Thomas
Georges Thomas
Abbé Thomas
Thomas Barreau
Aignan Thomas Desfriches
Thomas Edison
René Thomas Fauneau
Aignan Thomas Desfriches
Thomas Edison
Thomas Barreau
Saint Thomas
Mas de Thomas Est
Georges Thomas
Thomas
Thomas
Thomas
Thomas
Albert Thomas
Saint Thomas
Thomas
Thomas Edison
Thomas
Moulin de Thomas
Moulin de Thomas
Thomas
Thomas Edison
Colonel Thomas
Albert Thomas
Abbé Thomas
Lucien Thomas
Jeanne Thomas
Bois Thomas
Thomas Edison
Saint Thomas
Saint Thomas
Le Chene Thomas
Saint Thomas
Thomas Edison
Thomas Edison
Saint Thomas Becket
Saint Thomas
Thomas Helye
Thomas Helye Biville
Thomas Henry
Albert Thomas
Albert Thomas
Thomas Dumarest
Thomas du Marest
Thomas Giordano
Saint Thomas
Thomas Douville
Saint Thomas
Mont Thomas
Thomas Riffaudière
Saint Thomas
Saint Thomas
Saint Thomas
Saint Thomas
Thomas Martin
Jules Thomas
Thomas Picotin
Alfred Thomas
Thomas
Buisson Thomas
Place Saint Thomas
Docteur Thomas
Albert Thomas
Thomas
Saint Thomas
Thomas Bas
Thomas
Les Plantes Thomas
Roger Thomas
Saint Thomas
Georges Thomas
Leger Thomas
Albert Thomas
Place Albert Thomas
Le Fort Thomas
Thomas Naudet
Albert Thomas
Thomas Alva Edison
Paul Thomas
Thomas Gilchrist
Albert Thomas
Emile Thomas
Place Ambroise Thomas
Ambroise Thomas
Thomas Mordillac
Albert Thomas
Emile Thomas
Bat Thomas Majorelle
Emile Thomas
Albert Thomas
Thomas de Choisy
Sir Thomas
Poirier Jean Thomas
Pierre Charles Thomas
Saint Thomas
Grees Thomas
Perrine Thomas
Thomas Dobrée
Thomas Edison
Saint Thomas
Saint Thomas
Docteur Ferdinand Thomas
Porh Thomas
Albert Thomas
Albert Thomas
Albert Thomas
Saint Thomas
Place Francois Thomas
Thomas Edison
Maurice Thomas
Louis Thomas
Docteur Ferdinand Thomas
Hotel Thomas
Les Rues Thomas
Capitaine Jacky Thomas
Capitaine Jacky Thomas
N Thomas Marion Dufresne
Thomas de Closmadeuc
Messire Thomas
General Jean Thomas
Ambroise Thomas
Thomas
Ambroise Thomas
Place Saint Thomas
Ambroise Thomas
Ambroise Thomas
Ambroise Thomas
Thomas Edison
Thomas Bata
Thomas Gilchrist
Thomas d'Aquin
Saint Thomas de Conac
Ambroise Thomas
Paul Thomas
Thomas Edison
Ambroise Thomas
Ambroise Thomas
Thomas Edison
Le Buisson Thomas
Le Crot Thomas
Albert Thomas
Albert Thomas
Les Chaumes Thomas
Thomas Edison
Fernand Thomas
Place Eugène Thomas
Albert Thomas
Albert Thomas
Thomas Edison
Thomas
Ambroise Thomas
Saint Thomas
Place Eugene Thomas
Alexandre Thomas
Ernest Thomas
Thomas Becket
Thomas Prolongee
Thomas Edison
Ambroise Thomas
les Marzelles à Thomas
Freres Thomas
Albert Thomas
Albert Thomas
Place Albert Thomas
Ambroise Thomas
Eugene Thomas
Eugène Thomas
Thomas
Sydney Thomas
Place Andre Thomas
Place Albert Thomas
Jean Thomas
Albert Thomas
Albert Thomas
Place Albert Thomas
Thomas
Albert Thomas
Marcel Thomas
Saint Thomas
Thomas Edison
Albert Thomas
Saint Thomas
Place Saint Thomas
Saint Thomas de Canterbury
Thomas Couture
Thomas Edison
Albert Thomas
Place Maurice Thomas
Thomas Couture
Thomas
Albert Thomas
Thomas Wilson
Saint Thomas
La Maison Thomas
Thomas Becket
Thomas Galloway
Le Bois Thomas
Le Clos Thomas
Le Champ Thomas
Le Parc Thomas
Le Bois Thomas
Thomas Hayot
Albert Thomas
Zephir Thomas
Albert Thomas
Thomas Nowell
Rond Point Thomas Jefferson
Thomas Prior
Place Thomas
Eugène Thomas
Thomas Edison
Eugène Thomas
Ambroise Thomas
Thomas Edison
Eugene Thomas
Albert Thomas
Louis Thomas
Cité Thomas Lefebvre
Albert Thomas
Albert Thomas
Thomas Becket
Arthur Thomas
Place Saint Thomas
Saint Thomas
Thomas Edison
Ambroise Thomas
Claude Thomas Dupuy
Place Alfred Thomas
Saint Thomas
Saint Thomas
Thomas
Albert Thomas
Place Thomas
Champ Thomas
Champ Thomas Denone
Albert Thomas
Albert Thomas
Thomas
Thomas Bohier
Francois Thomas
François Thomas
Albert Thomas
Albert Thomas
Thomas
Thomas Edison
Thomas Pascal
Saint Thomas
Thomas Edison
Saint Thomas
Saint Thomas
Thomas Wilson
Thomas Edison
Thomas Carrere
Thomas
Saint Thomas
Thomas Murner
Thomas Becquet
Thomas Edison
Saint Thomas
Place Saint Thomas
Saint Thomas
Thomas Edison
Thomas Mann
Quai Saint Thomas
Place Saint Thomas
Christophe Thomas Walliser
Thomas
Thomas
Thomas Murner
Abbé Thomas
Georges Thomas
Albert Thomas
Elisée Thomas
Albert Thomas
Creux Thomas
Philippe Thomas
Jean Thomas
Jean Thomas
Albert Thomas
Thomas
Chap Saint Thomas
Albert Thomas
Thomas Blanchet
Albert Thomas
Victor et Roger Thomas
Albert Thomas
Albert Thomas
Thomas Edison
Albert Thomas
Thomas Leconte
Place Albert Thomas
Thomas Dumorey
Saint Thomas
Honoré Thomas
Albert Thomas
Thomas
Thomas Louis
Thomas Edison
Thomas Edison
Saint Thomas
Saint Thomas
Sidney Thomas
Colin Thomas
Thomas Edison
Colin Thomas
Albert Thomas
Champ Thomas
Saint Thomas de Coeur
Saint Thomas
Thomas Edison
Thomas Edison
Thomas Ruphy
Saint Thomas
Saint Thomas
Saint Thomas
Champs Thomas
Saint Thomas
Filles Saint Thomas
Saint Thomas d'Aquin
Place Saint Thomas d'Aquin
Ambroise Thomas
Albert Thomas
Yéo Thomas
Thomas Mann
Thomas Francine
Henri Thomas
Albert Thomas
Thomas Corneille
Clos Thomas
Thomas Corneille
Thomas Bazin
Asile Thomas
Thomas Bouchard
Le Clos Saint Thomas
Albert Thomas
Thomas Beckett
Ambroise Thomas
Thomas Becket
Ambroise Thomas
Thomas Cossard
Pierre et Thomas Corneille
Nicolas Thomas Bremontier
Thomas Edison
Thomas Corneille
Place Nicolas Thomas Bremontier
Thomas Edison
Albert Thomas
Thomas Corneille
Thomas Dubosc
Saint Thomas
Thomas Francois Paumelle
Albert Thomas
Saint Thomas
Vallon Saint Thomas
Côte Saint Thomas
Saint Thomas
Louis Thomas
Felix Thomas
Albert Thomas
Albert Thomas
Thomas Edison
André Thomas
Albert Thomas
Albert Thomas
Pré Thomas
Place Thomas le Pilleur
Noyer Thomas
Albert Thomas
Thomas
Thomas Edison
Thomas Becket
Albert Thomas
Albert Thomas
Place Emile Thomas
Ambroise Thomas
Thomas Sankara
Thomas Portau
Albert Thomas
Thomas
Mont Thomas
le Mont Thomas
Thomas Bonnuit
Château Thomas
Albert Thomas
Thomas
Albert Thomas
Albert Thomas
Thomas
Marcel Thomas
Albert Thomas
Albert Thomas
Albert Thomas
Albert Thomas
Albert Thomas
Albert Thomas
Frederic Thomas
Frederic Thomas
Rives Thomas
Place Philadelphe Thomas
En Thomas
En Thomas
Albert Thomas
Place Albert Thomas
la Croix de Thomas
Albert Thomas
Capitaine Jacky Thomas
Jacquy Thomas
Borie Thomas
Jean Thomas
Jean Thomas
Thomas Edison
Thomas Jefferson
Thomas Merton
Thomas Goulard
Godeffroy Thomas
Emile Thomas
Thomas Edison
Ambroise Thomas
Lot Thomas
Ambroise Thomas
Alex Thomas
Ambroise Thomas
Saint Thomas
Ambroise Thomas
Thomas Lainée
Saint Thomas d'Aquin
Thomas Edison
Thomas Hérisson
Thomas Petrucci
Thomas de Camaret
Thomas Alva Edison
Place Joseph Thomas
Pierre Thomas
Thomas Edison
Thomas de Galleans
Thomas Edison
Thomas Edison
Thomas Edison
Thomas Edison
Thomas Couture
Constant Thomas
Thomas Edison
Toits de Saint Thomas
Saint Thomas
Combes de Saint Thomas
Faubourg Saint Thomas
Thomas Edison
Léonce Thomas
Saint Thomas
Le Coteau de Saint Thomas
Saint Thomas
Ernest Thomas
Henri Thomas
Thomas Edison
Thomas Edison
Thomas Edison
Thomas Edison
Cite Saint Thomas
les Thomas
Lucien Thomas
Albert Thomas
Paul Thomas
Place Saint Thomas Becket
Placa Saint Thomas Becket
Place Henry Thomas
Place Henri Thomas
Champs Thomas
Thomas
Henri Thomas
L'Etang Thomas
Joseph Thomas
Thomas Ancel
Thomas Girardin
Thomas Loiseau
Saint Thomas
Thomas
Thomas Becket
les Thomas
Thomas Woodrow Wilson
Albert Thomas
Louis Thomas
Albert Thomas
Albert Thomas
Saint Thomas
Albert Thomas
Gabriel Thomas
Thomas Edison
Thomas Edison
Thomas Mazarick
Albert Thomas
Thomas Masarik
Robert Thomas
Thomas Becket
Auguste Thomas
Albert Thomas
Elphege Thomas
Thomas d'Orléans
Ambroise Thomas
Thomas Edison
Thomas Lemaître
Thomas Campanella
Thomas More
Albert Thomas
Thomas Edison
Lieutenant Thomas
Albert Thomas
Place Albert Thomas
Albert Thomas
Ambroise Thomas
Albert Thomas
Albert Thomas
Thomas Sankara
Place Eugène Thomas
Albert Thomas
Albert Thomas
Thomas More
Albert Thomas
Ambroise Thomas
Place Albert Thomas
Albert Thomas
Albert Thomas
Thomas Edison
Albert Thomas
Thomas Edison
Albert Thomas
Albert Thomas
Antoine Thomas
Eugène Thomas
Thomas Francine
Place Thomas Edison
Albert Thomas
Albert Thomas
Ambroise Thomas
Ambroise Thomas
Ambroise Thomas
Thomas Edison
Thomas Edison
Jean Thomas
Alexandre Thomas
Ambroise Thomas
Thomas Edison
Albert Thomas
Thomas Edison
Robert Thomas
Thomas du Fosse
Thomas Couture
Saint Thomas
Thomas Edison
Thomas
Thomas le Preux
Paul Thomas
Thomas Désert
Thomas Minolien
Thomas Gontrand
Thomas Edison
Thomas Guidiglo
François Thomas
Caverne Thomas
Thomas Robert
Clos Saint Thomas
Rachel Thomas
Albert Thomas
Thomas Seebeck
Thomas Sankara
Thomas
Emile Thomas
Lucay Thomas Fortuna
Regis Thomas
Ariste Thomas
Eglise Saint Thomas
Regis Thomas
Théodore Thomas
Thomas Edison
Thomas Payet"""

text = text.replace("d'", '')
tokenized_word=word_tokenize(text)
print(tokenized_word)

stop_words=set(stopwords.words('french'))
stop_words.update(['Le', 'Les', 'La', 'Place', 'Thomas'])

filtered_word = []
for w in tokenized_word:
    if w not in stop_words:
        filtered_word.append(w)
print('Tokenized Sentence:', tokenized_word)
print('Filterd Sentence:', filtered_word)


fdist = FreqDist(filtered_word)
print(fdist)

most_common_20 = fdist.most_common(20)

with open('stats.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile, delimiter=',',
                            quotechar='|', quoting=csv.QUOTE_MINIMAL)
    writer.writerow(['name','count'])
    for e in most_common_20:
        writer.writerow(e)
