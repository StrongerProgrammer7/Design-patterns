CREATE TABLE Laboratory_work (
  id INT NOT NULL AUTO_INCREMENT,
  number INT NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  topics VARCHAR(512),
  tasks VARCHAR(512),
  date_of_issue DATE,
  PRIMARY KEY (id)
);
