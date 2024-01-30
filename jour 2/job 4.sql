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

query = "SELECT nom, capacite FROM salle;"
cursor.execute(query)


rooms_data = cursor.fetchall()


for room in rooms_data:
    print(f"Nom de la salle: {room[0]}, Capacité: {room[1]}")


cursor.close()
connection.close()
