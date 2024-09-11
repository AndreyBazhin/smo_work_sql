CREATE VIEW schet.vw_lpu
AS
SELECT
  kod AS lpu_id,
  *
FROM xml_schet.DICT.Ref_BaseLPU rbl
GO