CREATE VIEW schet.vw_act
AS
SELECT
  *
FROM xml_schet.EXPERT.ActOut
GO

CREATE FUNCTION schet.SMOPrefix ()
RETURNS VARCHAR(5)
BEGIN
  DECLARE @res VARCHAR(5)
  SELECT
    @res = value
  FROM xml_schet.ART.options
  WHERE paramname = 'SMOPrefix'
  RETURN @res
END 

CREATE VIEW schet.vw_videksp 
AS SELECT ve.*
FROM xml_schet.ART.VidEksp ve

CREATE VIEW dict.vw_users
AS 
SELECT t.KodUser
      ,t.FIO COLLATE Cyrillic_General_100_CI_AS AS fio
      ,t.KodFil
      ,t.Uvolen
      ,t.SMO
FROM TRegSMO2011.dbo.TRUsers t
WHERE t.KodFil = config.KodSMO() AND t.KodUser > 1000
UNION
SELECT t.KodUser
      ,t.FIO COLLATE Cyrillic_General_100_CI_AS
      ,t.KodFil
      ,t.Uvolen
      ,t.SMO
FROM xml_schet.DICT.TRUsers t
WHERE t.KodFil = config.KodSMO() AND t.KodUser > 1000