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


query = "SELECT * FROM etudiant;"
cursor.execute(query)


students = cursor.fetchall()

for student in students:
    print(student)


cursor.close()
connection.close()
