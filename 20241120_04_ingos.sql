CREATE VIEW dict.vw_smo
AS
SELECT
  *
FROM TRegSMO2011.dbo.Ref_SMO
GO

create VIEW schet.vw_mek
AS
SELECT
  *
FROM xml_schet.EXPERT.mek