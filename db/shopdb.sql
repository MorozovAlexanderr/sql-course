-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Фев 14 2021 г., 13:21
-- Версия сервера: 10.3.22-MariaDB
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `shopdb`
--

-- --------------------------------------------------------

--
-- Структура таблицы `books`
--

CREATE TABLE `books` (
  `N` int(11) NOT NULL,
  `BookCode` int(11) NOT NULL,
  `IsNovelty` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'No',
  `Name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Price` float NOT NULL CHECK (`Price` > 0),
  `Publishing` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Pages` int(11) NOT NULL CHECK (`Pages` > 0),
  `Format` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PublishingDate` date NOT NULL,
  `Edition` int(11) DEFAULT NULL,
  `Theme` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Category` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT 'Інші книги'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`N`, `BookCode`, `IsNovelty`, `Name`, `Price`, `Publishing`, `Pages`, `Format`, `PublishingDate`, `Edition`, `Theme`, `Category`) VALUES
(1, 2344, 'Yes', 'Аппаратные средства мультимедия. Видеосистема РС', 10.5, 'BHV С.-Петербург', 300, '70х100/16', '2000-07-24', 4000, 'Використання ПК в цілому', 'Підручники'),
(2, 5432, 'No', 'Железо IBM 2001.', 8.3, 'МикроАрт', 200, '70х100/16', '2001-10-13', 5000, 'Використання ПК в цілому', 'Інші книги'),
(3, 3221, 'No', 'Windows 2000 Professional шаг за шагом с СD', 12.3, 'Эком', 100, '70х100/16', '2000-05-25', 5000, 'Операційні системи', 'Windows 2000'),
(6, 1256, 'No', 'Linux Русские версии', 10.5, NULL, 126, '70х100/16', '2000-09-27', 3500, 'Операційні системи', 'Linux'),
(7, 3236, 'Yes', 'Защита и безопасность компьютерных систем', 15, 'DiaSoft', 356, '84х108/16', '1999-01-23', 5000, 'Використання ПК в цілому', 'Інші книги'),
(8, 4985, 'No', 'Освой самостоятельно модернизацию и ремонт ПК за 24 часа, 2-е изд.', 18.9, 'Вильямс', 288, '70х100/16', '2000-07-07', 5000, 'Використання ПК в цілому', 'Підручники'),
(9, 5141, 'No', 'Структуры данных и алгоритмы.', 37.8, 'Вильямс', 384, '70х100/16', '2000-09-29', 5000, 'Використання ПК в цілому', 'Підручники'),
(10, 5127, 'Yes', 'Автоматизация инженерно- графических работ', 11.58, 'Питер', 256, '70х100/16', '2000-06-15', 5000, 'Використання ПК в цілому', 'Підручники'),
(11, 3932, 'No', 'Как превратить персональный компьютер в измерительный комплекс', 7.65, 'ДМК', 144, '60х88/16', '1999-06-09', 5000, 'Використання ПК в цілому', 'Інші книги'),
(12, 4713, 'No', 'Plug- ins. Встраиваемые приложения для музыкальных программ', 11.41, 'ДМК', 144, '70х100/16', '2000-02-22', 5000, 'Використання ПК в цілому', 'Інші книги'),
(13, 5217, 'No', 'Windows МЕ. Новейшие версии программ', 16.57, 'Триумф', 320, '70х100/16', '2000-08-25', 5000, 'Операційні системи', 'Windows 2000'),
(14, 860, 'No', 'Операционная система UNIX', 3.5, 'BHV С.-Петербург', 395, '84х10016', '1997-05-05', 5000, 'Операційні системи', 'Unix'),
(15, 44, 'No', 'Ответы на актуальные вопросы по OS/2 Warp', 5, 'DiaSoft', 352, '60х84/16', '1996-03-20', 5000, 'Операційні системи', 'Інші операційні системи'),
(16, 5176, 'No', 'Windows Ме. Спутник пользователя', 12.79, 'Русская редакция', 306, '-', '2000-10-10', 5000, 'Операційні системи', 'Інші операційні системи'),
(17, 5462, 'No', 'Язык программирования С++. Лекции и упражнения', 29, 'DiaSoft', 656, '84х108/16', '2000-12-12', 5000, 'Програмування', 'C&C++'),
(18, 4982, 'No', 'Язык программирования С. Лекции и упражнения', 29, 'DiaSoft', 432, '84х108/16', '2000-07-12', 5000, 'Програмування', 'C&C++'),
(19, 4687, 'No', 'Эффективное использование C++ .50 рекомендаций по улучшению ваших программ и проектов', 17.6, 'ДМК', 240, '70х100/16', '2000-02-03', 5000, 'Програмування', 'C&C++');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`N`),
  ADD KEY `Price` (`Price`),
  ADD KEY `Pages` (`Pages`),
  ADD KEY `PublishingDate` (`PublishingDate`),
  ADD KEY `Edition` (`Edition`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `books`
--
ALTER TABLE `books`
  MODIFY `N` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
