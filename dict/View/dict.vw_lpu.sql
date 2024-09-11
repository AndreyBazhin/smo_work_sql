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
LEFT JOIN dict.lpu l ON vl.lpu_id = l.lpu_id
GO