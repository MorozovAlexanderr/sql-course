# 1. Вивести книги у яких не введена ціна або ціна дорівнює 0
SELECT * FROM books WHERE Price IS NULL OR Price = 0


# 2. Вивести книги у яких введена ціна, але не введений тираж
SELECT * FROM books WHERE Price IS NOT NULL AND Edition IS NULL


# 3. Вивести книги, про дату видання яких нічого не відомо.
SELECT * FROM books WHERE PublishingDate IS NULL


# 4. Вивести книги, з дня видання яких пройшло не більше року.
SELECT * FROM books WHERE YEAR(NOW()) - YEAR(PublishingDate) <= 1


# 5. Вивести список книг-новинок, відсортованих за зростанням ціни
SELECT * FROM books WHERE IsNovelty = 'Yes' ORDER BY Price


# 6. Вивести список книг з числом сторінок від 300 до 400, відсортованих в зворотному алфавітному порядку назв
SELECT * FROM books WHERE Pages BETWEEN 300 AND 400 ORDER BY Name DESC


# 7. Вивести список книг з ціною від 20 до 40, відсортованих за спаданням дати
SELECT * FROM books WHERE Price BETWEEN 20 AND 30 ORDER BY PublishingDate DESC


# 8. Вивести список книг, відсортованих в алфавітному порядку назв і ціною по спадаючій
SELECT * FROM books ORDER BY Name, Price DESC


# 9. Вивести книги, у яких ціна однієї сторінки < 10 копійок.
SELECT * FROM books WHERE Pages / Price < 0.1


# 10. Вивести значення наступних колонок: число символів в назві, перші 20 символів назви великими літерами
SELECT LENGTH(Name) AS CountChars, 
	   UPPER(LEFT(Name, 20)) AS UpperChars 
  FROM books


# 11. Вивести значення наступних колонок: перші 10 і останні 10 символів назви прописними буквами, розділені '...'
SELECT LOWER(CONCAT(LEFT(Name, 10), '...', RIGHT(Name, 10))) AS ShortName FROM books


# 12. Вивести значення наступних колонок: назва, дата, день, місяць, рік
SELECT Name,
	   PublishingDate,
       DAY(PublishingDate) AS Day, 
       MONTH(PublishingDate) AS Month,
       YEAR(PublishingDate) AS Year
  FROM books


# 13. Вивести значення наступних колонок: назва, дата, дата в форматі 'dd / mm / yyyy'
SELECT Name,
	   PublishingDate,
       DATE_FORMAT(PublishingDate, '%d/%m/%Y') AS FormatDate
  FROM books


# 14. Вивести значення наступних колонок: код, ціна, ціна в грн., ціна в євро, ціна в руб.
SELECT BookCode,
	   Price,
	   CONCAT('€', Price * 0.03) AS PriceEuro,
	   CONCAT('₽', Price * 2.67) AS PriceRuble  
  FROM books


# 15. Вивести значення наступних колонок: код, ціна, ціна в грн. без копійок, ціна без копійок округлена
SELECT BookCode,
	   Price, 
       TRUNCATE(Price, 0) AS RoundPrice,
       CEILING(Price) AS FloorPrice
  FROM books


# 16. Додати інформацію про нову книгу (всі колонки)
INSERT INTO `books` (`BookCode`, 
	 				 `IsNovelty`, 
	 				 `Name`, 
	 				 `Price`, 
	 				 `Publishing`, 
	 				 `Pages`, 
	 				 `Format`, 
	 				 `PublishingDate`, 
	 				 `Edition`, 
	 				 `Theme`, 
	 				 `Category`) 
VALUES (1221, 'Yes', 'Новая книга', 17.5, 'ДМК', 200, '70х100/16', '2001-05-02', 5000, 'Використання ПК в цілому', 'Підручники')

# 17. Додати інформацію про нову книгу (колонки обов'язкові для введення)
INSERT INTO `books` (`BookCode`, 
					 `Name`, 
					 `Price`, 
					 `Pages`, 
					 `Format`, 
					 `PublishingDate`) 
VALUES (4231, 'Новая книга ч.2', 12.5, 180, '70х100/16', '2001-07-12')

# 18. Видалити книги, видані до 1990 року
DELETE FROM books WHERE YEAR(PublishingDate) <= 1990


# 19. Проставити поточну дату для тих книг, у яких дата видання відсутня
UPDATE books SET PublishingDate = CURDATE() WHERE PublishingDate IS NULL


# 20. Установити ознаку новинка для книг виданих після 2005 року
UPDATE books SET IsNovelty = 'Yes' WHERE YEAR(PublishingDate) >= 2005