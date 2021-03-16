# 1.	Вивести значення наступних колонок: назва книги, ціна, назва видавництва. Використовувати внутрішнє з'єднання, застосовуючи where.
SELECT b.Name, 
	     b.Price, 
       p.PubName 
  FROM books AS b, publishers AS p
 WHERE p.Id = b.PublisherId;


# 2.	Вивести значення наступних колонок: назва книги, назва категорії. Використовувати внутрішнє з'єднання, застосовуючи inner join.
SELECT b.Name, 
	     c.CatName
  FROM books AS b
  	   JOIN categorys AS c
       ON c.Id = b.CategoryId;


# 3.	Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат.
SELECT b.Name, 
	     b.Price, 
	     b.Format
       p.PubName 
  FROM books AS b
  	   JOIN publishers AS p
       ON p.Id = b.PublisherId;


# 4.	Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям.
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


# 5.	Вивести книги видавництва 'BHV', видані після 2000 р
SELECT b.Name, 
       p.PubName 
  FROM books AS b
  	   JOIN publishers AS p
       ON p.Id = b.PublisherId 
 WHERE p.PubName = 'BHV С.-Петербург' 
   AND YEAR(b.PublishingDate) >= 2000


# 6.	Вивести загальну кількість сторінок по кожній назві категорії. Фільтр по спадаючій кількості сторінок.
SELECT c.CatName,
	     SUM(b.Pages) AS Pages
  FROM books AS b
  	   JOIN categorys AS c
       ON c.Id = b.CategoryId
 GROUP BY c.CatName


# 7.	Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.
SELECT AVG(b.Price) AS AveragePrice, 
	     t.ThemeName, 
	     c.CatName
  FROM books AS b
  	   JOIN themes as t
  	   ON t.Id = b.ThemeId
  	   JOIN categorys AS c
       ON c.Id = b.CategoryId
 GROUP BY t.ThemeName, c.CatName
HAVING t.ThemeName = 'Використання ПК в цілому' OR c.CatName = 'Linux'


# 8.	Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи where.
SELECT *
  FROM books AS b, 
       themes AS t, 
       categorys AS c, 
       publishers AS p
 WHERE t.Id = b.ThemeId 
   AND c.Id = b.CategoryId 
   AND p.Id = b.PublisherId


# 9.	Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи inner join.
SELECT *
  FROM books AS b
  	   JOIN themes as t
  	   ON t.Id = b.ThemeId
  	   JOIN categorys AS c
       ON c.Id = b.CategoryId
       JOIN publishers AS p
       ON p.Id = b.PublisherId


# 10.	Вивести всі дані універсального відношення. Використовувати зовнішнє з'єднання, застосовуючи left join / rigth join.
SELECT *
  FROM books AS b
  	   LEFT JOIN themes as t
  	   ON t.Id = b.ThemeId
  	   LEFT JOIN categorys AS c
       ON c.Id = b.CategoryId
       LEFT JOIN publishers AS p
       ON p.Id = b.PublisherId


# 11. Вивести пари книг, що мають однакову кількість сторінок. Використовувати само об’єднання і аліаси (self join).
SELECT b1.Name AS FirstBook,
       b2.Name AS SecondBook,
       b1.Pages
  FROM books b1, books b2
 WHERE b1.Pages = b2.Pages 
   AND b1.N != b2.N 
 GROUP BY Pages


# 12. Вивести тріади книг, що мають однакову ціну. Використовувати самооб'єднання і аліаси (self join).
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
 GROUP BY b1.Price


# 13. Вивести всі книги категорії 'C ++'. Використовувати підзапити (subquery).
SELECT * FROM books 
 WHERE CategoryId = (SELECT Id FROM categorys WHERE CatName = 'C&C++')


# 14. Вивести книги видавництва 'BHV', видані після 2000 р Використовувати підзапити (subquery).
SELECT * FROM books 
 WHERE PublisherId = (SELECT Id FROM publishers WHERE PubName = 'BHV С.-Петербург')
   AND YEAR(PublishingDate) >= 2000


# 15. Вивести список видавництв, у яких розмір книг перевищує 400 сторінок. Використовувати пов'язані підзапити (correlated subquery).
SELECT * FROM publishers p
 WHERE p.Id IN (SELECT Id FROM books b WHERE b.PublisherId = p.Id AND b.Pages >= 400)


# 16. Вивести список категорій в яких більше 3-х книг. Використовувати пов'язані підзапити (correlated subquery).
SELECT * FROM categorys c
 WHERE (SELECT COUNT(Id) FROM books b WHERE b.CategoryId = c.Id) >= 3


# 17. Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва. Використовувати exists.
SELECT * FROM books b
 WHERE EXISTS (SELECT * FROM publishers p WHERE b.PublisherId = p.Id AND p.PubName = 'BHV С.-Петербург')


# 18. Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва. Використовувати not exists.
SELECT * FROM books b
 WHERE NOT EXISTS (SELECT * FROM publishers p WHERE b.PublisherId = p.Id AND p.PubName = 'BHV С.-Петербург')


# 19. Вивести відсортований загальний список назв тем і категорій. Використовувати union.
SELECT ThemeName AS Name
  FROM themes
 UNION 
SELECT CatName AS Name
  FROM categorys
 ORDER BY Name


# 20. Вивести відсортований в зворотному порядку загальний список перших слів, назв книг і категорій що не повторюються. Використовувати union.
SELECT LEFT(Name, 1) AS Name
  FROM books
 UNION 
SELECT LEFT(CatName, 1) AS Name
  FROM categorys
 ORDER BY Name DESC