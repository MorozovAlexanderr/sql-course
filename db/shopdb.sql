-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Фев 09 2021 г., 13:22
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
  `Name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Price` float NOT NULL CHECK (`Price` > 0),
  `Publishing` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Pages` int(11) NOT NULL CHECK (`Pages` > 0),
  `Format` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `PublishingDate` date NOT NULL,
  `Edition` int(11) DEFAULT NULL,
  `Theme` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Category` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT 'Інші книги'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`N`, `BookCode`, `IsNovelty`, `Name`, `Price`, `Publishing`, `Pages`, `Format`, `PublishingDate`, `Edition`, `Theme`, `Category`) VALUES
(1, 2344, 'Yes', 'Аппаратные средства мультимедия. Видеосистема РС', 10.5, 'BHV С.-Петербург', 300, '70х100/16', '2000-07-24', 4000, NULL, 'Підручники'),
(2, 5432, 'No', 'Железо IBM 2001.', 8.3, NULL, 200, '70х100/16', '2001-10-13', 5000, NULL, 'Інші книги'),
(3, 3221, 'No', 'Windows 2000 Professional шаг за шагом с СD', 12.3, 'Эком', 100, '70х100/16', '2000-05-25', 0, NULL, 'Windows 2000');

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
  MODIFY `N` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
