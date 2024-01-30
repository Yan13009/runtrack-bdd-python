
CREATE DATABASE LaPlateformeRH;


USE LaPlateformeRH;

CREATE TABLE employe (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    salaire DECIMAL(10, 2),
    id_service INT,
    FOREIGN KEY (id_service) REFERENCES service(id)
);


INSERT INTO employe (nom, prenom, salaire, id_service) VALUES
    ('Doe', 'John', 3500.00, 1),
    ('Smith', 'Alice', 2800.00, 2),
    ('Jones', 'Bob', 4000.00, 1),
    ('Johnson', 'Emily', 3200.00, 3),
    ('Brown', 'David', 4500.00, 2);



SELECT * FROM employe WHERE salaire > 3000;



CREATE TABLE service (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255)
);

INSERT INTO service (nom) VALUES
    ('RH'),
    ('Finance'),
    ('Informatique');


SELECT employe.*, service.nom AS service_nom
FROM employe
JOIN service ON employe.id_service = service.id;


import mysql.connector

class EmployeManager:
    def __init__(self, host, user, Azerty13009$, database):
        self.connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )
        self.cursor = self.connection.cursor()

    def create_employe(self, nom, prenom, salaire, id_service):
        query = "INSERT INTO employe (nom, prenom, salaire, id_service) VALUES (%s, %s, %s, %s)"
        values = (nom, prenom, salaire, id_service)
        self.cursor.execute(query, values)
        self.connection.commit()

    def read_employes(self):
        query = "SELECT * FROM employe"
        self.cursor.execute(query)
        return self.cursor.fetchall()

    def update_employe(self, employe_id, new_salaire):
        query = "UPDATE employe SET salaire = %s WHERE id = %s"
        values = (new_salaire, employe_id)
        self.cursor.execute(query, values)
        self.connection.commit()

    def delete_employe(self, employe_id):
        query = "DELETE FROM employe WHERE id = %s"
        values = (employe_id,)
        self.cursor.execute(query, values)
        self.connection.commit()

    def __del__(self):
        self.cursor.close()
        self.connection.close()




