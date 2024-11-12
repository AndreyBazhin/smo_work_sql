--Таблица с дополнительными данными пользователей
CREATE TABLE smo_work.config.users (
  KodUser INT NULL
 ,FIO VARCHAR(50) NULL
 ,dismissed INT NULL
 ,work_name VARCHAR(200) NULL
 ,work_phone VARCHAR(20) NULL
 ,work_address VARCHAR(200) NULL
) ON [PRIMARY]
GO

--Таблица с дополнительными параметрами ЛПУ
﻿CREATE TABLE smo_work.dict.lpu (
  lpu_id INT NOT NULL
 ,medium_name VARCHAR(200) NULL
 ,FIO_GV NVARCHAR(50) NULL
 ,FIO_GV_whom NVARCHAR(50) NULL
 ,dogovor_number NVARCHAR(50) NULL
 ,dogovor_date DATE NULL
 ,email NVARCHAR(100) NULL
 ,email_bux VARCHAR(100) NULL
 ,phone VARCHAR(50) NULL
 ,sms_name VARCHAR(50) NULL
 ,mail_name VARCHAR(50) NULL
) ON [PRIMARY]
GO

﻿CREATE VIEW dict.vw_lpu
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
LEFT JOIN dict.lpu l ON vl.lpu_id = l.lpu_id
GO

--Таблица с дополнительными параметрами подразделений ЛПУ
﻿CREATE TABLE dict.lpu_department (
  RegKod INT NOT NULL
 ,sms_name VARCHAR(50) NULL
 ,mail_name VARCHAR(50) NULL
 ,phone VARCHAR(50) NULL
) ON [PRIMARY]
GO

﻿CREATE VIEW dict.vw_lpu_department
AS
  SELECT vld.*, ld.sms_name, ld.mail_name, ld.phone
  FROM schet.vw_lpu_department vld
  LEFT JOIN dict.lpu_department ld ON vld.RegKod = ld.RegKod

--Таблица с умершими ЗЛ
CREATE TABLE registr.deceased (
  registr_id BIGINT NOT NULL
 ,death_date DATE NOT NULL
) ON [PRIMARY]
GO

--Таблица с данными прикрепления ЗЛ к ЛПУ
CREATE TABLE registr.lpu_attach(
	registr_id bigint NOT NULL,
	result varchar(10) NULL,
	sostpolis int NULL,
	kodsmo int NULL,
	kodmo int NULL,
	rnuch varchar(8) NULL,
	sposobprikr int NULL,
	tipprikr int NULL,
	update_date datetime NULL
) ON [PRIMARY]
GO

--Вьюха с адресами из регистра
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

