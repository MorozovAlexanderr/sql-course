# 1.	Розробити та перевірити скалярну (scalar) функцію, що повертає загальну вартість книг виданих в певному році.
CREATE FUNCTION sum_price_by_year (pub_year INT)
RETURNS DOUBLE
RETURN (SELECT SUM(Price) 
          FROM books 
         WHERE YEAR(PublishingDate) = pub_year)

SELECT sum_price_by_year(2000) AS sum_price;


# 2.	Розробити і перевірити табличну (inline) функцію, яка повертає список книг виданих в певному році.
CREATE PROCEDURE get_book_list_by_year (IN pub_year INT)
SELECT * 
  FROM books 
 WHERE YEAR(PublishingDate) = pub_year;

CALL get_book_list_by_year(2000);


-- 4.	Виконати набір операцій по роботі з SQL курсором: оголосити курсор;
-- 		a.	використовувати змінну для оголошення курсору;
-- 		b.	відкрити курсор;
-- 		c.	переприсвоїти курсор іншої змінної;
-- 		d.	виконати вибірку даних з курсору;
-- 		e.	закрити курсор;

DELIMITER $$
CREATE PROCEDURE test_cursors(INOUT return_val INT)
BEGIN
	DECLARE a, done INT;
	DECLARE cur_1 CURSOR FOR SELECT Price FROM books;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	OPEN cur_1; 
    REPEAT
    	FETCH cur_1 INTO a;
	UNTIL done = 1
    END REPEAT;
	CLOSE cur_1;
	SET return_val = a;
END; $$

CALL test_cursors(@R);
SELECT @R;


# 5.	звільнити курсор. Розробити курсор для виводу списка книг виданих у визначеному році.
DELIMITER $$
CREATE FUNCTION get_book_list_by_year_with_cur(pub_year INT)
RETURNS TEXT
BEGIN
	DECLARE flg, done INT DEFAULT FALSE;
    DECLARE b_name VARCHAR(100);
    DECLARE book_list TEXT;
	DECLARE cur_1 CURSOR FOR SELECT Name FROM books WHERE YEAR(PublishingDate) = pub_year;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	OPEN cur_1; 
    SET book_list = '';
    SET flg = 0;
    REPEAT
    	FETCH cur_1 INTO b_name;
        IF flg != 0 THEN
           SET book_list = CONCAT(book_list, ', ', b_name);
         ELSE
           SET book_list = b_name;
           SET flg = 1;     
        END IF;
	UNTIL done = TRUE
    END REPEAT;
	CLOSE cur_1;
    RETURN book_list;
END; $$

SELECT get_book_list_by_year_with_cur(2020);