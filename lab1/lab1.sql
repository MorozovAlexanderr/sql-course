----------------------------------------------------------------------------

Колонка "номер" (N) буде головним ключем. 
Обовязкові для введення поля: код, назва, ціна, сторінки, формат, дата.
Поля зі значенням за замововчуванням: новинка, категорія.
Поля з областю допустимих значень: ціна, сторінки, тираж.
Поля для індексації: ціна, сторінки, дата, тираж

----------------------------------------------------------------------------

# Создание базы данных
CREATE DATABASE IF NOT EXISTS shopdb;

USE shopdb;

CREATE TABLE books 
(
    N INT PRIMARY KEY AUTO_INCREMENT,
    BookCode INT UNIQUE NOT NULL,
    IsNovelty VARCHAR(3) DEFAULT 'No' NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Price FLOAT NOT NULL CHECK (Price > 0),
    Publishing VARCHAR(20),
    Pages INT NOT NULL CHECK (Pages > 0),
    Format VARCHAR(10) NOT NULL,
    PublishingDate DATE NOT NULL,
    Edition INT CHECK (Edition >= 0),
    Theme VARCHAR(30),
    Category VARCHAR(30) DEFAULT 'Інші книги'
);


# Создание индексов для столбцов, которые  будут принимать участие  в сортировке
CREATE INDEX Price ON books(Price);
CREATE INDEX Pages ON books(Pages);
CREATE INDEX PublishingDate ON books(PublishingDate);
CREATE INDEX Edition ON books(Edition);


# Заполнение таблицы данными
INSERT INTO books(BookCode, IsNovelty, Name, Price, Publishing, Pages, Format, PublishingDate, Edition, Theme, Category)
VALUES
(2344, 'Yes', 'Аппаратные средства мультимедия. Видеосистема РС', 10.5, 
 'BHV С.-Петербург', 300, '70х100/16', '2000-07-24', 4000, NULL, 'Підручники'),
(5432, DEFAULT, 'Железо IBM 2001.', 8.3, NULL, 200, '70х100/16', '2001-10-13', 5000, NULL, DEFAULT),
(3221, DEFAULT, 'Windows 2000 Professional шаг за шагом с СD', 12.3, 
 'Эком', 100, '70х100/16', '2000-05-25', DEFAULT, NULL, 'Windows 2000');


# Добавление нового столбца
ALTER TABLE books
ADD Author VARCHAR(15) NULL;

# Изменение размерности типа столбца
ALTER TABLE books
MODIFY COLUMN Author VARCHAR(20);

# Удаление столбца
ALTER TABLE books
DROP COLUMN Author;


# Создание уникального индекса и изменение порядка сортировки 
CREATE UNIQUE INDEX BookCode
ON books(BookCode DESC);

# Удаление индекса
ALTER TABLE books 
DROP INDEX BookCode;