USE LaPlateforme;

CREATE TABLE etage (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    numero INT,
    superficie INT
);


CREATE TABLE salle (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255),
    id_etage INT,
    capacite INT,
    FOREIGN KEY (id_etage) REFERENCES etage(id)
);
