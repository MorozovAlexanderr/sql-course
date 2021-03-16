# Создание новых таблиц на основвании таблицы books
CREATE TABLE publishers
(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    PubName VARCHAR(30) NOT NULL
);

CREATE TABLE themes
(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    ThemeName VARCHAR(30) NOT NULL
);

CREATE TABLE categorys
(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    CatName VARCHAR(30) NOT NULL
);


# Заполнение созданных таблиц данными 
INSERT INTO publishers (PubName)
VALUES ('BHV С.-Петербург'), ('МикроАрт'), ('МикроАрт'), 
       ('DiaSoft'), ('Вильямс'), ('Питер'), 
       ('ДМК'), ('Триумф'), ('Русская редакция');

INSERT INTO themes (ThemeName)
VALUES ('Використання ПК в цілому'), ('Операційні системи'), ('Програмування');

INSERT INTO categorys (CatName)
VALUES ('Підручники'), ('Інші книги'), ('Windows 2000'), 
       ('Linux'), ('Unix'), ('Інші операційні системи'), ('C&C++');


# Обновление данных таблицы books для поля Publishing из таблицы publishers
UPDATE books SET Publishing = (SELECT Id FROM publishers WHERE PubName = Publishing);

# Изменение имени и типа столбца
ALTER TABLE books CHANGE Publishing PublisherId INT;

# Создание внешнего ключа для поля PublisherId
ALTER TABLE books
ADD FOREIGN KEY(PublisherId) REFERENCES publishers(Id) ON DELETE CASCADE;


UPDATE books SET Theme = (SELECT Id FROM themes WHERE ThemeName = Theme);

ALTER TABLE books CHANGE Theme ThemeId INT;

ALTER TABLE books
ADD FOREIGN KEY(ThemeId) REFERENCES themes(Id) ON DELETE CASCADE;


UPDATE books SET Category = (SELECT Id FROM categorys WHERE CatName = Category);

ALTER TABLE books CHANGE Category CategoryId INT;

ALTER TABLE books
ADD FOREIGN KEY(CategoryId) REFERENCES categorys(Id) ON DELETE CASCADE;


