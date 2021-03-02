# 1. Вивести статистику: загальна кількість всіх книг, їх вартість, їх середню вартість, мінімальну і максимальну ціну
SELECT COUNT(*) AS Total,
	   SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books


# 2. Вивести загальну кількість всіх книг без урахування книг з непроставленою ціною
SELECT COUNT(*) AS Total 
  FROM books 
 WHERE Price IS NOT NULL


# 3. Вивести статистику (див. 1) для книг новинка / не новинка
SELECT IsNovelty, 
	   COUNT(*) AS Total,
	   SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books 
 GROUP BY IsNovelty


 # 4. Вивести статистику (див. 1) для книг за кожним роком видання
SELECT YEAR(PublishingDate) AS PublishingYear, 
       COUNT(*) AS Total,
       SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books 
 GROUP BY PublishingYear


# 5. Змінити п.4, виключивши з статистики книги з ціною від 10 до 20
SELECT YEAR(PublishingDate) AS PublishingYear, 
       COUNT(*) AS Total,
       SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books 
 WHERE Price < 10 OR Price > 20
 GROUP BY PublishingYear 


# 6. Змінити п.4. Відсортувати статистику по спадаючій кількості.
SELECT YEAR(PublishingDate) AS PublishingYear, 
       COUNT(*) AS Total,
       SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books 
 GROUP BY PublishingYear 
 ORDER BY Total DESC


# 7. Вивести загальну кількість кодів книг і кодів книг що не повторюються
SELECT COUNT(BookCode) AS BookCode,
	   COUNT(DISTINCT BookCode) AS NonRepeatBookCode
  FROM books


# 8. Вивести статистику: загальна кількість і вартість книг по першій букві її назви
SELECT LEFT(Name, 1) AS FirstLetter, 
	   COUNT(N) AS Total,
       SUM(Price) AS TotalPrice
  FROM books 
 GROUP BY FirstLetter 


# 9. Змінити п. 8, виключивши з статистики назви що починаються з англ. букви або з цифри.
SELECT LEFT(Name, 1) AS FirstLetter, 
	   COUNT(N) AS Total,
       SUM(Price) AS TotalPrice
  FROM books 
 GROUP BY FirstLetter 
HAVING FirstLetter REGEXP "[а-я]" 


# 10. Змінити п. 9 так щоб до складу статистики потрапили дані з роками більшими за 2000.
SELECT LEFT(Name, 1) AS FirstLetter, 
	   COUNT(N) AS Total,
       SUM(Price) AS TotalPrice
  FROM books 
 WHERE YEAR(PublishingDate) >= 2000 
 GROUP BY FirstLetter 
HAVING FirstLetter REGEXP "[а-я]"


# 11. Змінити п. 10. Відсортувати статистику по спадаючій перших букв назви.
SELECT LEFT(Name, 1) AS FirstLetter, 
	   COUNT(N) AS Total,
       SUM(Price) AS TotalPrice
  FROM books 
 WHERE YEAR(PublishingDate) >= 2000 
 GROUP BY FirstLetter 
HAVING FirstLetter REGEXP "[а-я]" 
 ORDER BY FirstLetter DESC


# 12. Вивести статистику (див. 1) по кожному місяцю кожного року.
SELECT YEAR(PublishingDate) AS DateYear,
	   MONTH(PublishingDate) AS DateMonth, 
       COUNT(*) AS Total,
	   SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books 
 GROUP BY DateYear, DateMonth


# 13. Змінити п. 12 так щоб до складу статистики не увійшли дані з незаповненими датами.
SELECT MONTH(PublishingDate) AS DateMonth, 
       COUNT(*) AS Total,
	   SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books 
 WHERE PublishingDate IS NOT NULL 
 GROUP BY DateMonth


# 14. Змінити п. 12. Фільтр по спадаючій року і зростанню місяця.
SELECT YEAR(PublishingDate) AS DateYear,
	   MONTH(PublishingDate) AS DateMonth, 
       COUNT(*) AS Total,
	   SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books 
 GROUP BY DateYear, DateMonth 
 ORDER BY DateYear DESC, DateMonth


# 15. Вивести статистику для книг новинка / не новинка: загальна ціна, загальна ціна в грн. / Євро / руб. Колонкам запиту дати назви за змістом.
SELECT IsNovelty, 
	   SUM(Price) AS Price,
	   CONCAT('€', SUM(Price) * 0.03) AS PriceEuro,
	   CONCAT('₽', SUM(Price) * 2.67) AS PriceRuble  
  FROM books 
 GROUP BY IsNovelty


# 16. Змінити п. 15 так щоб виводилася округлена до цілого числа (дол. / Грн. / Євро / руб.) Ціна.
SELECT IsNovelty, 
	   CEILING(SUM(Price)) AS Price,
	   CONCAT('€', CEILING(SUM(Price) * 0.03)) AS PriceEuro,
	   CONCAT('₽', CEILING(SUM(Price) * 2.67)) AS PriceRuble  
  FROM books 
 GROUP BY IsNovelty


# 17. Вивести статистику (див. 1) по видавництвах.
SELECT Publishing, 
	   COUNT(*) AS Total,
	   SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books 
 WHERE Publishing IS NOT NULL 
 GROUP BY Publishing


# 18. Вивести статистику (див. 1) за темами і видавництвами. Фільтр по видавництвам.
SELECT Theme, 
	   Publishing, 
	   COUNT(*) AS Total,
	   SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books 
 WHERE Publishing IS NOT NULL 
 GROUP BY Theme, Publishing 
 ORDER BY Publishing


# 19. Вивести статистику (див. 1) за категоріями, темами і видавництвами. Фільтр по видавництвам, темах, категоріям.
SELECT Category,
	   Theme, 
	   Publishing, 
	   COUNT(*) AS Total,
	   SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books 
 WHERE Publishing IS NOT NULL 
 GROUP BY Theme, Publishing 
 ORDER BY Publishing, Theme, Category


# 20. Вивести список видавництв, у яких округлена до цілого ціна однієї сторінки більше 10 копійок.
SELECT Publishing,
	   COUNT(*) AS Total,
	   SUM(Price) AS TotalPrice,
       AVG(Price) AS AveragePrice,
       SUM(Pages) AS TotalPages,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
  FROM books 
 WHERE Publishing IS NOT NULL 
 GROUP BY Publishing 
 HAVING CEILING(TotalPrice / TotalPages) >= 0.1