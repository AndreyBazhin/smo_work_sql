CREATE TABLE expert.request_pmd_send_mail (
  request_pmd_send_mail_id INT IDENTITY
 ,idschet INT NOT NULL
 ,idcase BIGINT NOT NULL
 ,send_date DATE NULL
) ON [PRIMARY]
GO