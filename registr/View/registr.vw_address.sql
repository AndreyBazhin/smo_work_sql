CREATE VIEW registr.vw_address
AS
SELECT
  f.KodFReg
 ,CAST(f.Id AS BIGINT) AS registr_id
 ,IIF(f.OsobStatus = 10, 1, NULL) AS bomj
 ,IIF(drr.Raj IS NOT NULL, f.IndexReg, NULL) AS postcode_r
 ,IIF(drr.Raj IS NOT NULL, 'Кировская обл.', NULL) + COALESCE(',' + IIF(drr.Raj LIKE ' г.%', drr.Raj, ' ' + drr.Raj + ' р-н'), '') + IIF(f.KodNasPReg = 11000, '', COALESCE(', ' + drnp.Socr + '.' + drnp.NasP, '')) + COALESCE(', ' + dru.Socr + '.' + REPLACE(IIF(PATINDEX('%(ранее%', dru.Ul) > 0, LEFT(dru.Ul, PATINDEX('%(ранее%', dru.Ul) - 2), dru.Ul), '(Н-Вят)', '(Нововятский)'), '') + COALESCE(', д.' + f.DomReg, '') + COALESCE('/' + f.KorpReg, '') + COALESCE('/' + f.StrReg, '') + COALESCE(', кв.' + f.KvReg, '') AS address_r
 ,IIF(fdrr.Raj IS NOT NULL, f.IndexFak, NULL) AS postcode_f
 ,IIF(fdrr.Raj IS NOT NULL, 'Кировская обл.', NULL) + COALESCE(',' + IIF(fdrr.Raj LIKE ' г.%', fdrr.Raj, ' ' + fdrr.Raj + ' р-н'), '') + IIF(f.KodNasPFak = 11000, '', COALESCE(', ' + fdrnp.Socr + '.' + fdrnp.NasP, '')) + COALESCE(', ' + fdru.Socr + '.' + REPLACE(IIF(PATINDEX('%(ранее%', fdru.Ul) > 0, LEFT(fdru.Ul, PATINDEX('%(ранее%', fdru.Ul) - 2), fdru.Ul), '(Н-Вят)', '(Нововятский)'), '') + COALESCE(', д.' + f.DomFak, '') + COALESCE('/' + f.KorpFak, '') + COALESCE('/' + f.StrFak, '') + COALESCE(', кв.' + f.KvFak, '') AS address_f
FROM registr.vw_registr f
LEFT JOIN dict.vw_district drr
  ON f.KodRajReg = drr.KodRaj
LEFT JOIN dict.vw_city drnp
  ON f.KodNasPReg = drnp.KodNasP
LEFT JOIN dict.vw_street dru
  ON f.KodUlReg = dru.KodUl
LEFT JOIN dict.vw_district fdrr
  ON f.KodRajFak = fdrr.KodRaj
LEFT JOIN dict.vw_city fdrnp
  ON f.KodNasPFak = fdrnp.KodNasP
LEFT JOIN dict.vw_street fdru
  ON f.KodUlFak = fdru.KodUl
GO
