-- CREATE - skapar person-tabell
CREATE TABLE person
(
    person_id  INT AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name  VARCHAR(20) NOT NULL,
    dob        DATE,
    income     DOUBLE,
    PRIMARY KEY (person_id)
);

-- INSERT - lägger in personer
INSERT INTO person (first_name, last_name, dob, income)
VALUES ('Oscar', 'Calmvik', '2020-07-27', 5000),
       ('Soya', 'Calmvik', '2023-10-10', NULL),
       ('Isabelle', 'Madison', '1979-05-09', 70000),
       ('Philip', 'Persson', '1990-02-15', 30000),
       ('Angelica', 'Andren', '2001-07-01', 35000);


-- SELECT
SELECT *
FROM person;

SELECT first_name, last_name, income
FROM person;

SELECT first_name, last_name, income
FROM person
WHERE income > 40000;

SELECT first_name, last_name, income
FROM person
ORDER BY income DESC;

SELECT *
FROM person
WHERE dob > '1990-02-15';

-- UPDATE
UPDATE person
SET income = 10000
WHERE first_name = 'Oscar';

-- DELETE
DELETE
FROM person
WHERE last_name = 'Andren';

DELETE
FROM person
WHERE income IS NULL;

-- lägger in Soya igen i tabellen
INSERT INTO person (first_name, last_name, dob, income)
VALUES ('Soya', 'Calmvik', '2023-10-10', NULL);

SELECT *
FROM person
WHERE first_name LIKE 'O%';

SELECT COUNT(*)
FROM person;

SELECT MAX(income)
FROM person;

SELECT MIN(income)
FROM person;


/*

  Kommentar:
  Tabellen bryter mot 1NF, varje kolumn får bara innehålla ett värde och alla värden ska vara atomära,
  dvs odelbara. Man får inte ha flera olika värden i samma ruta (max ett tel.nr/ruta).
  Först skapar man en tabell där varje tel.nr ligger på en egen rad. Då är tabellen ordnad efter 1NF.
  Men man behöver även skapa två olika tabeller där man separerar student och tel.nr pga problem med
  redundans (samma student-namn på flera rader), onödig upprepning av samma information.
 */

-- CREATE-table statements
CREATE TABLE student
(
    student_id INT AUTO_INCREMENT,
    name       VARCHAR(20) NOT NULL,
    PRIMARY KEY (student_id)
);

-- foreign key ligger i tabellen där "många"-sidan finns
CREATE TABLE phone_number
(
    phone_id   INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT         NOT NULL,
    phone      VARCHAR(20) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student (student_id)
);

-- lägger in studenter i tabellen
INSERT INTO student (name)
VALUES ('Maja'),
       ('Elias'),
       ('Sara'),
       ('Omar');

-- kollar så att allt är med i student-tabellen
SELECT *
FROM student;

-- lägger in student-id (dock hårdkodat) och telefonnr i tabellen
INSERT INTO phone_number (student_id, phone)
VALUES (1, '070-1234567'),
       (1, '073-5556677'),
       (2, '070-8881122'),
       (3, '072-9911223'),
       (3, '072-9911224'),
       (4, '076-3344556');

-- kollar så att allt är med i phonenumber-tabellen
SELECT *
FROM phone_number;

-- hämtar alla studenter och deras resp. telnr, saknar student telnr kommer de i resultatet med NULL-värde
SELECT student.name, phone_number.phone
FROM student
         LEFT JOIN phone_number --
                   ON student.student_id = phone_number.student_id
ORDER BY name ASC; -- sorterar resultatet alfabetiskt efter namn



