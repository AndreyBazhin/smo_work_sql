--Функция с номером СМО
CREATE FUNCTION config.KodSMO ()
RETURNS INT
BEGIN
  RETURN 11
END 
GO

--Вьюхи из базы счетов и регистра
CREATE VIEW dict.vw_city
  AS SELECT * FROM smo_treg.dbo.Ref_NasP
GO

CREATE VIEW dict.vw_district
  AS SELECT * FROM smo_treg.dbo.Ref_Raj
GO

CREATE VIEW dict.vw_f008
  AS SELECT * FROM vrschet.DICT.F008
GO

CREATE VIEW dict.vw_medical_worker
  AS SELECT * FROM vrschet.DICT.RegistrMR
GO

CREATE VIEW dict.vw_medical_worker_position
  AS SELECT * FROM vrschet.DICT.ZanDoljn
GO

CREATE VIEW dict.vw_mkb10
  AS SELECT * FROM vrschet.DICT.St_MKB
GO

CREATE VIEW dict.vw_profilGG
  AS SELECT * FROM vrschet.DICT.Ref_ProfilGG rpg
GO

CREATE VIEW dict.vw_street
  AS SELECT * FROM smo_treg.dbo.Ref_Ul
GO

CREATE VIEW dict.vw_videksp
  AS SELECT * FROM vrschet.dbo.vw_videksp
GO

CREATE VIEW registr.vw_registr
  AS SELECT * FROM smo_treg.dbo.FRegistr
GO

CREATE VIEW schet.vw_act
  AS SELECT * FROM vrschet.EXPERT.ActOut
GO

CREATE VIEW schet.vw_ekmp
  AS SELECT * FROM vrschet.EXPERT.ekmp
GO

CREATE VIEW schet.vw_lpu
  AS SELECT kod AS lpu_id, * FROM vrschet.DICT.Ref_BaseLPU rbl
GO

CREATE VIEW schet.vw_lpu_department
  AS SELECT * FROM vrschet.DICT.Ref_Otdel
GO

CREATE VIEW schet.vw_mee
  AS SELECT * FROM vrschet.EXPERT.mee
GO

CREATE VIEW schet.vw_person
  AS SELECT * FROM vrschet.WORKPLACE.person
GO

CREATE VIEW schet.vw_schet
  AS SELECT * FROM vrschet.WORKPLACE.schet
GO

CREATE VIEW schet.vw_sluch_base
  AS SELECT * FROM vrschet.WORKPLACE.sluch_base
GO

CREATE VIEW schet.vw_sluch_dopinfo
  AS SELECT * FROM vrschet.WORKPLACE.sluch_dopinfo
GO

CREATE VIEW schet.vw_sluch_patient
  AS SELECT * FROM vrschet.WORKPLACE.sluch_patient
GO

