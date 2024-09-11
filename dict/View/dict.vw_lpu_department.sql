CREATE VIEW dict.vw_lpu_department
AS
  SELECT vld.*, ld.sms_name, ld.mail_name, ld.phone
  FROM schet.vw_lpu_department vld
  LEFT JOIN dict.lpu_department ld ON vld.RegKod = ld.RegKod