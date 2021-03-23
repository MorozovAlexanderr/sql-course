# 1.	Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат.
CREATE PROCEDURE select_books ()
SELECT b.Name, 
	   b.Price, 
       p.PubName,
	   b.Format 
  FROM books AS b
  	   JOIN publishers AS p
       ON p.Id = b.PublisherId;
       
CALL select_books()


# 2.	Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям.
CREATE PROCEDURE select_books_2 ()
SELECT b.Name, 
	   t.ThemeName, 
	   c.CatName,
       p.PubName
  FROM books AS b
  	   JOIN themes as t
  	   ON t.Id = b.ThemeId
  	   JOIN categorys AS c
       ON c.Id = b.CategoryId
       JOIN publishers AS p
       ON p.Id = b.PublisherId
 ORDER BY t.ThemeName, c.CatName

CALL select_books_2()


# 3.	Вивести книги видавництва 'BHV', видані після 2000 р
CREATE PROCEDURE select_books_3 (IN pub_name VARCHAR(50), IN pub_year INT)
SELECT b.Name, 
       p.PubName 
  FROM books AS b
  	   JOIN publishers AS p
       ON p.Id = b.PublisherId 
 WHERE p.PubName = pub_name
   AND YEAR(b.PublishingDate) >= pub_year;
 
CALL select_books_3('BHV С.-Петербург', 2000)


# 4.	Вивести загальну кількість сторінок по кожній назві категорії. Фільтр по спадаючій / зростанню кількості сторінок.
CREATE PROCEDURE select_books_4 ()
SELECT c.CatName,
	   SUM(b.Pages) AS Pages
  FROM books AS b
  	   JOIN categorys AS c
       ON c.Id = b.CategoryId
 GROUP BY c.CatName
 ORDER BY Pages DESC;
 
CALL select_books_4()


# 5.	Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.
CREATE PROCEDURE select_books_5 (IN t_name VARCHAR(50), IN c_name VARCHAR(50))
SELECT AVG(b.Price) AS AveragePrice, 
	     t.ThemeName, 
	     c.CatName
  FROM books AS b
  	   JOIN themes as t
  	   ON t.Id = b.ThemeId
  	   JOIN categorys AS c
       ON c.Id = b.CategoryId
 GROUP BY t.ThemeName, c.CatName
HAVING t.ThemeName = t_name OR c.CatName = c_name;
 
CALL select_books_5('Використання ПК в цілому', 'Linux')


# 6.	Вивести всі дані універсального відношення.
CREATE PROCEDURE select_books_6 ()
SELECT *
  FROM books AS b
  	   JOIN themes as t
  	   ON t.Id = b.ThemeId
  	   JOIN categorys AS c
       ON c.Id = b.CategoryId
       JOIN publishers AS p
       ON p.Id = b.PublisherId;
 
CALL select_books_6()


# 7.	Вивести пари книг, що мають однакову кількість сторінок.
CREATE PROCEDURE select_books_7 ()
SELECT b1.Name AS FirstBook,
       b2.Name AS SecondBook,
       b1.Pages
  FROM books b1, books b2
 WHERE b1.Pages = b2.Pages 
   AND b1.N != b2.N 
 GROUP BY Pages;
 
CALL select_books_7()


# 8.	Вивести тріади книг, що мають однакову ціну.
CREATE PROCEDURE select_books_8 ()
SELECT b1.Name AS FirstBook,
       b2.Name AS SecondBook,
       b3.Name AS ThirdBook,
       b1.Price
  FROM books b1, books b2, books b3
 WHERE b1.Price = b2.Price 
   AND b1.Price = b3.Price
   AND b1.N != b2.N
   AND b1.N != b3.N
   AND b2.N != b3.N
 GROUP BY b1.Price;
 
CALL select_books_8()


# 9.	Вивести всі книги категорії 'C ++'.
CREATE PROCEDURE select_books_9 (IN c_name VARCHAR(50))
SELECT * FROM books 
 WHERE CategoryId = (SELECT Id FROM categorys WHERE CatName = c_name);
 
CALL select_books_9('C&C++')


# 10.	Вивести список видавництв, у яких розмір книг перевищує 400 сторінок.
CREATE PROCEDURE select_books_10 (IN pages INT)
SELECT * FROM publishers p
 WHERE p.Id IN (SELECT Id FROM books b WHERE b.PublisherId = p.Id AND b.Pages >= pages);
 
CALL select_books_10(400)


# 11.	Вивести список категорій за якими більше 3-х книг.
CREATE PROCEDURE select_books_11 (IN count_books INT)
SELECT * FROM categorys c
 WHERE (SELECT COUNT(Id) FROM books b WHERE b.CategoryId = c.Id) >= count_books;
 
CALL select_books_11(3)


# 12.	Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва.
CREATE PROCEDURE select_books_12 (IN pub_name VARCHAR(50))
SELECT * FROM books b
 WHERE EXISTS (SELECT * FROM publishers p WHERE b.PublisherId = p.Id AND p.PubName = pub_name);
 
CALL select_books_12('BHV С.-Петербург')


# 13.	Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва.
CREATE PROCEDURE select_books_13 (IN pub_name VARCHAR(50))
SELECT * FROM books b
 WHERE NOT EXISTS (SELECT * FROM publishers p WHERE b.PublisherId = p.Id AND p.PubName = pub_name);
 
CALL select_books_13('BHV С.-Петербург')


# 14.	Вивести відсортоване загальний список назв тем і категорій.
CREATE PROCEDURE select_books_14 ()
SELECT ThemeName AS Name
  FROM themes
 UNION 
SELECT CatName AS Name
  FROM categorys
 ORDER BY Name;
 
CALL select_books_14()

# 15.	Вивести відсортований в зворотному порядку загальний список перших слів назв книг і категорій що не повторюються
CREATE PROCEDURE select_books_15 ()
SELECT LEFT(Name, 1) AS Name
  FROM books
 UNION 
SELECT LEFT(CatName, 1) AS Name
  FROM categorys
 ORDER BY Name DESC;
 
CALL select_books_15()


