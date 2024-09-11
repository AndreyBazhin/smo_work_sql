CREATE VIEW schet.vw_lpu
AS
SELECT
  kod AS lpu_id,
  *
FROM vrschet.DICT.Ref_BaseLPU rbl
GO