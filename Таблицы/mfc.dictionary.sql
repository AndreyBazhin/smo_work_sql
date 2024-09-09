IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[mfc].[dictionary]') AND type in (N'U'))
DROP TABLE [mfc].[dictionary]
GO

CREATE TABLE mfc.dictionary
(
  dictionary_id INT IDENTITY(1,1) NOT NULL,
  dictionary_type varchar(20) not null,
  ident int not NULL,
  value varchar(200),
  visible int
)
--Тип заявления
insert into mfc.dictionary(dictionary_type, ident, value, visible)
values ('action_type', 1, 'Первичный выбор', 1);
insert into mfc.dictionary(dictionary_type, ident, value, visible)
values ('action_type', 2, 'Смена СМО', 1);
insert into mfc.dictionary(dictionary_type, ident, value, visible)
values ('action_type', 3, 'Переоформление полиса', 1);
insert into mfc.dictionary(dictionary_type, ident, value, visible)
values ('action_type', 4, 'Запрос на предоставление выписки', 1);

--Кто представитель
insert into mfc.dictionary(dictionary_type, ident, value, visible)
values ('relation', 1, 'Мать', 1);
insert into mfc.dictionary(dictionary_type, ident, value, visible)
values ('relation', 2, 'Отец', 1);
insert into mfc.dictionary(dictionary_type, ident, value, visible)
values ('relation', 3, 'Иное', 1);
insert into mfc.dictionary(dictionary_type, ident, value, visible)
values ('relation', 4, 'Опекун', 1);
insert into mfc.dictionary(dictionary_type, ident, value, visible)
values ('relation', 5, 'Попечитель', 1);
insert into mfc.dictionary(dictionary_type, ident, value, visible)
values ('relation', 6, 'Усыновитель', 1);
