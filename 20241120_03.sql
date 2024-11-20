CREATE SCHEMA common

CREATE FUNCTION common.ShortFIO (@fio NVARCHAR(150))
RETURNS NVARCHAR(50)
BEGIN
  DECLARE @res NVARCHAR(50)

  SELECT @res = STRING_AGG(IIF(ctt.listpos = 1, ctt.str + ' ', SUBSTRING(ctt.str, 1, 1) + '.'), '') FROM dbo.charlist_to_table('Бажин Андрей Александрович', ' ') ctt
  RETURN @res
END

CREATE VIEW schet.vw_expertise_without_act
AS
SELECT
  2 AS etap
 ,e.idcase
FROM schet.vw_mee e
LEFT JOIN schet.vw_act a
  ON e.idact = a.idact
WHERE a.ActDate IS NULL
AND ISNULL(e.Deleted, 0) = 0
UNION
SELECT
  3 AS etap
 ,e.idcase
FROM schet.vw_ekmp e
LEFT JOIN schet.vw_act a
  ON e.idact = a.idact
WHERE a.ActDate IS NULL
AND ISNULL(e.Deleted, 0) = 0
GO

CREATE VIEW dict.vw_lpu
AS
SELECT
  vl.*
 ,l.medium_name
 ,l.FIO_GV
 ,l.FIO_GV_whom
 ,l.dogovor_number
 ,l.dogovor_date
 ,l.email
 ,l.email_bux
 ,l.phone
 ,l.sms_name
 ,l.mail_name
FROM schet.vw_lpu vl
LEFT JOIN dict.lpu l
  ON vl.lpu_id = l.lpu_id