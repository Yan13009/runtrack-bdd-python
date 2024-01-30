USE LaPlateforme;

-- Calculer la superficie totale de l'ensemble des étages
SELECT SUM(superficie) AS superficie_totale
FROM etage;



import mysql.connector


host = "localhost"
user = "user"
password = "Azerty13009$"
database = "LaPlateforme"


connection = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=database
)


cursor = connection.cursor()


query_salle = "SELECT nom, capacite FROM salle;"
cursor.execute(query_salle)


rooms_data = cursor.fetchall()


for room in rooms_data:
    print(f"Nom de la salle: {room[0]}, Capacité: {room[1]}")

query_superficie = "SELECT SUM(superficie) AS superficie_totale FROM etage;"
cursor.execute(query_superficie)


superficie_totale = cursor.fetchone()[0]
print(f"La superficie de La Plateforme est de {superficie_totale} m2")

cursor.close()
connection.close()
