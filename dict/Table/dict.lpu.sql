CREATE TABLE smo_work.dict.lpu (
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