USE smo_work
GO

ALTER VIEW schet.vw_act_print_main
AS
SELECT
  va.idact
 ,CASE va.IDVID
    WHEN 50 THEN 'п'
    WHEN 51 THEN 'вп/т'
    WHEN 52 THEN 'вп/п'
    WHEN 53 THEN 'вп/ж'
    WHEN 54 THEN 'вп/ХТ'
    WHEN 55 THEN 'вп/дисп'
    WHEN 56 THEN 'вп/л'
    WHEN 57 THEN 'вп/неЛ'
    WHEN 58 THEN 'вп/тфомс'
    WHEN 70 THEN 'п'
    WHEN 71 THEN 'вп/ж'
    WHEN 72 THEN 'вп/л'
    WHEN 73 THEN 'вп/рез.МЭЭ'
    WHEN 74 THEN 'вп/вред'
    WHEN 75 THEN 'вп/рез.МЭЭ'
    WHEN 76 THEN 'вп/рез.МЭЭ'
    WHEN 78 THEN 'вп/тфомс'
    WHEN 79 THEN 'вп/м/ж'
    WHEN 80 THEN 'вп/м/л'
    WHEN 81 THEN 'вп/м/covid'
    WHEN 82 THEN 'вп/м/нз'
    WHEN 83 THEN 'вп/м/перевод'
    WHEN 84 THEN 'вп/м/рез.ЭКМП'
    WHEN 85 THEN 'вп/т'
    WHEN 87 THEN 'п'
    WHEN 88 THEN 'вп/мсэк'
    WHEN 89 THEN 'вп/м/тфомс'
    WHEN 90 THEN 'вп/п'
    WHEN 91 THEN 'вп/ХТ'
    WHEN 92 THEN 'вп/дисп'
    WHEN 93 THEN 'вп/неЛ'
  END AS socr
 ,schet.SMOPrefix() + CAST(va.Etap AS NVARCHAR(1)) + CAST(vs.foms_year AS VARCHAR(4)) + '.' + COALESCE(va.ActNumber, CAST(va.idact AS NVARCHAR(50))) AS act_number
 ,CAST(va.ActDate AS DATE) AS act_date
 ,IIF(ISNULL(ve.TipEksp, 0) = 2, 'V', '_') AS exp_povtor
 ,IIF(ISNULL(ve.PlanEksp, 0) = 1, 'V', '_') AS exp_plan
 ,IIF(ISNULL(ve.PlanEksp, 0) = 0, 'V', '_') AS exp_vp
 ,IIF(ISNULL(ve.PlanEksp, 0) = 0 AND ISNULL(ve.TematEksp, 0) = 1, 'V', '_') AS exp_temat
 ,IIF(ISNULL(ve.PlanEksp, 0) = 0 AND ISNULL(ve.TematEksp, 0) = 0, 'V', '_') AS exp_cel
 ,IIF(ISNULL(ve.PlanEksp, 0) = 0 AND ISNULL(ve.TematEksp, 0) = 0, ve.MenuName, '') AS exp_osn
 ,vu.FIO AS isp_fio
 ,CASE va.Etap
    WHEN 2 THEN mee_detail.exp_date_1 
    WHEN 3 THEN ekmp_detail.exp_date_1 
  END AS exp_date_1
 ,va.ActDate AS exp_date_2
 ,rs.NaimOtdKO AS smo_name
 ,ISNULL(lpu.medium_name, lpu.PolnNaim) AS lpu_name
 ,IIF(ISNULL(va.usl_ok, 3) = 4, 'V', '_') AS usl_ok_4
 ,IIF(ISNULL(va.usl_ok, 3) = 3, 'V', '_') AS usl_ok_3
 ,IIF(ISNULL(va.usl_ok, 3) = 2, 'V', '_') AS usl_ok_2
 ,IIF(ISNULL(va.usl_ok, 3) = 1, 'V', '_') AS usl_ok_1
 ,vs.nschet AS schet_num
 ,CAST(vs.dschet AS DATE) AS schet_date
 ,CASE va.Etap
    WHEN 2 THEN CAST(mee_detail.date_1 AS DATE)
    WHEN 3 THEN CAST(ekmp_detail.date_1 AS DATE)
  END AS date_1
 ,CASE va.Etap
    WHEN 2 THEN CAST(mee_detail.date_2 AS DATE)
    WHEN 3 THEN CAST(ekmp_detail.date_2 AS DATE)
  END AS date_2
 ,CASE va.Etap
    WHEN 2 THEN mee_detail.sluch_count 
    WHEN 3 THEN ekmp_detail.sluch_count 
  END AS sluch_count
 ,CASE va.Etap
    WHEN 2 THEN mee_detail.sluch_sum 
    WHEN 3 THEN ekmp_detail.sluch_sum 
  END AS sluch_sum
 ,CASE va.Etap
    WHEN 2 THEN mee_detail.sank_count 
    WHEN 3 THEN ekmp_detail.sank_count 
  END AS sank_count
 ,CASE va.Etap
    WHEN 2 THEN mee_detail.fin_sank_count 
    WHEN 3 THEN ekmp_detail.fin_sank_count 
  END AS fin_sank_count
 ,CASE va.Etap
    WHEN 2 THEN mee_detail.fin_sank_sum 
    WHEN 3 THEN ekmp_detail.fin_sank_sum 
  END AS fin_sank_sum
 ,CASE va.Etap
    WHEN 2 THEN mee_detail.shtraf_count 
    WHEN 3 THEN ekmp_detail.shtraf_count 
  END AS shtraf_count
 ,CASE va.Etap
    WHEN 2 THEN mee_detail.shtraf_sum 
    WHEN 3 THEN ekmp_detail.shtraf_sum 
  END AS shtraf_sum
 ,CASE va.Etap
    WHEN 2 THEN mee_detail.vyvod 
    WHEN 3 THEN ekmp_detail.vyvod 
  END AS vyvod
FROM schet.vw_act va
JOIN schet.vw_schet vs
  ON va.idschet = vs.idschet
LEFT JOIN schet.vw_videksp ve
  ON va.IDVID = ve.IDVID
JOIN dict.vw_users vu
  ON va.KodOtvIsp = vu.KodUser
JOIN dict.vw_lpu lpu ON vs.kodbaselpu = lpu.kod
OUTER APPLY (
  SELECT
    MIN(mee.Created) AS exp_date_1,
    MIN(vsb.date_1) AS date_1,
    MAX(vsb.date_2) AS date_2,
    COUNT(*) AS sluch_count,
    CAST(SUM(mek.SummaP) AS NUMERIC(15,2)) AS sluch_sum,
    SUM(IIF(ISNULL(mee.FinSank, 0) > 0 OR ISNULL(mee.Shtraf, 0) > 0, 1, 0)) AS sank_count,
    SUM(IIF(ISNULL(mee.FinSank, 0) > 0, 1, 0)) AS fin_sank_count,
    CAST(SUM(ISNULL(mee.FinSank, 0)) AS NUMERIC(15,2)) AS fin_sank_sum,
    SUM(IIF(ISNULL(mee.Shtraf, 0) > 0, 1, 0)) AS shtraf_count,
    CAST(SUM(ISNULL(mee.Shtraf, 0)) AS NUMERIC(15,2)) AS shtraf_sum,
    SUM(IIF(mee.KodPrichOtkazFD IS NOT NULL, 1, 0)) AS vyvod
  FROM schet.vw_mee mee
--  JOIN schet.vw_sluch_base vsb ON mee.idcase = vsb.idcase
  OUTER APPLY(SELECT * FROM schet.vw_sluch_base sb WHERE mee.idcase = sb.idcase) vsb
  OUTER APPLY (
    SELECT TOP 1 *
    FROM schet.vw_mek m
    WHERE mee.idcase = m.idcase AND ISNULL(m.Deleted, 0) = 0
    ORDER BY m.mek_id DESC
  ) mek
  WHERE va.idact = mee.idact AND ISNULL(mee.Deleted, 0) = 0
) mee_detail
OUTER APPLY (
  SELECT
    MIN(ekmp.Created) AS exp_date_1,
    MIN(vsb.date_1) AS date_1,
    MAX(vsb.date_2) AS date_2,
    COUNT(*) AS sluch_count,
    CAST(SUM(mek.SummaP) AS NUMERIC(15,2)) AS sluch_sum,
    SUM(IIF(ISNULL(ekmp.FinSank, 0) > 0 OR ISNULL(ekmp.Shtraf, 0) > 0, 1, 0)) AS sank_count,
    SUM(IIF(ISNULL(ekmp.FinSank, 0) > 0, 1, 0)) AS fin_sank_count,
    CAST(SUM(ISNULL(ekmp.FinSank, 0)) AS NUMERIC(15,2)) AS fin_sank_sum,
    SUM(IIF(ISNULL(ekmp.Shtraf, 0) > 0, 1, 0)) AS shtraf_count,
    CAST(SUM(ISNULL(ekmp.Shtraf, 0)) AS NUMERIC(15,2)) AS shtraf_sum,
    SUM(IIF(ekmp.KodPrichOtkazFD IS NOT NULL, 1, 0)) AS vyvod
  FROM schet.vw_ekmp ekmp
--  JOIN schet.vw_sluch_base vsb ON ekmp.idcase = vsb.idcase
  OUTER APPLY(SELECT * FROM schet.vw_sluch_base sb WHERE ekmp.idcase = sb.idcase) vsb
  OUTER APPLY (
    SELECT TOP 1 *
    FROM schet.vw_mek m
    WHERE ekmp.idcase = m.idcase AND ISNULL(m.Deleted, 0) = 0
    ORDER BY m.mek_id DESC
  ) mek
  WHERE va.idact = ekmp.idact AND ISNULL(ekmp.Deleted, 0) = 0
) ekmp_detail
OUTER APPLY (SELECT * FROM dict.vw_smo vs WHERE vs.Kod = config.KodSMO()) rs

WHERE va.UrovEksp = 2
GO