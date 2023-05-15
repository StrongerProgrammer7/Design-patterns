INSERT INTO Owner
(surname,name,lastname,phone,mail)
VALUES
('Яковлев','Леон','Тимофеевич','89374225252',NULL),
('Потапов','Михаил','Иванович','+79374225252','swaf@mail.ru'),
('Бирюков','Ким','Мэлорович','89394223552',NULL);

INSERT INTO Guard
(surname,name,lastname,phone,mail,exp_year)
VALUES
('Фролов','Кондрат','Святославович','87771741865',NULL,2),
('Дроздов','Денис','Авдеевич','+75259561235','guar@gmail.com',5),
('Шилов','Ипполит','Рубенович','89186251790',NULL,15);


INSERT INTO Mark
(mark)
VALUES
('Toyota'),
('Mersedes-Benz'),
('BMW');


INSERT INTO Model
(model,mark)
VALUES
('Higlander','Toyota'),
('GL-3','Mersedes-Benz'),
('X6','BMW');

INSERT INTO Auto
(owner_id,model,color)
VALUES
(1,'Higlander','black'),
(2,'GL-3','white'),
(3,'X6','gray');
