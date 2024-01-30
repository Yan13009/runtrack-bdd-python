pip install mysql-connector-python

import mysql.connector

class ZooManager:
    def __init__(self, host, user, password, database):
        self.connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )
        self.cursor = self.connection.cursor()

    def create_tables(self):
        # Créer la table "animal"
        self.cursor.execute("""
            CREATE TABLE IF NOT EXISTS animal (
                id INT PRIMARY KEY AUTO_INCREMENT,
                nom VARCHAR(255),
                race VARCHAR(255),
                id_cage INT,
                date_naissance DATE,
                pays_origine VARCHAR(255),
                FOREIGN KEY (id_cage) REFERENCES cage(id)
            )
        """)

      
        self.cursor.execute("""
            CREATE TABLE IF NOT EXISTS cage (
                id INT PRIMARY KEY AUTO_INCREMENT,
                superficie INT,
                capacite_max INT
            )
        """)

    def ajouter_animal(self, nom, race, id_cage, date_naissance, pays_origine):
        query = "INSERT INTO animal (nom, race, id_cage, date_naissance, pays_origine) VALUES (%s, %s, %s, %s, %s)"
        values = (nom, race, id_cage, date_naissance, pays_origine)
        self.cursor.execute(query, values)
        self.connection.commit()

    def ajouter_cage(self, superficie, capacite_max):
        query = "INSERT INTO cage (superficie, capacite_max) VALUES (%s, %s)"
        values = (superficie, capacite_max)
        self.cursor.execute(query, values)
        self.connection.commit()

    def afficher_animaux(self):
        query = "SELECT * FROM animal"
        self.cursor.execute(query)
        result = self.cursor.fetchall()
        for row in result:
            print(row)

    def afficher_animaux_dans_cages(self):
        query = """
            SELECT cage.id AS id_cage, cage.superficie, cage.capacite_max, GROUP_CONCAT(animal.nom) AS animaux
            FROM cage
            LEFT JOIN animal ON cage.id = animal.id_cage
            GROUP BY cage.id
        """
        self.cursor.execute(query)
        result = self.cursor.fetchall()
        for row in result:
            print(f"Cage {row[0]} - Superficie: {row[1]} m2, Capacité maximale: {row[2]}, Animaux: {row[3]}")

    def calculer_superficie_totale(self):
        query = "SELECT SUM(superficie) FROM cage"
        self.cursor.execute(query)
        result = self.cursor.fetchone()
        return result[0]

    def __del__(self):
        self.cursor.close()
        self.connection.close()

# Exemple d'utilisation
zoo_manager = ZooManager("localhost", "user", "password", "zoo")
zoo_manager.create_tables()

while True:
    print("\nMenu:")
    print("1. Ajouter un animal")
    print("2. Ajouter une cage")
    print("3. Afficher les animaux")
    print("4. Afficher les animaux dans les cages")
    print("5. Calculer la superficie totale des cages")
    print("0. Quitter")

    choix = input("Choisissez une option (0-5): ")

    if choix == "1":
        nom = input("Nom de l'animal: ")
        race = input("Race de l'animal: ")
        id_cage = input("ID de la cage: ")
        date_naissance = input("Date de naissance (AAAA-MM-JJ): ")
        pays_origine = input("Pays d'origine: ")
        zoo_manager.ajouter_animal(nom, race, id_cage, date_naissance, pays_origine)

    elif choix == "2":
        superficie = input("Superficie de la cage (en m2): ")
        capacite_max = input("Capacité maximale de la cage: ")
        zoo_manager.ajouter_cage(superficie, capacite_max)

    elif choix == "3":
        zoo_manager.afficher_animaux()

    elif choix == "4":
        zoo_manager.afficher_animaux_dans_cages()

    elif choix == "5":
        superficie_totale = zoo_manager.calculer_superficie_totale()
        print(f"La superficie totale des cages est de {superficie_totale} m2")

    elif choix == "0":
        break

    else:
        print("Option invalide. Veuillez saisir une option valide.")
