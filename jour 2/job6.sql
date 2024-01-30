USE LaPlateforme;

SELECT SUM(capacite) AS capacite_totale
FROM salle;


import mysql.connector

# Remplacez ces informations par vos propres détails de connexion
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


query_capacite = "SELECT SUM(capacite) AS capacite_totale FROM salle;"
cursor.execute(query_capacite)

capacite_totale = cursor.fetchone()[0]
print(f"La capacité totale des salles est de {capacite_totale}")


cursor.close()
connection.close()
