USE smo_work
GO

IF DB_NAME() <> N'smo_work' SET NOEXEC ON
GO

--
-- Начать транзакцию
--
BEGIN TRANSACTION
GO

--
-- Удалить столбец [FIO] из таблицы [config].[users]
--
ALTER TABLE config.users
  DROP COLUMN IF EXISTS FIO
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Удалить столбец [dismissed] из таблицы [config].[users]
--
ALTER TABLE config.users
  DROP COLUMN IF EXISTS dismissed
GO
IF @@ERROR<>0 OR @@TRANCOUNT=0 BEGIN IF @@TRANCOUNT>0 ROLLBACK SET NOEXEC ON END
GO

--
-- Фиксировать транзакцию
--
IF @@TRANCOUNT>0 COMMIT TRANSACTION
GO

--
-- Установить NOEXEC в состояние off
--
SET NOEXEC OFF
GO