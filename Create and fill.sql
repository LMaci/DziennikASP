CREATE TABLE [DANE_OSOBOWE] (
	ID integer IDENTITY(1,1) NOT NULL,
	IMIE varchar(45),
	NAZWISKO varchar(50),
	PLEC char(1),
	AUTH_ID integer,
  CONSTRAINT [PK_DANE_OSOBOWE] PRIMARY KEY CLUSTERED
  (
  [ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF),
  CONSTRAINT chk_Plec CHECK (Plec IN ('M', 'F'))

)
GO
CREATE TABLE [STUDENT] (
	ID integer IDENTITY(1,1) NOT NULL,
	DANE_OSOBOWE_ID integer,
	GRUPA_ID integer,
	NUMER_ALBUMU varchar(15),
  CONSTRAINT [PK_STUDENT] PRIMARY KEY CLUSTERED
  (
  [ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [PRACOWNIK] (
	ID integer IDENTITY(1,1) NOT NULL,
	DANE_OSOBOWE_ID integer,
	SL_STANOWISKO_ID integer NOT NULL,
  CONSTRAINT [PK_PRACOWNIK] PRIMARY KEY CLUSTERED
  (
  [ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [GRUPA] (
	ID integer IDENTITY(1,1) NOT NULL,
	NAZWA varchar(20),
	KIERUNEK_ID integer,
  CONSTRAINT [PK_GRUPA] PRIMARY KEY CLUSTERED
  (
  [ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [PRZEDMIOT] (
	ID integer IDENTITY(1,1) NOT NULL,
	NAZWA varchar(35) NOT NULL,
	ALIAS varchar(10),
	PRACOWNIK_ID integer NOT NULL,
  CONSTRAINT [PK_PRZEDMIOT] PRIMARY KEY CLUSTERED
  (
  [ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

CREATE TABLE [STUDENT_PRZEDMIOT] (
	ID integer IDENTITY(1,1) NOT NULL,
	STUDENT_ID integer NOT NULL,
	PRZEDMIOT_ID integer NOT NULL,
	OCENA integer,
	OPIS varchar(200),
  CONSTRAINT [PK_STUDENT_PRZEDMIOT] PRIMARY KEY CLUSTERED
  (
  [ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF),
    CONSTRAINT chk_OCENA CHECK (OCENA IN (2, 2.5, 3, 3.5, 4, 4.5, 5))

)
GO
CREATE TABLE [PROJEKT] (
	ID integer IDENTITY(1,1) NOT NULL,
	TEMAT varchar(100),
	STUDENT_ID integer,
	PRACOWNIK_ID integer,
	PRZEDMIOT_ID integer,
	OCENA integer,
  CONSTRAINT [PK_PROJEKT] PRIMARY KEY CLUSTERED
  (
  [ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [SL_STANOWISKO] (
	ID integer IDENTITY(1,1) NOT NULL,
	NAZWA varchar(55),
  CONSTRAINT [PK_SL_STANOWISKO] PRIMARY KEY CLUSTERED
  (
  [ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

CREATE TABLE [AUTH] (
	ID integer IDENTITY(1,1) NOT NULL,
	LOGIN varchar(40) NOT NULL,
	HASLO varchar(40) NOT NULL,
	UPRAWNIENIA integer NOT NULL DEFAULT '1',
  CONSTRAINT [PK_AUTH] PRIMARY KEY CLUSTERED
  (
  [ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [KIERUNEK] (
	ID integer IDENTITY(1,1) NOT NULL,
	NAZWA varchar(40) NOT NULL,
  CONSTRAINT [PK_KIERUNEK] PRIMARY KEY CLUSTERED
  (
  [ID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
	
)
GO

ALTER TABLE [DANE_OSOBOWE] WITH CHECK ADD CONSTRAINT [DANE_OSOBOWE_fk0] FOREIGN KEY ([AUTH_ID]) REFERENCES [AUTH]([ID])
GO
ALTER TABLE [DANE_OSOBOWE] CHECK CONSTRAINT [DANE_OSOBOWE_fk0]
GO

ALTER TABLE [STUDENT] WITH CHECK ADD CONSTRAINT [STUDENT_fk0] FOREIGN KEY ([DANE_OSOBOWE_ID]) REFERENCES [DANE_OSOBOWE]([ID])
ON DELETE CASCADE
GO
ALTER TABLE [STUDENT] CHECK CONSTRAINT [STUDENT_fk0]
GO
ALTER TABLE [STUDENT] WITH CHECK ADD CONSTRAINT [STUDENT_fk1] FOREIGN KEY ([GRUPA_ID]) REFERENCES [GRUPA]([ID])
GO
ALTER TABLE [STUDENT] CHECK CONSTRAINT [STUDENT_fk1]
GO

ALTER TABLE [PRACOWNIK] WITH CHECK ADD CONSTRAINT [PRACOWNIK_fk0] FOREIGN KEY ([DANE_OSOBOWE_ID]) REFERENCES [DANE_OSOBOWE]([ID])
ON DELETE CASCADE
GO
ALTER TABLE [PRACOWNIK] CHECK CONSTRAINT [PRACOWNIK_fk0]
GO
ALTER TABLE [PRACOWNIK] WITH CHECK ADD CONSTRAINT [PRACOWNIK_fk1] FOREIGN KEY ([SL_STANOWISKO_ID]) REFERENCES [SL_STANOWISKO]([ID])
GO
ALTER TABLE [PRACOWNIK] CHECK CONSTRAINT [PRACOWNIK_fk1]
GO


ALTER TABLE [PRZEDMIOT] WITH CHECK ADD CONSTRAINT [PRZEDMIOT_fk0] FOREIGN KEY ([PRACOWNIK_ID]) REFERENCES [PRACOWNIK]([ID])
GO
ALTER TABLE [PRZEDMIOT] CHECK CONSTRAINT [PRZEDMIOT_fk0]
GO


ALTER TABLE [STUDENT_PRZEDMIOT] WITH CHECK ADD CONSTRAINT [STUDENT_PRZEDMIOT_fk0] FOREIGN KEY ([STUDENT_ID]) REFERENCES [STUDENT]([ID])
GO
ALTER TABLE [STUDENT_PRZEDMIOT] CHECK CONSTRAINT [STUDENT_PRZEDMIOT_fk0]
GO
ALTER TABLE [STUDENT_PRZEDMIOT] WITH CHECK ADD CONSTRAINT [STUDENT_PRZEDMIOT_fk1] FOREIGN KEY ([PRZEDMIOT_ID]) REFERENCES [PRZEDMIOT]([ID])
GO
ALTER TABLE [STUDENT_PRZEDMIOT] CHECK CONSTRAINT [STUDENT_PRZEDMIOT_fk1]
GO

ALTER TABLE [PROJEKT] WITH CHECK ADD CONSTRAINT [PROJEKT_fk0] FOREIGN KEY ([STUDENT_ID]) REFERENCES [STUDENT]([ID])
GO
ALTER TABLE [PROJEKT] CHECK CONSTRAINT [PROJEKT_fk0]
GO
ALTER TABLE [PROJEKT] WITH CHECK ADD CONSTRAINT [PROJEKT_fk1] FOREIGN KEY ([PRACOWNIK_ID]) REFERENCES [PRACOWNIK]([ID])
GO
ALTER TABLE [PROJEKT] CHECK CONSTRAINT [PROJEKT_fk1]
GO
ALTER TABLE [PROJEKT] WITH CHECK ADD CONSTRAINT [PROJEKT_fk2] FOREIGN KEY ([PRZEDMIOT_ID]) REFERENCES [PRZEDMIOT]([ID])
GO
ALTER TABLE [PROJEKT] CHECK CONSTRAINT [PROJEKT_fk2]
GO



ALTER TABLE [GRUPA] WITH CHECK ADD CONSTRAINT [GRUPA_fk0] FOREIGN KEY ([KIERUNEK_ID]) REFERENCES [KIERUNEK]([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [GRUPA] CHECK CONSTRAINT [GRUPA_fk0]
GO


INSERT INTO SL_STANOWISKO 
	VALUES ('Pracownik dziekanatu'),('Asystent'),('Wykładowca'),
			('Starszy wykładowca'),('Docent'),('Profesor');

INSERT INTO KIERUNEK
	VALUES ('Informatyka'),('Zarządzanie'),('Dziennikarstwo'),('Europeistyka'),('Bioinżynieria');
			

INSERT INTO GRUPA
	VALUES ('TIiM',1),('ASK',1),('Zarządzanie 1',2),('Zarządzanie 2',2),('Dziennikarstwo 1',3),('Dziennikarstwo 2',3),
			('Europeistyka 1',4),('Europeistyka 2',4),('Bioinż 1',5),('Bioinż 2',5);


			
			
insert into AUTH values ('Admin', '123', 3);
insert into AUTH values ('Aklimek', 'Klimeka', 1);
insert into AUTH values ('Jmarciniak', 'Marciniakj', 1);
insert into AUTH values ('11-336-7373', 'XqJt0P0', 1);
insert into AUTH values ('42-752-0251', 'GQZnbHc3p04', 1);
insert into AUTH values ('35-054-0861', 'h6WNlt', 1);
insert into AUTH values ('46-286-1434', 'VuuAQ9Y', 1);
insert into AUTH values ('62-405-6451', 'A6FUpucWP', 1);
insert into AUTH values ('37-274-8559', 'Hadp8Yd', 1);
insert into AUTH values ('96-210-8708', 'igcxQR', 1);
insert into AUTH values ('19-350-7842', '2alH9H1c3vOX', 1);
insert into AUTH values ('48-643-7216', 'Amah92Xfn', 1);
insert into AUTH values ('50-341-8715', '7SYdTo', 1);
insert into AUTH values ('00-913-4993', 'UnQibi', 1);
insert into AUTH values ('62-735-9309', 'YNAAMo09u', 1);
insert into AUTH values ('29-979-4518', '5XWPZtFDp', 1);
insert into AUTH values ('75-542-9175', 'FQ4ySn', 1);
insert into AUTH values ('12-962-2621', 'FofFPXv', 1);
insert into AUTH values ('75-317-4588', 'E1prcGal42Ib', 1);
insert into AUTH values ('18-081-8344', 'ykPsV6m', 1);
insert into AUTH values ('30-316-3323', 'oIfnAePQP', 1);
insert into AUTH values ('17-696-8612', 'MRiRG61FY8UJ', 1);
insert into AUTH values ('80-936-6884', 'Uw71ofmKhIgw', 1);
insert into AUTH values ('38-880-5898', 'o4q956s', 1);
insert into AUTH values ('73-719-4320', 'Az8kcHl', 1);
insert into AUTH values ('60-013-1266', '4AneZGZ56n', 1);
insert into AUTH values ('67-256-5068', 'y7NdR9canxl8', 1);
insert into AUTH values ('95-979-9888', 't4Is60yy', 1);
insert into AUTH values ('28-702-5788', 'IXyUGoCaH', 1);
insert into AUTH values ('26-496-9919', 'H7cfeyi', 1);
insert into AUTH values ('53-706-6449', 'f79OtiGdIOV', 1);
insert into AUTH values ('79-335-3655', 'pqpofq0tUiii', 1);
insert into AUTH values ('75-230-2339', '9tgw8WlYde', 1);
insert into AUTH values ('95-318-7673', '4KKhlNh3NVe', 1);
insert into AUTH values ('66-203-0619', 'dYTUHLsXHE4v', 1);
insert into AUTH values ('30-976-2521', 'STmM75l0q', 1);
insert into AUTH values ('08-577-4180', 'sHLxrKmmuik', 1);
insert into AUTH values ('25-265-0060', 'ergmWoCo0ge', 1);
insert into AUTH values ('88-045-7742', 'E1eszsS6uuGl', 1);
insert into AUTH values ('04-466-1614', 'ZweVAZ', 1);
insert into AUTH values ('20-736-9387', 'qYsAaqR', 1);
insert into AUTH values ('52-957-4642', 'Y7PnwPQ', 1);
insert into AUTH values ('54-068-0084', 'vcuRLl9koYs', 1);
insert into AUTH values ('15-375-4674', 'pR3WbRYZL', 1);
insert into AUTH values ('21-008-7119', 'xYTKoFD', 1);
insert into AUTH values ('41-285-7449', '0Xp8xi', 1);
insert into AUTH values ('47-727-9011', 'yMHmn091', 1);
insert into AUTH values ('12-181-6407', 'lncKr7Ed4', 1);
insert into AUTH values ('18-060-6002', '1zLFvR', 1);
insert into AUTH values ('36-865-2704', 'sgPORSiGC', 1);
insert into AUTH values ('01-539-7831', 'MdgJQ1n3b', 1);
insert into AUTH values ('96-703-9907', 'c8JlqM1po', 1);
insert into AUTH values ('58-784-5838', '9J6i8kfd4', 1);
insert into AUTH values ('42-302-2759', 'WwsG6a4Ze', 1);
insert into AUTH values ('39-816-6329', '0Rr7IxyNRt8z', 1);
insert into AUTH values ('13-048-7257', 'MK16Rgx', 1);
insert into AUTH values ('79-771-6972', 'bPsxHeZT4k5Y', 1);
insert into AUTH values ('49-886-3764', 'hTE9NWwT', 1);
insert into AUTH values ('61-827-0137', 'iMPQa0DTBFoh', 1);
insert into AUTH values ('31-924-5350', 'McLJwTtemIbg', 1);
insert into AUTH values ('39-333-1984', 'nIzlRaLt', 1);
insert into AUTH values ('38-517-5121', 'haDFFrgu', 1);
insert into AUTH values ('00-143-9543', 'w3A4CqzxtBa', 1);
insert into AUTH values ('07-863-5813', 'PMSfpxUY2rtz', 1);
insert into AUTH values ('83-471-1899', 'TaiHw0i', 1);
insert into AUTH values ('29-645-0909', '0Uhlpvzrw8X', 1);
insert into AUTH values ('82-332-2358', 'zhDO9m68U9D', 1);
insert into AUTH values ('29-205-4278', 'N2x2SuqaWw', 1);
insert into AUTH values ('50-855-6137', '3ag90C', 1);
insert into AUTH values ('69-307-2428', 'TovyqjRbV', 1);
insert into AUTH values ('70-691-1490', 'NVjwXf', 1);
insert into AUTH values ('60-387-6490', 'WWRojvHce', 1);
insert into AUTH values ('33-937-3247', 'sjIvU1c0', 1);
insert into AUTH values ('51-958-1286', 'JEUDw7W', 1);
insert into AUTH values ('00-546-4582', '7rGz5ld7brK6', 1);
insert into AUTH values ('41-219-8933', 'f9RjYrd', 1);
insert into AUTH values ('18-603-1765', 'p9LCBhRaYPB', 1);
insert into AUTH values ('47-736-9133', 'hkw1dWKm', 1);
insert into AUTH values ('92-145-5916', '8MrJSjS', 1);
insert into AUTH values ('66-780-6871', 'EaYQ4da6No', 1);
insert into AUTH values ('05-749-9556', 'GNLU0L', 1);
insert into AUTH values ('81-827-1174', 'ZPvi7f03p', 1);
insert into AUTH values ('34-625-9074', 'Md6UYou7wKw', 1);
insert into AUTH values ('02-071-4736', 'bXHdVCrIg', 1);
insert into AUTH values ('29-905-5297', 'YmCNc0aB9SY', 1);
insert into AUTH values ('17-610-7829', 'GCYwTe4j', 1);
insert into AUTH values ('02-635-3647', 'ePhrYUYw0lCw', 1);
insert into AUTH values ('41-508-9249', 'Y6bOZVBcr83p', 1);
insert into AUTH values ('19-770-4859', '6BPqpqLV', 1);
insert into AUTH values ('54-968-8437', '4lTfHfHwF', 1);
insert into AUTH values ('51-613-6784', 'yzrMQo', 1);
insert into AUTH values ('84-101-8716', 'fdYW9aUuHEZ', 1);
insert into AUTH values ('21-303-3461', 'jCR6N0IJX7A', 1);
insert into AUTH values ('87-103-3547', 'XXjGnyX1W83', 1);
insert into AUTH values ('88-246-8689', 'Mtcm5zM8rY', 1);
insert into AUTH values ('80-688-8622', 'DWYIrgw', 1);
insert into AUTH values ('75-063-9738', '5mlCDwYs2T', 1);
insert into AUTH values ('93-071-6848', 'MNfg8XlA0H4n', 1);
insert into AUTH values ('40-246-6753', 'VUoRWNlys75', 1);
insert into AUTH values ('16-169-9117', 'ye6qeS1e2BSR', 1);
insert into AUTH values ('83-747-0203', '3XsBkBg', 1);
insert into AUTH values ('71-677-0332', 'P5qz5q', 1);
insert into AUTH values ('34-690-8054', 'nx5CjUM28', 1);
insert into AUTH values ('23-527-2410', 'Qc5K0hHD', 1);
insert into AUTH values ('14-592-4580', '3WgkCQ', 1);
insert into AUTH values ('07-488-1848', 'hSPmjMU8', 1);
insert into AUTH values ('43-824-5567', 'NcjpXcOFVmY', 1);
insert into AUTH values ('73-342-1603', 'emJSov', 1);
insert into AUTH values ('16-782-6774', '2lHucrzQZ', 1);
insert into AUTH values ('34-459-5672', 'yU0jcvmdceI', 1);
insert into AUTH values ('40-486-9376', 'SVPgXEf', 1);
insert into AUTH values ('24-241-9208', 'KHbNIJvM7', 1);
insert into AUTH values ('07-397-9759', '3sYIwgpwqv6B', 1);
insert into AUTH values ('40-917-7833', 'K8M9ox9hoS', 1);
insert into AUTH values ('75-101-2961', 'QWxjmwLDSw', 1);
insert into AUTH values ('36-794-1177', '3l8OT4o6e', 1);
insert into AUTH values ('10-151-7598', 'Beb0hQ74TudM', 1);
insert into AUTH values ('63-892-1462', 'vRO5Frb', 1);
insert into AUTH values ('53-219-6060', '2EHkWaW9nd', 1);
insert into AUTH values ('13-806-5672', '0oJIcn6bkra', 1);
insert into AUTH values ('81-746-0182', 'XnWO3VbVHy', 1);
insert into AUTH values ('63-446-2481', 'x8j8WHm', 1);
insert into AUTH values ('71-218-4878', 'j89u1Czky1E', 1);
insert into AUTH values ('29-294-8420', '0DbbQwE4', 1);
insert into AUTH values ('04-597-8975', 'WCltsujYYc', 1);
insert into AUTH values ('45-276-6592', 'Vrs4768', 1);
insert into AUTH values ('73-771-2721', 'SKTWt7l22t', 1);
insert into AUTH values ('23-754-3515', 'CSma9bMC', 1);
insert into AUTH values ('39-470-5705', 'q3gjly6Y', 1);
insert into AUTH values ('44-149-3580', '9gfrzX01BZ', 1);
insert into AUTH values ('45-381-1218', 'x292RFIzi', 1);
insert into AUTH values ('87-989-4034', 'MeSKH9T3Fm', 1);
insert into AUTH values ('50-633-1797', 'u2Lh8DuY4c', 1);
insert into AUTH values ('36-925-6602', 'RQ3IeFr5jC', 1);
insert into AUTH values ('90-961-2019', 'FaNcIpkoR', 1);
insert into AUTH values ('98-177-4093', 'kuxq2LgGKYvE', 1);
insert into AUTH values ('67-078-9738', 'cmwlk0', 1);
insert into AUTH values ('23-968-7883', '1je0FMCmh', 1);
insert into AUTH values ('60-957-7584', 'Ufieto9r', 1);
insert into AUTH values ('47-821-3756', 'kg0TpZX', 1);
insert into AUTH values ('01-644-4352', 'qgTtjowk1O', 1);
insert into AUTH values ('00-396-5490', 'l4SrPrNI4A', 1);
insert into AUTH values ('96-276-7162', 'n3sF9tTkn', 1);
insert into AUTH values ('61-338-9386', 'zJinEnXhrFTZ', 1);
insert into AUTH values ('20-280-0088', 'IXY7jdPVWjxK', 1);
insert into AUTH values ('31-147-8535', '3eTaP2FIfAZK', 1);
insert into AUTH values ('08-143-4284', 'QlXkjHKNnyPV', 1);
insert into AUTH values ('75-693-9996', 'lGbilh', 1);
insert into AUTH values ('87-122-1399', 'BOEuvrIFL', 1);
insert into AUTH values ('64-490-3825', 'fjE17Av', 1);
insert into AUTH values ('97-577-5716', 'zzEkOLXFe3Rb', 1);
insert into AUTH values ('77-617-5399', 'JquRjT', 1);
insert into AUTH values ('61-897-6922', 'rvVLLeLiVhl', 1);
insert into AUTH values ('10-784-5429', 'tlI3i60mf', 1);
insert into AUTH values ('64-964-4857', 't43Ed3OyP', 1);
insert into AUTH values ('18-601-8531', 'lGgvynaCF', 1);
insert into AUTH values ('86-259-7486', 'O2IVVpOd', 1);
insert into AUTH values ('78-251-1863', 'W98WRi8C', 1);
insert into AUTH values ('11-448-5438', 'hGYPSW3G', 1);
insert into AUTH values ('59-235-8417', 'lGHFyTxLv', 1);
insert into AUTH values ('67-747-4775', 'IwoZhLIg4S', 1);
insert into AUTH values ('49-861-5469', 'fDwXKjMgwXr', 1);
insert into AUTH values ('23-871-3100', 'GfxrqnKna', 1);
insert into AUTH values ('14-715-8249', 'x5jekJaufmSz', 1);
insert into AUTH values ('79-892-7108', 'yzhx9yRQeU7', 1);
insert into AUTH values ('64-718-5530', '7iWLf07RPCRU', 1);
insert into AUTH values ('24-697-9669', 'nxSMCmfIV', 1);
insert into AUTH values ('46-012-8325', 'o1ZI6zlPrUn', 1);
insert into AUTH values ('87-969-7501', '4Il8zZr0a', 1);
insert into AUTH values ('10-067-8391', 'hye2WB', 1);
insert into AUTH values ('01-028-1743', '5P06GgvJ8', 1);
insert into AUTH values ('54-413-5356', 'jAnjt8IhAWZm', 1);
insert into AUTH values ('14-361-3328', 'B1JXU9B', 1);
insert into AUTH values ('71-711-5522', 't0pXCBg', 1);
insert into AUTH values ('22-754-4830', 'WwEebkGcB', 1);
insert into AUTH values ('51-670-3197', 'u8Lxguu6e0GZ', 1);
insert into AUTH values ('68-449-8622', 'hjCX7MEJCnm', 1);
insert into AUTH values ('74-245-4508', 'JbcCDWDI27nS', 1);
insert into AUTH values ('97-697-3980', 'SzCNXC3m9aF', 1);
insert into AUTH values ('19-686-8192', '1qoUIBZQO', 1);
insert into AUTH values ('03-756-4318', 'FoNbmq9ZOyVx', 1);
insert into AUTH values ('96-883-6762', '7TAUgmDEgGJ', 1);
insert into AUTH values ('92-436-2245', 'KIVPSqa', 1);
insert into AUTH values ('76-397-4283', 'puztvOzYcvZ', 1);
insert into AUTH values ('62-803-4819', 'tMcx6lKwQmmz', 1);
insert into AUTH values ('21-954-6373', 'WiPfRXefcZzW', 1);
insert into AUTH values ('51-684-1236', 'h00ePEgiL', 1);
insert into AUTH values ('57-690-6994', '9RdhpujPVZW', 1);
insert into AUTH values ('24-434-2123', 'dBcFXNQmS', 1);
insert into AUTH values ('77-880-5739', 'q3bWzx', 1);
insert into AUTH values ('21-404-0580', 'PDv3oj', 1);
insert into AUTH values ('71-559-0928', 'qfR9CYRqsmi0', 1);
insert into AUTH values ('58-392-2639', 'YbNqO0t46Sm', 1);
insert into AUTH values ('10-244-3677', 'xN88un', 1);
insert into AUTH values ('44-980-8644', 'VL4eDxv4E', 1);
insert into AUTH values ('14-840-5712', 'VEpIFDIovIy', 1);
insert into AUTH values ('67-307-9439', '8LSNWsg3IMA', 1);
insert into AUTH values ('56-451-0389', 'cZ7YRkSP', 1);
insert into AUTH values ('05-733-1959', 'sYMNojd', 1);
insert into AUTH values ('84-844-6611', 'tHL8OkeAk1', 1);

insert into AUTH values ('w1', '1', 2);
insert into AUTH values ('w2', '2', 2);
insert into AUTH values ('w3', '3', 2);
insert into AUTH values ('w4', '4', 2);
insert into AUTH values ('w5', '5', 2);
insert into AUTH values ('w6', '6', 2);
insert into AUTH values ('w7', '7', 2);
insert into AUTH values ('w8', '8', 2);
insert into AUTH values ('w9', '9', 2);
insert into AUTH values ('w10', '10', 2);
insert into AUTH values ('w11', '11', 2);
insert into AUTH values ('w12', '12', 2);
insert into AUTH values ('w13', '13', 2);
insert into AUTH values ('w14', '14', 2);
insert into AUTH values ('w15', '15', 2);
insert into AUTH values ('p1', '1', 3);
insert into AUTH values ('p2', '2', 3);
insert into AUTH values ('p3', '3', 3);
insert into AUTH values ('p4', '4', 3);
insert into AUTH values ('p5', '5', 3);




insert into DANE_OSOBOWE values ('Łukasz','Maciejczyk','M',1);
INSERT INTO DANE_OSOBOWE VALUES ('Agata','Klimek','F',2);
INSERT INTO DANE_OSOBOWE VALUES ('Jan','Marciniak','M',3);
insert into DANE_OSOBOWE values ('Grange', 'Wardhaugh', 'M', 4);
insert into DANE_OSOBOWE values ('Kahaleel', 'Conibear', 'M', 5);
insert into DANE_OSOBOWE values ('Stu', 'Robb', 'M', 6);
insert into DANE_OSOBOWE values ('Thaddeus', 'Riediger', 'M', 7);
insert into DANE_OSOBOWE values ('Urbano', 'Crissil', 'M', 8);
insert into DANE_OSOBOWE values ('Stan', 'Sives', 'M', 9);
insert into DANE_OSOBOWE values ('Tobiah', 'Lago', 'M', 10);
insert into DANE_OSOBOWE values ('Brooke', 'Munsey', 'M', 11);
insert into DANE_OSOBOWE values ('Reynold', 'Lawee', 'M', 12);
insert into DANE_OSOBOWE values ('Myrwyn', 'Renoden', 'M', 13);
insert into DANE_OSOBOWE values ('Flynn', 'Deeson', 'M', 14);
insert into DANE_OSOBOWE values ('Sheridan', 'McCauley', 'M', 15);
insert into DANE_OSOBOWE values ('Ber', 'Sibborn', 'M', 16);
insert into DANE_OSOBOWE values ('Freemon', 'Hetterich', 'M', 17);
insert into DANE_OSOBOWE values ('Brade', 'Keysel', 'M', 18);
insert into DANE_OSOBOWE values ('Carlie', 'Fridaye', 'M', 19);
insert into DANE_OSOBOWE values ('Lannie', 'Hamon', 'M', 20);
insert into DANE_OSOBOWE values ('Lauren', 'Cosin', 'M', 21);
insert into DANE_OSOBOWE values ('Hoebart', 'Jordison', 'M', 22);
insert into DANE_OSOBOWE values ('Tallie', 'Blasi', 'M', 23);
insert into DANE_OSOBOWE values ('Beau', 'Reddell', 'M', 24);
insert into DANE_OSOBOWE values ('Derrik', 'Dennett', 'M', 25);
insert into DANE_OSOBOWE values ('Joseito', 'Nel', 'M', 26);
insert into DANE_OSOBOWE values ('Dominic', 'Cantrill', 'M', 27);
insert into DANE_OSOBOWE values ('Iosep', 'Duplock', 'M', 28);
insert into DANE_OSOBOWE values ('Puff', 'Schurig', 'M', 29);
insert into DANE_OSOBOWE values ('Trey', 'Jarman', 'M', 30);
insert into DANE_OSOBOWE values ('Kristian', 'Morican', 'M', 31);
insert into DANE_OSOBOWE values ('Oswell', 'McCawley', 'M', 32);
insert into DANE_OSOBOWE values ('Jerome', 'Lomasny', 'M', 33);
insert into DANE_OSOBOWE values ('Albert', 'Bushel', 'M', 34);
insert into DANE_OSOBOWE values ('Barbabas', 'Bonass', 'M', 35);
insert into DANE_OSOBOWE values ('Ezra', 'Scrivin', 'M', 36);
insert into DANE_OSOBOWE values ('Sigfried', 'Idiens', 'M', 37);
insert into DANE_OSOBOWE values ('Skipper', 'Charopen', 'M', 38);
insert into DANE_OSOBOWE values ('Delmor', 'Waldron', 'M', 39);
insert into DANE_OSOBOWE values ('Ignatius', 'Rodda', 'M', 40);
insert into DANE_OSOBOWE values ('Finlay', 'Wickliffe', 'M', 41);
insert into DANE_OSOBOWE values ('Austin', 'Berrill', 'M', 42);
insert into DANE_OSOBOWE values ('Montague', 'Deboick', 'M', 43);
insert into DANE_OSOBOWE values ('Jessee', 'Yeudall', 'M', 44);
insert into DANE_OSOBOWE values ('Doug', 'McGettrick', 'M', 45);
insert into DANE_OSOBOWE values ('Shay', 'Lehr', 'M', 46);
insert into DANE_OSOBOWE values ('Boote', 'Caile', 'M', 47);
insert into DANE_OSOBOWE values ('Finley', 'Gillio', 'M', 48);
insert into DANE_OSOBOWE values ('Haven', 'Stainland', 'M', 49);
insert into DANE_OSOBOWE values ('Rudolph', 'Seiffert', 'M', 50);
insert into DANE_OSOBOWE values ('Killian', 'Latter', 'M', 51);
insert into DANE_OSOBOWE values ('Charles', 'Curee', 'M', 52);
insert into DANE_OSOBOWE values ('Zelig', 'Spinola', 'M', 53);
insert into DANE_OSOBOWE values ('Donn', 'Yglesias', 'M', 54);
insert into DANE_OSOBOWE values ('Desmond', 'Greber', 'M', 55);
insert into DANE_OSOBOWE values ('Siegfried', 'Senechell', 'M', 56);
insert into DANE_OSOBOWE values ('Ara', 'Nuzzti', 'M', 57);
insert into DANE_OSOBOWE values ('Baird', 'Hendrich', 'M', 58);
insert into DANE_OSOBOWE values ('Tobin', 'Maylott', 'M', 59);
insert into DANE_OSOBOWE values ('Thurstan', 'Hewes', 'M', 60);
insert into DANE_OSOBOWE values ('Micah', 'Knoller', 'M', 61);
insert into DANE_OSOBOWE values ('Carroll', 'Salla', 'M', 62);
insert into DANE_OSOBOWE values ('Javier', 'Yell', 'M', 63);
insert into DANE_OSOBOWE values ('Don', 'Szach', 'M', 64);
insert into DANE_OSOBOWE values ('Scott', 'Brownfield', 'M', 65);
insert into DANE_OSOBOWE values ('Collin', 'Telford', 'M', 66);
insert into DANE_OSOBOWE values ('Ambrosio', 'Hartshorn', 'M', 67);
insert into DANE_OSOBOWE values ('Ricky', 'McGeffen', 'M', 68);
insert into DANE_OSOBOWE values ('Jimmie', 'Wells', 'M', 69);
insert into DANE_OSOBOWE values ('Berky', 'Plait', 'M', 70);
insert into DANE_OSOBOWE values ('Fabiano', 'Munro', 'M', 71);
insert into DANE_OSOBOWE values ('Hube', 'Casetti', 'M', 72);
insert into DANE_OSOBOWE values ('Wendell', 'Genge', 'M', 73);
insert into DANE_OSOBOWE values ('Germain', 'Mulbry', 'M', 74);
insert into DANE_OSOBOWE values ('Nickolas', 'Bulstrode', 'M', 75);
insert into DANE_OSOBOWE values ('Sim', 'Castleman', 'M', 76);
insert into DANE_OSOBOWE values ('Gage', 'Varne', 'M', 77);
insert into DANE_OSOBOWE values ('Dag', 'Charlot', 'M', 78);
insert into DANE_OSOBOWE values ('Heywood', 'Wilcock', 'M', 79);
insert into DANE_OSOBOWE values ('Hamid', 'Taylerson', 'M', 80);
insert into DANE_OSOBOWE values ('Alford', 'Rojas', 'M', 81);
insert into DANE_OSOBOWE values ('Wayland', 'Dyte', 'M', 82);
insert into DANE_OSOBOWE values ('Gonzales', 'Knight', 'M', 83);
insert into DANE_OSOBOWE values ('Levi', 'Tumulty', 'M', 84);
insert into DANE_OSOBOWE values ('Paddie', 'Tizzard', 'M', 85);
insert into DANE_OSOBOWE values ('Dick', 'Espley', 'M', 86);
insert into DANE_OSOBOWE values ('Neal', 'Kingett', 'M', 87);
insert into DANE_OSOBOWE values ('Efren', 'Rivalland', 'M', 88);
insert into DANE_OSOBOWE values ('Llywellyn', 'Augur', 'M', 89);
insert into DANE_OSOBOWE values ('Andros', 'Pappin', 'M', 90);
insert into DANE_OSOBOWE values ('Renault', 'Kirckman', 'M', 91);
insert into DANE_OSOBOWE values ('Malvin', 'Paolazzi', 'M', 92);
insert into DANE_OSOBOWE values ('Hewitt', 'Roll', 'M', 93);
insert into DANE_OSOBOWE values ('Crawford', 'Code', 'M', 94);
insert into DANE_OSOBOWE values ('Benedikt', 'Beacom', 'M', 95);
insert into DANE_OSOBOWE values ('Forbes', 'Handasyde', 'M', 96);
insert into DANE_OSOBOWE values ('Buckie', 'MacMenamin', 'M', 97);
insert into DANE_OSOBOWE values ('Worden', 'Hartnell', 'M', 98);
insert into DANE_OSOBOWE values ('Leighton', 'MacKenny', 'M', 99);
insert into DANE_OSOBOWE values ('Brock', 'Tesh', 'M', 100);
insert into DANE_OSOBOWE values ('Arron', 'Coling', 'M', 101);
insert into DANE_OSOBOWE values ('Temp', 'Girth', 'M', 102);
insert into DANE_OSOBOWE values ('Kale', 'Cord', 'M', 103);
insert into DANE_OSOBOWE values ('Almira', 'Oakenfull', 'F', 104);
insert into DANE_OSOBOWE values ('Jemima', 'Zorzin', 'F', 105);
insert into DANE_OSOBOWE values ('Emma', 'Fowler', 'F', 106);
insert into DANE_OSOBOWE values ('Mirelle', 'Bowlands', 'F', 107);
insert into DANE_OSOBOWE values ('Sally', 'Dutt', 'F', 108);
insert into DANE_OSOBOWE values ('Ayn', 'Gudger', 'F', 109);
insert into DANE_OSOBOWE values ('Joanie', 'Kleinmann', 'F', 110);
insert into DANE_OSOBOWE values ('Lena', 'Lewton', 'F', 111);
insert into DANE_OSOBOWE values ('Audie', 'Gayforth', 'F', 112);
insert into DANE_OSOBOWE values ('Benetta', 'Ridsdell', 'F', 113);
insert into DANE_OSOBOWE values ('Blanch', 'Littlewood', 'F', 114);
insert into DANE_OSOBOWE values ('Emelita', 'Gallyhaock', 'F', 115);
insert into DANE_OSOBOWE values ('Tamarra', 'Radcliffe', 'F', 116);
insert into DANE_OSOBOWE values ('Keri', 'Hryskiewicz', 'F', 117);
insert into DANE_OSOBOWE values ('Margaux', 'Dufaur', 'F', 118);
insert into DANE_OSOBOWE values ('Meagan', 'Cumpton', 'F', 119);
insert into DANE_OSOBOWE values ('Casey', 'Dunklee', 'F', 120);
insert into DANE_OSOBOWE values ('Lia', 'Behr', 'F', 121);
insert into DANE_OSOBOWE values ('Noelani', 'Feaver', 'F', 122);
insert into DANE_OSOBOWE values ('Millicent', 'Cayton', 'F', 123);
insert into DANE_OSOBOWE values ('Feodora', 'Brunsden', 'F', 124);
insert into DANE_OSOBOWE values ('Nataline', 'O''Dunneen', 'F', 125);
insert into DANE_OSOBOWE values ('Katy', 'Ringham', 'F', 126);
insert into DANE_OSOBOWE values ('Nance', 'Cassella', 'F', 127);
insert into DANE_OSOBOWE values ('Cass', 'Adamthwaite', 'F', 128);
insert into DANE_OSOBOWE values ('Tuesday', 'Tudor', 'F', 129);
insert into DANE_OSOBOWE values ('Ynez', 'Silby', 'F', 130);
insert into DANE_OSOBOWE values ('Nyssa', 'Grindall', 'F', 131);
insert into DANE_OSOBOWE values ('Amye', 'Warr', 'F', 132);
insert into DANE_OSOBOWE values ('Malory', 'Spencers', 'F', 133);
insert into DANE_OSOBOWE values ('Aigneis', 'Musgrove', 'F', 134);
insert into DANE_OSOBOWE values ('Gabriell', 'Rotter', 'F', 135);
insert into DANE_OSOBOWE values ('Theadora', 'Foro', 'F', 136);
insert into DANE_OSOBOWE values ('Flori', 'Damper', 'F', 137);
insert into DANE_OSOBOWE values ('Lari', 'Lahive', 'F', 138);
insert into DANE_OSOBOWE values ('Giovanna', 'Girone', 'F', 139);
insert into DANE_OSOBOWE values ('Aeriell', 'Phillp', 'F', 140);
insert into DANE_OSOBOWE values ('Xylia', 'Shoosmith', 'F', 141);
insert into DANE_OSOBOWE values ('Janeen', 'Ivashkin', 'F', 142);
insert into DANE_OSOBOWE values ('Karyn', 'Cuberley', 'F', 143);
insert into DANE_OSOBOWE values ('Tricia', 'Suart', 'F', 144);
insert into DANE_OSOBOWE values ('Jo-ann', 'Al Hirsi', 'F', 145);
insert into DANE_OSOBOWE values ('Miranda', 'Leake', 'F', 146);
insert into DANE_OSOBOWE values ('Sissie', 'Gerty', 'F', 147);
insert into DANE_OSOBOWE values ('Winna', 'Haysman', 'F', 148);
insert into DANE_OSOBOWE values ('Corissa', 'Catterick', 'F', 149);
insert into DANE_OSOBOWE values ('Ronna', 'Hailston', 'F', 150);
insert into DANE_OSOBOWE values ('Bathsheba', 'Grady', 'F', 151);
insert into DANE_OSOBOWE values ('Elianore', 'Abel', 'F', 152);
insert into DANE_OSOBOWE values ('Calley', 'Dehm', 'F', 153);
insert into DANE_OSOBOWE values ('Guenevere', 'Bispham', 'F', 154);
insert into DANE_OSOBOWE values ('Prudence', 'Haggerwood', 'F', 155);
insert into DANE_OSOBOWE values ('Melamie', 'Cultcheth', 'F', 156);
insert into DANE_OSOBOWE values ('Alameda', 'Sink', 'F', 157);
insert into DANE_OSOBOWE values ('Mabel', 'Dreini', 'F', 158);
insert into DANE_OSOBOWE values ('Deidre', 'Blueman', 'F', 159);
insert into DANE_OSOBOWE values ('Gertie', 'Parfitt', 'F', 160);
insert into DANE_OSOBOWE values ('Monah', 'Kesterton', 'F', 161);
insert into DANE_OSOBOWE values ('Donica', 'Hinchshaw', 'F', 162);
insert into DANE_OSOBOWE values ('Kathie', 'Haighton', 'F', 163);
insert into DANE_OSOBOWE values ('Claretta', 'Lindemann', 'F', 164);
insert into DANE_OSOBOWE values ('Nikkie', 'Polk', 'F', 165);
insert into DANE_OSOBOWE values ('Jordana', 'Kencott', 'F', 166);
insert into DANE_OSOBOWE values ('Loni', 'Jeannet', 'F', 167);
insert into DANE_OSOBOWE values ('Vitoria', 'Kilshaw', 'F', 168);
insert into DANE_OSOBOWE values ('Alie', 'Schwand', 'F', 169);
insert into DANE_OSOBOWE values ('Keslie', 'Easeman', 'F', 170);
insert into DANE_OSOBOWE values ('Ceciley', 'Gater', 'F', 171);
insert into DANE_OSOBOWE values ('Collen', 'O''Hara', 'F', 172);
insert into DANE_OSOBOWE values ('Tani', 'Stringman', 'F', 173);
insert into DANE_OSOBOWE values ('Gertruda', 'Runnett', 'F', 174);
insert into DANE_OSOBOWE values ('Deeanne', 'Feige', 'F', 175);
insert into DANE_OSOBOWE values ('Alleen', 'Barabich', 'F', 176);
insert into DANE_OSOBOWE values ('Albina', 'MacTerrelly', 'F', 177);
insert into DANE_OSOBOWE values ('Ronica', 'Copas', 'F', 178);
insert into DANE_OSOBOWE values ('Emilee', 'Perks', 'F', 179);
insert into DANE_OSOBOWE values ('Irene', 'Toward', 'F', 180);
insert into DANE_OSOBOWE values ('Danyette', 'Bleackley', 'F', 181);
insert into DANE_OSOBOWE values ('Manya', 'Lugden', 'F', 182);
insert into DANE_OSOBOWE values ('Candide', 'Slessor', 'F', 183);
insert into DANE_OSOBOWE values ('Marlena', 'Oxford', 'F', 184);
insert into DANE_OSOBOWE values ('Charline', 'Ashborne', 'F', 185);
insert into DANE_OSOBOWE values ('Missie', 'Habin', 'F', 186);
insert into DANE_OSOBOWE values ('Gui', 'Petrelli', 'F', 187);
insert into DANE_OSOBOWE values ('Selina', 'Swinfen', 'F', 188);
insert into DANE_OSOBOWE values ('Binnie', 'Quillinane', 'F', 189);
insert into DANE_OSOBOWE values ('Gwendolyn', 'Riccardelli', 'F', 190);
insert into DANE_OSOBOWE values ('Evy', 'McCallam', 'F', 191);
insert into DANE_OSOBOWE values ('Della', 'Proven', 'F', 192);
insert into DANE_OSOBOWE values ('Jade', 'Sandison', 'F', 193);
insert into DANE_OSOBOWE values ('Lil', 'Willbond', 'F', 194);
insert into DANE_OSOBOWE values ('Melamie', 'Huett', 'F', 195);
insert into DANE_OSOBOWE values ('Sybilla', 'Keiley', 'F', 196);
insert into DANE_OSOBOWE values ('Clerissa', 'Knowling', 'F', 197);
insert into DANE_OSOBOWE values ('Fern', 'Andrejs', 'F', 198);
insert into DANE_OSOBOWE values ('Muffin', 'Brewitt', 'F', 199);
insert into DANE_OSOBOWE values ('Jillayne', 'Bromell', 'F', 200);




insert into DANE_OSOBOWE values ('Lindsay', 'Aspital', 'F', 201);
insert into DANE_OSOBOWE values ('Keen', 'Cuschieri', 'M', 202);
insert into DANE_OSOBOWE values ('Margarethe', 'Szymczyk', 'F', 203);
insert into DANE_OSOBOWE values ('Lucinda', 'Baythorp', 'F', 204);
insert into DANE_OSOBOWE values ('Harrietta', 'Wyndham', 'F', 205);
insert into DANE_OSOBOWE values ('Gaye', 'Dymond', 'M', 206);
insert into DANE_OSOBOWE values ('Carmelle', 'Bovingdon', 'F', 207);
insert into DANE_OSOBOWE values ('Bartie', 'Cardwell', 'F', 208);
insert into DANE_OSOBOWE values ('Antonia', 'Farbrother', 'F', 209);
insert into DANE_OSOBOWE values ('Sileas', 'Wallett', 'M', 210);
insert into DANE_OSOBOWE values ('Melly', 'Rye', 'F', 211);
insert into DANE_OSOBOWE values ('Dasie', 'Mainds', 'F', 212);
insert into DANE_OSOBOWE values ('Jori', 'Bradnum', 'M', 213);
insert into DANE_OSOBOWE values ('Ferguson', 'Halladey', 'M', 214);
insert into DANE_OSOBOWE values ('Vito', 'Roland', 'M', 215);
insert into DANE_OSOBOWE values ('Genvieve', 'Ashelford', 'F', 216);
insert into DANE_OSOBOWE values ('Stewart', 'Wykes', 'M', 217);
insert into DANE_OSOBOWE values ('Morna', 'Ropp', 'F', 218);
insert into DANE_OSOBOWE values ('Benjamin', 'Schlagtmans', 'M', 219);
insert into DANE_OSOBOWE values ('Rodolfo', 'Osgodby', 'M', 220);




insert into STUDENT values (1,1,'U-1010001');
insert into STUDENT values (2,1,'U-1010002');
insert into STUDENT values (3,1,'U-1010003');
insert into STUDENT values (4,1,'U-1010004');
insert into STUDENT values (5,1,'U-1010005');
insert into STUDENT values (6,1,'U-1010006');
insert into STUDENT values (7,1,'U-1010007');
insert into STUDENT values (8,1,'U-1010008');
insert into STUDENT values (9,1,'U-1010009');
insert into STUDENT values (10,1,'U-1010010');
insert into STUDENT values (11,1,'U-1010011');
insert into STUDENT values (12,1,'U-1010012');
insert into STUDENT values (13,1,'U-1010013');
insert into STUDENT values (14,1,'U-1010014');
insert into STUDENT values (15,1,'U-1010015');
insert into STUDENT values (16,1,'U-1010016');
insert into STUDENT values (17,1,'U-1010017');
insert into STUDENT values (18,1,'U-1010018');
insert into STUDENT values (19,1,'U-1010019');
insert into STUDENT values (20,1,'U-1010020');
insert into STUDENT values (21,1,'U-1020021');
insert into STUDENT values (22,1,'U-1020022');
insert into STUDENT values (23,1,'U-1020023');
insert into STUDENT values (24,1,'U-1020024');
insert into STUDENT values (25,1,'U-1020025');
insert into STUDENT values (26,1,'U-1020026');
insert into STUDENT values (27,1,'U-1020027');
insert into STUDENT values (28,1,'U-1020028');
insert into STUDENT values (29,1,'U-1020029');
insert into STUDENT values (30,1,'U-1020030');
insert into STUDENT values (31,1,'U-1020031');
insert into STUDENT values (32,1,'U-1020032');
insert into STUDENT values (33,1,'U-1020033');
insert into STUDENT values (34,1,'U-1020034');
insert into STUDENT values (35,1,'U-1020035');
insert into STUDENT values (36,1,'U-1020036');
insert into STUDENT values (37,1,'U-1020037');
insert into STUDENT values (38,1,'U-1020038');
insert into STUDENT values (39,1,'U-1020039');
insert into STUDENT values (40,1,'U-1020040');
insert into STUDENT values (41,2,'U-2030041');
insert into STUDENT values (42,2,'U-2030042');
insert into STUDENT values (43,2,'U-2030043');
insert into STUDENT values (44,2,'U-2030044');
insert into STUDENT values (45,2,'U-2030045');
insert into STUDENT values (46,2,'U-2030046');
insert into STUDENT values (47,2,'U-2030047');
insert into STUDENT values (48,2,'U-2030048');
insert into STUDENT values (49,2,'U-2030049');
insert into STUDENT values (50,2,'U-2030050');
insert into STUDENT values (51,2,'U-2030051');
insert into STUDENT values (52,2,'U-2030052');
insert into STUDENT values (53,2,'U-2030053');
insert into STUDENT values (54,2,'U-2030054');
insert into STUDENT values (55,2,'U-2030055');
insert into STUDENT values (56,2,'U-2030056');
insert into STUDENT values (57,2,'U-2030057');
insert into STUDENT values (58,2,'U-2030058');
insert into STUDENT values (59,2,'U-2030059');
insert into STUDENT values (60,2,'U-2030060');
insert into STUDENT values (61,2,'U-2040061');
insert into STUDENT values (62,2,'U-2040062');
insert into STUDENT values (63,2,'U-2040063');
insert into STUDENT values (64,2,'U-2040064');
insert into STUDENT values (65,2,'U-2040065');
insert into STUDENT values (66,2,'U-2040066');
insert into STUDENT values (67,2,'U-2040067');
insert into STUDENT values (68,2,'U-2040068');
insert into STUDENT values (69,2,'U-2040069');
insert into STUDENT values (70,2,'U-2040070');
insert into STUDENT values (71,2,'U-2040071');
insert into STUDENT values (72,2,'U-2040072');
insert into STUDENT values (73,2,'U-2040073');
insert into STUDENT values (74,2,'U-2040074');
insert into STUDENT values (75,2,'U-2040075');
insert into STUDENT values (76,2,'U-2040076');
insert into STUDENT values (77,2,'U-2040077');
insert into STUDENT values (78,2,'U-2040078');
insert into STUDENT values (79,2,'U-2040079');
insert into STUDENT values (80,2,'U-2040080');
insert into STUDENT values (81,3,'U-3050081');
insert into STUDENT values (82,3,'U-3050082');
insert into STUDENT values (83,3,'U-3050083');
insert into STUDENT values (84,3,'U-3050084');
insert into STUDENT values (85,3,'U-3050085');
insert into STUDENT values (86,3,'U-3050086');
insert into STUDENT values (87,3,'U-3050087');
insert into STUDENT values (88,3,'U-3050088');
insert into STUDENT values (89,3,'U-3050089');
insert into STUDENT values (90,3,'U-3050090');
insert into STUDENT values (91,3,'U-3050091');
insert into STUDENT values (92,3,'U-3050092');
insert into STUDENT values (93,3,'U-3050093');
insert into STUDENT values (94,3,'U-3050094');
insert into STUDENT values (95,3,'U-3050095');
insert into STUDENT values (96,3,'U-3050096');
insert into STUDENT values (97,3,'U-3050097');
insert into STUDENT values (98,3,'U-3050098');
insert into STUDENT values (99,3,'U-3050099');
insert into STUDENT values (100,3,'U-3050100');
insert into STUDENT values (101,3,'U-3060101');
insert into STUDENT values (102,3,'U-3060102');
insert into STUDENT values (103,3,'U-3060103');
insert into STUDENT values (104,3,'U-3060104');
insert into STUDENT values (105,3,'U-3060105');
insert into STUDENT values (106,3,'U-3060106');
insert into STUDENT values (107,3,'U-3060107');
insert into STUDENT values (108,3,'U-3060108');
insert into STUDENT values (109,3,'U-3060109');
insert into STUDENT values (110,3,'U-3060110');
insert into STUDENT values (111,3,'U-3060111');
insert into STUDENT values (112,3,'U-3060112');
insert into STUDENT values (113,3,'U-3060113');
insert into STUDENT values (114,3,'U-3060114');
insert into STUDENT values (115,3,'U-3060115');
insert into STUDENT values (116,3,'U-3060116');
insert into STUDENT values (117,3,'U-3060117');
insert into STUDENT values (118,3,'U-3060118');
insert into STUDENT values (119,3,'U-3060119');
insert into STUDENT values (120,3,'U-3060120');
insert into STUDENT values (121,4,'U-4070121');
insert into STUDENT values (122,4,'U-4070122');
insert into STUDENT values (123,4,'U-4070123');
insert into STUDENT values (124,4,'U-4070124');
insert into STUDENT values (125,4,'U-4070125');
insert into STUDENT values (126,4,'U-4070126');
insert into STUDENT values (127,4,'U-4070127');
insert into STUDENT values (128,4,'U-4070128');
insert into STUDENT values (129,4,'U-4070129');
insert into STUDENT values (130,4,'U-4070130');
insert into STUDENT values (131,4,'U-4070131');
insert into STUDENT values (132,4,'U-4070132');
insert into STUDENT values (133,4,'U-4070133');
insert into STUDENT values (134,4,'U-4070134');
insert into STUDENT values (135,4,'U-4070135');
insert into STUDENT values (136,4,'U-4070136');
insert into STUDENT values (137,4,'U-4070137');
insert into STUDENT values (138,4,'U-4070138');
insert into STUDENT values (139,4,'U-4070139');
insert into STUDENT values (140,4,'U-4070140');
insert into STUDENT values (141,4,'U-4080141');
insert into STUDENT values (142,4,'U-4080142');
insert into STUDENT values (143,4,'U-4080143');
insert into STUDENT values (144,4,'U-4080144');
insert into STUDENT values (145,4,'U-4080145');
insert into STUDENT values (146,4,'U-4080146');
insert into STUDENT values (147,4,'U-4080147');
insert into STUDENT values (148,4,'U-4080148');
insert into STUDENT values (149,4,'U-4080149');
insert into STUDENT values (150,4,'U-4080150');
insert into STUDENT values (151,4,'U-4080151');
insert into STUDENT values (152,4,'U-4080152');
insert into STUDENT values (153,4,'U-4080153');
insert into STUDENT values (154,4,'U-4080154');
insert into STUDENT values (155,4,'U-4080155');
insert into STUDENT values (156,4,'U-4080156');
insert into STUDENT values (157,4,'U-4080157');
insert into STUDENT values (158,4,'U-4080158');
insert into STUDENT values (159,4,'U-4080159');
insert into STUDENT values (160,4,'U-4080160');
insert into STUDENT values (161,5,'U-5090161');
insert into STUDENT values (162,5,'U-5090162');
insert into STUDENT values (163,5,'U-5090163');
insert into STUDENT values (164,5,'U-5090164');
insert into STUDENT values (165,5,'U-5090165');
insert into STUDENT values (166,5,'U-5090166');
insert into STUDENT values (167,5,'U-5090167');
insert into STUDENT values (168,5,'U-5090168');
insert into STUDENT values (169,5,'U-5090169');
insert into STUDENT values (170,5,'U-5090170');
insert into STUDENT values (171,5,'U-5090171');
insert into STUDENT values (172,5,'U-5090172');
insert into STUDENT values (173,5,'U-5090173');
insert into STUDENT values (174,5,'U-5090174');
insert into STUDENT values (175,5,'U-5090175');
insert into STUDENT values (176,5,'U-5090176');
insert into STUDENT values (177,5,'U-5090177');
insert into STUDENT values (178,5,'U-5090178');
insert into STUDENT values (179,5,'U-5090179');
insert into STUDENT values (180,5,'U-5090180');
insert into STUDENT values (181,5,'U-5100181');
insert into STUDENT values (182,5,'U-5100182');
insert into STUDENT values (183,5,'U-5100183');
insert into STUDENT values (184,5,'U-5100184');
insert into STUDENT values (185,5,'U-5100185');
insert into STUDENT values (186,5,'U-5100186');
insert into STUDENT values (187,5,'U-5100187');
insert into STUDENT values (188,5,'U-5100188');
insert into STUDENT values (189,5,'U-5100189');
insert into STUDENT values (190,5,'U-5100190');
insert into STUDENT values (191,5,'U-5100191');
insert into STUDENT values (192,5,'U-5100192');
insert into STUDENT values (193,5,'U-5100193');
insert into STUDENT values (194,5,'U-5100194');
insert into STUDENT values (195,5,'U-5100195');
insert into STUDENT values (196,5,'U-5100196');
insert into STUDENT values (197,5,'U-5100197');
insert into STUDENT values (198,5,'U-5100198');
insert into STUDENT values (199,5,'U-5100199');
insert into STUDENT values (200,5,'U-5100200');




insert into PRACOWNIK values (201, 1);
insert into PRACOWNIK values (202, 1);
insert into PRACOWNIK values (203, 1);
insert into PRACOWNIK values (204, 1);
insert into PRACOWNIK values (205, 1);
insert into PRACOWNIK values (206, 3);
insert into PRACOWNIK values (207, 6);
insert into PRACOWNIK values (208, 2);
insert into PRACOWNIK values (209, 4);
insert into PRACOWNIK values (210, 4);
insert into PRACOWNIK values (211, 3);
insert into PRACOWNIK values (212, 2);
insert into PRACOWNIK values (213, 6);
insert into PRACOWNIK values (214, 3);
insert into PRACOWNIK values (215, 4);
insert into PRACOWNIK values (216, 6);
insert into PRACOWNIK values (217, 3);
insert into PRACOWNIK values (218, 5);
insert into PRACOWNIK values (219, 4);
insert into PRACOWNIK values (220, 3);




insert into PRZEDMIOT values ('Services', null, 9);
insert into PRZEDMIOT values ('Support', null, 14);
insert into PRZEDMIOT values ('Human Resources', null, 17);
insert into PRZEDMIOT values ('Human Resources', null, 19);
insert into PRZEDMIOT values ('Business Development', null, 15);
insert into PRZEDMIOT values ('Training', null, 9);
insert into PRZEDMIOT values ('Support', null, 5);
insert into PRZEDMIOT values ('Product Management', null, 13);
insert into PRZEDMIOT values ('Services', null, 6);
insert into PRZEDMIOT values ('Product Management', null, 18);
insert into PRZEDMIOT values ('Sales', null, 20);
insert into PRZEDMIOT values ('Research and Development', null, 19);
insert into PRZEDMIOT values ('Marketing', null, 19);
insert into PRZEDMIOT values ('Training', null, 5);
insert into PRZEDMIOT values ('Business Development', null, 14);
insert into PRZEDMIOT values ('Legal', null, 18);
insert into PRZEDMIOT values ('Engineering', null, 19);
insert into PRZEDMIOT values ('Product Management', null, 16);
insert into PRZEDMIOT values ('Business Development', null, 14);
insert into PRZEDMIOT values ('Sales', null, 17);



insert into STUDENT_PRZEDMIOT values (1, 13, 3, 'vel enim sit amet nunc viverra');
insert into STUDENT_PRZEDMIOT values (2, 7, 4, 'amet eros suspendisse accumsan tortor');
insert into STUDENT_PRZEDMIOT values (3, 20, 4, 'hac habitasse platea dictumst etiam faucibus cursus urna ut tellus');
insert into STUDENT_PRZEDMIOT values (4, 15, 2, 'quis odio consequat varius integer ac leo pellentesque ultrices mattis');
insert into STUDENT_PRZEDMIOT values (5, 14, 4, 'viverra diam vitae quam suspendisse potenti nullam porttitor lacus');
insert into STUDENT_PRZEDMIOT values (6, 16, 4, 'lacinia erat vestibulum sed magna at nunc');
insert into STUDENT_PRZEDMIOT values (7, 12, 4, 'pellentesque eget nunc donec quis orci eget');
insert into STUDENT_PRZEDMIOT values (8, 1, 4, 'nulla neque libero convallis eget eleifend');
insert into STUDENT_PRZEDMIOT values (9, 10, 2, 'eget congue eget semper rutrum nulla');
insert into STUDENT_PRZEDMIOT values (10, 17, 5, 'neque duis bibendum morbi non quam nec dui');
insert into STUDENT_PRZEDMIOT values (11, 18, 4, 'id sapien in sapien iaculis');
insert into STUDENT_PRZEDMIOT values (12, 11, 4, 'eu interdum eu tincidunt in leo maecenas pulvinar lobortis est');
insert into STUDENT_PRZEDMIOT values (13, 17, 3, 'lacus morbi quis tortor id nulla ultrices aliquet maecenas leo');
insert into STUDENT_PRZEDMIOT values (14, 9, 5, 'orci luctus et ultrices posuere cubilia curae nulla');
insert into STUDENT_PRZEDMIOT values (15, 13, 3, 'sit amet consectetuer adipiscing elit proin interdum mauris');
insert into STUDENT_PRZEDMIOT values (16, 3, 4, 'pretium nisl ut volutpat sapien arcu sed augue aliquam');
insert into STUDENT_PRZEDMIOT values (17, 3, 2, 'sit amet sapien dignissim vestibulum vestibulum');
insert into STUDENT_PRZEDMIOT values (18, 14, 4, 'sapien dignissim vestibulum vestibulum ante ipsum primis');
insert into STUDENT_PRZEDMIOT values (19, 10, 5, 'odio odio elementum eu interdum eu tincidunt in leo maecenas');
insert into STUDENT_PRZEDMIOT values (20, 6, 4, 'nullam sit amet turpis elementum ligula vehicula consequat');
insert into STUDENT_PRZEDMIOT values (21, 2, 3, 'volutpat dui maecenas tristique est et tempus semper est quam');
insert into STUDENT_PRZEDMIOT values (22, 7, 5, 'gravida sem praesent id massa id nisl venenatis lacinia');
insert into STUDENT_PRZEDMIOT values (23, 17, 5, 'vulputate ut ultrices vel augue vestibulum ante ipsum primis');
insert into STUDENT_PRZEDMIOT values (24, 8, 3, 'congue risus semper porta volutpat');
insert into STUDENT_PRZEDMIOT values (25, 17, 3, 'nec euismod scelerisque quam turpis adipiscing');
insert into STUDENT_PRZEDMIOT values (26, 4, 5, 'dapibus at diam nam tristique tortor eu');
insert into STUDENT_PRZEDMIOT values (27, 9, 2, 'a odio in hac habitasse platea dictumst');
insert into STUDENT_PRZEDMIOT values (28, 7, 5, 'phasellus in felis donec semper sapien a libero nam');
insert into STUDENT_PRZEDMIOT values (29, 1, 3, 'ac est lacinia nisi venenatis tristique');
insert into STUDENT_PRZEDMIOT values (30, 18, 3, 'feugiat et eros vestibulum ac est lacinia nisi venenatis tristique');
insert into STUDENT_PRZEDMIOT values (31, 2, 2, 'dui proin leo odio porttitor id consequat in');
insert into STUDENT_PRZEDMIOT values (32, 4, 4, 'suscipit a feugiat et eros');
insert into STUDENT_PRZEDMIOT values (33, 20, 2, 'aliquam convallis nunc proin at turpis a pede posuere nonummy');
insert into STUDENT_PRZEDMIOT values (34, 3, 5, 'velit eu est congue elementum in hac habitasse');
insert into STUDENT_PRZEDMIOT values (35, 14, 3, 'justo sollicitudin ut suscipit a feugiat et eros vestibulum ac');
insert into STUDENT_PRZEDMIOT values (36, 14, 2, 'mauris eget massa tempor convallis');
insert into STUDENT_PRZEDMIOT values (37, 20, 2, 'sed lacus morbi sem mauris laoreet ut rhoncus');
insert into STUDENT_PRZEDMIOT values (38, 14, 5, 'fusce lacus purus aliquet at feugiat non pretium quis lectus');
insert into STUDENT_PRZEDMIOT values (39, 1, 4, 'ipsum primis in faucibus orci luctus et ultrices');
insert into STUDENT_PRZEDMIOT values (40, 18, 4, 'amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque');
insert into STUDENT_PRZEDMIOT values (41, 3, 2, 'eget eros elementum pellentesque quisque porta volutpat erat');
insert into STUDENT_PRZEDMIOT values (42, 11, 4, 'interdum mauris non ligula pellentesque ultrices phasellus id sapien');
insert into STUDENT_PRZEDMIOT values (43, 15, 5, 'aliquam erat volutpat in congue');
insert into STUDENT_PRZEDMIOT values (44, 4, 4, 'in tempor turpis nec euismod scelerisque quam');
insert into STUDENT_PRZEDMIOT values (45, 2, 5, 'pede malesuada in imperdiet et commodo');
insert into STUDENT_PRZEDMIOT values (46, 6, 3, 'quam nec dui luctus rutrum nulla');
insert into STUDENT_PRZEDMIOT values (47, 13, 2, 'in sagittis dui vel nisl duis ac nibh fusce');
insert into STUDENT_PRZEDMIOT values (48, 13, 4, 'justo lacinia eget tincidunt eget tempus vel pede');
insert into STUDENT_PRZEDMIOT values (49, 13, 3, 'ac lobortis vel dapibus at');
insert into STUDENT_PRZEDMIOT values (50, 19, 3, 'varius nulla facilisi cras non velit nec nisi vulputate nonummy');
insert into STUDENT_PRZEDMIOT values (51, 16, 3, 'hac habitasse platea dictumst morbi vestibulum velit id pretium');
insert into STUDENT_PRZEDMIOT values (52, 5, 2, 'ut ultrices vel augue vestibulum ante ipsum primis in faucibus');
insert into STUDENT_PRZEDMIOT values (53, 5, 2, 'eros viverra eget congue eget semper');
insert into STUDENT_PRZEDMIOT values (54, 14, 3, 'vulputate elementum nullam varius nulla facilisi cras non');
insert into STUDENT_PRZEDMIOT values (55, 20, 5, 'in felis eu sapien cursus vestibulum proin eu mi nulla');
insert into STUDENT_PRZEDMIOT values (56, 18, 5, 'ut mauris eget massa tempor convallis nulla neque');
insert into STUDENT_PRZEDMIOT values (57, 2, 2, 'dui nec nisi volutpat eleifend donec ut dolor morbi');
insert into STUDENT_PRZEDMIOT values (58, 1, 2, 'donec ut dolor morbi vel lectus in');
insert into STUDENT_PRZEDMIOT values (59, 3, 5, 'sed vel enim sit amet nunc viverra dapibus nulla suscipit');
insert into STUDENT_PRZEDMIOT values (60, 5, 2, 'nisl duis ac nibh fusce lacus purus aliquet at feugiat');
insert into STUDENT_PRZEDMIOT values (61, 20, 3, 'cursus vestibulum proin eu mi nulla ac enim in');
insert into STUDENT_PRZEDMIOT values (62, 15, 2, 'ipsum praesent blandit lacinia erat vestibulum sed magna at nunc');
insert into STUDENT_PRZEDMIOT values (63, 11, 4, 'ultrices erat tortor sollicitudin mi');
insert into STUDENT_PRZEDMIOT values (64, 2, 4, 'quam pharetra magna ac consequat metus sapien');
insert into STUDENT_PRZEDMIOT values (65, 4, 2, 'pharetra magna vestibulum aliquet ultrices erat tortor');
insert into STUDENT_PRZEDMIOT values (66, 5, 2, 'curae duis faucibus accumsan odio curabitur convallis duis consequat dui');
insert into STUDENT_PRZEDMIOT values (67, 12, 3, 'quis augue luctus tincidunt nulla mollis molestie');
insert into STUDENT_PRZEDMIOT values (68, 5, 3, 'tempor convallis nulla neque libero');
insert into STUDENT_PRZEDMIOT values (69, 11, 2, 'lorem integer tincidunt ante vel ipsum');
insert into STUDENT_PRZEDMIOT values (70, 14, 4, 'ridiculus mus vivamus vestibulum sagittis sapien cum');
insert into STUDENT_PRZEDMIOT values (71, 10, 4, 'cursus urna ut tellus nulla ut erat id');
insert into STUDENT_PRZEDMIOT values (72, 1, 2, 'eleifend luctus ultricies eu nibh quisque');
insert into STUDENT_PRZEDMIOT values (73, 14, 3, 'cubilia curae nulla dapibus dolor');
insert into STUDENT_PRZEDMIOT values (74, 2, 5, 'nam dui proin leo odio porttitor id consequat in');
insert into STUDENT_PRZEDMIOT values (75, 3, 4, 'facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt');
insert into STUDENT_PRZEDMIOT values (76, 14, 4, 'donec ut mauris eget massa tempor convallis');
insert into STUDENT_PRZEDMIOT values (77, 12, 4, 'et magnis dis parturient montes nascetur ridiculus');
insert into STUDENT_PRZEDMIOT values (78, 19, 4, 'vestibulum ante ipsum primis in faucibus orci luctus et');
insert into STUDENT_PRZEDMIOT values (79, 14, 5, 'ac nibh fusce lacus purus aliquet at');
insert into STUDENT_PRZEDMIOT values (80, 13, 3, 'molestie nibh in lectus pellentesque at nulla suspendisse');
insert into STUDENT_PRZEDMIOT values (81, 20, 4, 'maecenas ut massa quis augue');
insert into STUDENT_PRZEDMIOT values (82, 1, 3, 'in imperdiet et commodo vulputate justo in blandit ultrices');
insert into STUDENT_PRZEDMIOT values (83, 2, 5, 'blandit non interdum in ante vestibulum ante ipsum primis');
insert into STUDENT_PRZEDMIOT values (84, 6, 4, 'fusce congue diam id ornare imperdiet sapien urna pretium');
insert into STUDENT_PRZEDMIOT values (85, 8, 4, 'nulla nunc purus phasellus in');
insert into STUDENT_PRZEDMIOT values (86, 3, 4, 'odio curabitur convallis duis consequat dui nec nisi volutpat');
insert into STUDENT_PRZEDMIOT values (87, 12, 3, 'et magnis dis parturient montes nascetur ridiculus mus');
insert into STUDENT_PRZEDMIOT values (88, 3, 4, 'aenean auctor gravida sem praesent id');
insert into STUDENT_PRZEDMIOT values (89, 15, 4, 'quam sollicitudin vitae consectetuer eget rutrum');
insert into STUDENT_PRZEDMIOT values (90, 9, 5, 'nunc nisl duis bibendum felis');
insert into STUDENT_PRZEDMIOT values (91, 6, 3, 'vulputate luctus cum sociis natoque penatibus et magnis');
insert into STUDENT_PRZEDMIOT values (92, 11, 2, 'fusce congue diam id ornare imperdiet sapien');
insert into STUDENT_PRZEDMIOT values (93, 9, 4, 'sit amet lobortis sapien sapien non mi integer ac');
insert into STUDENT_PRZEDMIOT values (94, 13, 4, 'pulvinar sed nisl nunc rhoncus dui vel');
insert into STUDENT_PRZEDMIOT values (95, 5, 5, 'auctor sed tristique in tempus sit amet sem');
insert into STUDENT_PRZEDMIOT values (96, 10, 2, 'lacus purus aliquet at feugiat non pretium quis');
insert into STUDENT_PRZEDMIOT values (97, 14, 2, 'quam turpis adipiscing lorem vitae mattis');
insert into STUDENT_PRZEDMIOT values (98, 2, 2, 'in purus eu magna vulputate');
insert into STUDENT_PRZEDMIOT values (99, 14, 2, 'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque');
insert into STUDENT_PRZEDMIOT values (100, 17, 2, 'sed sagittis nam congue risus semper porta volutpat quam pede');
insert into STUDENT_PRZEDMIOT values (101, 7, 5, 'duis mattis egestas metus aenean fermentum');
insert into STUDENT_PRZEDMIOT values (102, 1, 5, 'dui vel sem sed sagittis');
insert into STUDENT_PRZEDMIOT values (103, 17, 4, 'eu mi nulla ac enim in');
insert into STUDENT_PRZEDMIOT values (104, 17, 2, 'elit proin interdum mauris non ligula pellentesque ultrices');
insert into STUDENT_PRZEDMIOT values (105, 19, 5, 'non sodales sed tincidunt eu felis fusce posuere felis sed');
insert into STUDENT_PRZEDMIOT values (106, 17, 4, 'integer a nibh in quis justo');
insert into STUDENT_PRZEDMIOT values (107, 15, 5, 'in quam fringilla rhoncus mauris enim');
insert into STUDENT_PRZEDMIOT values (108, 14, 3, 'nullam porttitor lacus at turpis donec');
insert into STUDENT_PRZEDMIOT values (109, 11, 3, 'mauris sit amet eros suspendisse');
insert into STUDENT_PRZEDMIOT values (110, 19, 3, 'lorem quisque ut erat curabitur gravida nisi at nibh');
insert into STUDENT_PRZEDMIOT values (111, 1, 2, 'sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit');
insert into STUDENT_PRZEDMIOT values (112, 5, 3, 'nam congue risus semper porta volutpat quam pede lobortis');
insert into STUDENT_PRZEDMIOT values (113, 10, 2, 'sed lacus morbi sem mauris laoreet ut rhoncus');
insert into STUDENT_PRZEDMIOT values (114, 16, 4, 'potenti nullam porttitor lacus at turpis donec posuere metus vitae');
insert into STUDENT_PRZEDMIOT values (115, 18, 3, 'integer non velit donec diam neque vestibulum eget');
insert into STUDENT_PRZEDMIOT values (116, 1, 3, 'luctus nec molestie sed justo pellentesque');
insert into STUDENT_PRZEDMIOT values (117, 2, 3, 'mauris lacinia sapien quis libero nullam sit amet turpis');
insert into STUDENT_PRZEDMIOT values (118, 1, 2, 'urna pretium nisl ut volutpat sapien arcu sed');
insert into STUDENT_PRZEDMIOT values (119, 8, 5, 'rhoncus aliquam lacus morbi quis tortor');
insert into STUDENT_PRZEDMIOT values (120, 15, 2, 'venenatis non sodales sed tincidunt eu felis fusce');
insert into STUDENT_PRZEDMIOT values (121, 14, 3, 'turpis integer aliquet massa id lobortis');
insert into STUDENT_PRZEDMIOT values (122, 10, 5, 'dolor vel est donec odio justo sollicitudin ut suscipit a');
insert into STUDENT_PRZEDMIOT values (123, 14, 4, 'id luctus nec molestie sed');
insert into STUDENT_PRZEDMIOT values (124, 6, 3, 'integer tincidunt ante vel ipsum praesent blandit lacinia');
insert into STUDENT_PRZEDMIOT values (125, 18, 2, 'tortor duis mattis egestas metus aenean');
insert into STUDENT_PRZEDMIOT values (126, 8, 4, 'lorem id ligula suspendisse ornare');
insert into STUDENT_PRZEDMIOT values (127, 17, 5, 'id justo sit amet sapien dignissim vestibulum vestibulum ante');
insert into STUDENT_PRZEDMIOT values (128, 20, 3, 'eget nunc donec quis orci eget orci');
insert into STUDENT_PRZEDMIOT values (129, 14, 3, 'cras mi pede malesuada in imperdiet et');
insert into STUDENT_PRZEDMIOT values (130, 2, 2, 'mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit');
insert into STUDENT_PRZEDMIOT values (131, 18, 4, 'turpis adipiscing lorem vitae mattis nibh ligula nec sem');
insert into STUDENT_PRZEDMIOT values (132, 5, 5, 'turpis integer aliquet massa id lobortis convallis tortor risus');
insert into STUDENT_PRZEDMIOT values (133, 8, 2, 'justo lacinia eget tincidunt eget tempus vel pede morbi porttitor');
insert into STUDENT_PRZEDMIOT values (134, 15, 5, 'aliquam non mauris morbi non lectus aliquam sit amet');
insert into STUDENT_PRZEDMIOT values (135, 5, 3, 'at nibh in hac habitasse');
insert into STUDENT_PRZEDMIOT values (136, 18, 5, 'elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis');
insert into STUDENT_PRZEDMIOT values (137, 2, 3, 'vel nisl duis ac nibh fusce lacus purus aliquet');
insert into STUDENT_PRZEDMIOT values (138, 5, 2, 'lectus vestibulum quam sapien varius ut blandit non interdum in');
insert into STUDENT_PRZEDMIOT values (139, 17, 4, 'adipiscing molestie hendrerit at vulputate vitae');
insert into STUDENT_PRZEDMIOT values (140, 15, 3, 'sem fusce consequat nulla nisl nunc nisl duis bibendum felis');
insert into STUDENT_PRZEDMIOT values (141, 17, 4, 'quam sollicitudin vitae consectetuer eget rutrum at lorem integer');
insert into STUDENT_PRZEDMIOT values (142, 11, 2, 'semper interdum mauris ullamcorper purus sit');
insert into STUDENT_PRZEDMIOT values (143, 10, 5, 'integer ac leo pellentesque ultrices mattis odio donec vitae nisi');
insert into STUDENT_PRZEDMIOT values (144, 12, 2, 'dis parturient montes nascetur ridiculus mus vivamus');
insert into STUDENT_PRZEDMIOT values (145, 11, 3, 'nulla pede ullamcorper augue a suscipit nulla elit ac');
insert into STUDENT_PRZEDMIOT values (146, 10, 4, 'nisl nunc rhoncus dui vel sem sed sagittis nam');
insert into STUDENT_PRZEDMIOT values (147, 10, 4, 'consectetuer adipiscing elit proin risus praesent lectus vestibulum quam');
insert into STUDENT_PRZEDMIOT values (148, 5, 5, 'ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien');
insert into STUDENT_PRZEDMIOT values (149, 19, 2, 'porttitor id consequat in consequat');
insert into STUDENT_PRZEDMIOT values (150, 19, 2, 'morbi vestibulum velit id pretium iaculis diam erat');
insert into STUDENT_PRZEDMIOT values (151, 19, 3, 'nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus');
insert into STUDENT_PRZEDMIOT values (152, 19, 4, 'ut erat id mauris vulputate elementum nullam varius nulla');
insert into STUDENT_PRZEDMIOT values (153, 18, 5, 'scelerisque mauris sit amet eros suspendisse accumsan tortor');
insert into STUDENT_PRZEDMIOT values (154, 3, 4, 'dapibus nulla suscipit ligula in lacus');
insert into STUDENT_PRZEDMIOT values (155, 18, 4, 'magnis dis parturient montes nascetur ridiculus mus vivamus');
insert into STUDENT_PRZEDMIOT values (156, 10, 5, 'eget nunc donec quis orci eget');
insert into STUDENT_PRZEDMIOT values (157, 10, 5, 'vel sem sed sagittis nam congue risus semper porta volutpat');
insert into STUDENT_PRZEDMIOT values (158, 7, 5, 'quis augue luctus tincidunt nulla');
insert into STUDENT_PRZEDMIOT values (159, 20, 2, 'aenean lectus pellentesque eget nunc donec');
insert into STUDENT_PRZEDMIOT values (160, 19, 5, 'tempus sit amet sem fusce consequat');
insert into STUDENT_PRZEDMIOT values (161, 19, 3, 'libero convallis eget eleifend luctus ultricies');
insert into STUDENT_PRZEDMIOT values (162, 10, 4, 'laoreet ut rhoncus aliquet pulvinar sed nisl');
insert into STUDENT_PRZEDMIOT values (163, 7, 3, 'elementum eu interdum eu tincidunt in leo');
insert into STUDENT_PRZEDMIOT values (164, 13, 2, 'ut tellus nulla ut erat');
insert into STUDENT_PRZEDMIOT values (165, 19, 4, 'in tempus sit amet sem fusce consequat nulla nisl');
insert into STUDENT_PRZEDMIOT values (166, 19, 5, 'etiam pretium iaculis justo in hac habitasse platea dictumst etiam');
insert into STUDENT_PRZEDMIOT values (167, 8, 2, 'vitae quam suspendisse potenti nullam porttitor');
insert into STUDENT_PRZEDMIOT values (168, 17, 3, 'nunc donec quis orci eget orci');
insert into STUDENT_PRZEDMIOT values (169, 17, 4, 'porta volutpat erat quisque erat eros');
insert into STUDENT_PRZEDMIOT values (170, 20, 4, 'lorem id ligula suspendisse ornare consequat lectus in est risus');
insert into STUDENT_PRZEDMIOT values (171, 10, 2, 'congue vivamus metus arcu adipiscing');
insert into STUDENT_PRZEDMIOT values (172, 9, 3, 'magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet');
insert into STUDENT_PRZEDMIOT values (173, 9, 3, 'iaculis diam erat fermentum justo nec condimentum neque sapien placerat');
insert into STUDENT_PRZEDMIOT values (174, 18, 3, 'quam pede lobortis ligula sit');
insert into STUDENT_PRZEDMIOT values (175, 1, 4, 'posuere cubilia curae mauris viverra diam');
insert into STUDENT_PRZEDMIOT values (176, 20, 2, 'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing');
insert into STUDENT_PRZEDMIOT values (177, 1, 5, 'suspendisse accumsan tortor quis turpis');
insert into STUDENT_PRZEDMIOT values (178, 9, 3, 'urna pretium nisl ut volutpat sapien arcu sed augue aliquam');
insert into STUDENT_PRZEDMIOT values (179, 14, 4, 'cubilia curae nulla dapibus dolor vel est');
insert into STUDENT_PRZEDMIOT values (180, 2, 3, 'ut massa quis augue luctus');
insert into STUDENT_PRZEDMIOT values (181, 20, 3, 'magna bibendum imperdiet nullam orci pede venenatis non sodales sed');
insert into STUDENT_PRZEDMIOT values (182, 10, 2, 'vestibulum eget vulputate ut ultrices vel augue');
insert into STUDENT_PRZEDMIOT values (183, 5, 5, 'sed tristique in tempus sit amet sem');
insert into STUDENT_PRZEDMIOT values (184, 7, 4, 'potenti in eleifend quam a odio in hac habitasse');
insert into STUDENT_PRZEDMIOT values (185, 16, 3, 'interdum in ante vestibulum ante ipsum primis in');
insert into STUDENT_PRZEDMIOT values (186, 11, 2, 'euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula');
insert into STUDENT_PRZEDMIOT values (187, 16, 4, 'porta volutpat quam pede lobortis ligula sit amet eleifend pede');
insert into STUDENT_PRZEDMIOT values (188, 11, 4, 'ac enim in tempor turpis nec euismod scelerisque quam');
insert into STUDENT_PRZEDMIOT values (189, 17, 4, 'sapien iaculis congue vivamus metus arcu adipiscing molestie');
insert into STUDENT_PRZEDMIOT values (190, 12, 5, 'dis parturient montes nascetur ridiculus mus');
insert into STUDENT_PRZEDMIOT values (191, 20, 3, 'tincidunt nulla mollis molestie lorem quisque ut');
insert into STUDENT_PRZEDMIOT values (192, 3, 4, 'praesent lectus vestibulum quam sapien varius ut blandit non');
insert into STUDENT_PRZEDMIOT values (193, 7, 4, 'id nisl venenatis lacinia aenean sit amet justo morbi');
insert into STUDENT_PRZEDMIOT values (194, 16, 2, 'mattis pulvinar nulla pede ullamcorper augue a suscipit');
insert into STUDENT_PRZEDMIOT values (195, 18, 3, 'cras in purus eu magna');
insert into STUDENT_PRZEDMIOT values (196, 11, 2, 'donec pharetra magna vestibulum aliquet');
insert into STUDENT_PRZEDMIOT values (197, 12, 4, 'et magnis dis parturient montes nascetur ridiculus mus vivamus');
insert into STUDENT_PRZEDMIOT values (198, 1, 3, 'morbi ut odio cras mi pede');
insert into STUDENT_PRZEDMIOT values (199, 7, 4, 'aenean auctor gravida sem praesent id');
insert into STUDENT_PRZEDMIOT values (200, 9, 2, 'mus etiam vel augue vestibulum');
insert into STUDENT_PRZEDMIOT values (1, 16, 3, 'nunc nisl duis bibendum felis sed interdum venenatis turpis');
insert into STUDENT_PRZEDMIOT values (2, 11, 5, 'ante ipsum primis in faucibus orci luctus et');
insert into STUDENT_PRZEDMIOT values (3, 14, 4, 'sem sed sagittis nam congue');
insert into STUDENT_PRZEDMIOT values (4, 3, 4, 'quam fringilla rhoncus mauris enim leo rhoncus sed');
insert into STUDENT_PRZEDMIOT values (5, 2, 5, 'felis ut at dolor quis odio consequat varius integer');
insert into STUDENT_PRZEDMIOT values (6, 10, 4, 'rutrum nulla nunc purus phasellus in');
insert into STUDENT_PRZEDMIOT values (7, 3, 5, 'iaculis congue vivamus metus arcu adipiscing molestie');
insert into STUDENT_PRZEDMIOT values (8, 7, 2, 'dui vel sem sed sagittis nam congue risus semper porta');
insert into STUDENT_PRZEDMIOT values (9, 20, 2, 'turpis sed ante vivamus tortor duis mattis egestas');
insert into STUDENT_PRZEDMIOT values (10, 10, 2, 'cubilia curae mauris viverra diam vitae quam suspendisse');
insert into STUDENT_PRZEDMIOT values (11, 20, 5, 'tempor turpis nec euismod scelerisque quam turpis adipiscing');
insert into STUDENT_PRZEDMIOT values (12, 12, 5, 'augue luctus tincidunt nulla mollis molestie');
insert into STUDENT_PRZEDMIOT values (13, 2, 4, 'dapibus augue vel accumsan tellus nisi eu orci');
insert into STUDENT_PRZEDMIOT values (14, 11, 2, 'dapibus nulla suscipit ligula in lacus curabitur');
insert into STUDENT_PRZEDMIOT values (15, 12, 2, 'congue elementum in hac habitasse');
insert into STUDENT_PRZEDMIOT values (16, 5, 5, 'in tempor turpis nec euismod scelerisque quam');
insert into STUDENT_PRZEDMIOT values (17, 5, 4, 'fringilla rhoncus mauris enim leo rhoncus sed vestibulum');
insert into STUDENT_PRZEDMIOT values (18, 12, 2, 'maecenas ut massa quis augue luctus tincidunt nulla');
insert into STUDENT_PRZEDMIOT values (19, 6, 2, 'augue quam sollicitudin vitae consectetuer eget rutrum at');
insert into STUDENT_PRZEDMIOT values (20, 8, 4, 'justo in blandit ultrices enim lorem ipsum dolor sit');
insert into STUDENT_PRZEDMIOT values (21, 9, 2, 'etiam pretium iaculis justo in hac habitasse');
insert into STUDENT_PRZEDMIOT values (22, 5, 5, 'sapien arcu sed augue aliquam');
insert into STUDENT_PRZEDMIOT values (23, 15, 3, 'curae duis faucibus accumsan odio');
insert into STUDENT_PRZEDMIOT values (24, 7, 4, 'porttitor id consequat in consequat ut');
insert into STUDENT_PRZEDMIOT values (25, 8, 2, 'vivamus tortor duis mattis egestas metus aenean fermentum donec ut');
insert into STUDENT_PRZEDMIOT values (26, 1, 2, 'pede venenatis non sodales sed tincidunt eu felis fusce');
insert into STUDENT_PRZEDMIOT values (27, 10, 5, 'nam dui proin leo odio porttitor id consequat in');
insert into STUDENT_PRZEDMIOT values (28, 2, 2, 'morbi ut odio cras mi pede');
insert into STUDENT_PRZEDMIOT values (29, 19, 5, 'in hac habitasse platea dictumst etiam faucibus cursus');
insert into STUDENT_PRZEDMIOT values (30, 8, 5, 'mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit');
insert into STUDENT_PRZEDMIOT values (31, 13, 4, 'phasellus id sapien in sapien iaculis congue vivamus metus arcu');
insert into STUDENT_PRZEDMIOT values (32, 19, 4, 'odio justo sollicitudin ut suscipit a feugiat et eros');
insert into STUDENT_PRZEDMIOT values (33, 15, 2, 'blandit ultrices enim lorem ipsum dolor');
insert into STUDENT_PRZEDMIOT values (34, 2, 4, 'consequat ut nulla sed accumsan felis ut at dolor quis');
insert into STUDENT_PRZEDMIOT values (35, 1, 2, 'lorem quisque ut erat curabitur gravida nisi at nibh');
insert into STUDENT_PRZEDMIOT values (36, 10, 2, 'lectus aliquam sit amet diam in magna bibendum imperdiet nullam');
insert into STUDENT_PRZEDMIOT values (37, 11, 4, 'justo aliquam quis turpis eget elit sodales');
insert into STUDENT_PRZEDMIOT values (38, 17, 5, 'integer ac leo pellentesque ultrices');
insert into STUDENT_PRZEDMIOT values (39, 10, 2, 'curabitur convallis duis consequat dui');
insert into STUDENT_PRZEDMIOT values (40, 12, 3, 'velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit');
insert into STUDENT_PRZEDMIOT values (41, 3, 5, 'penatibus et magnis dis parturient montes nascetur ridiculus');
insert into STUDENT_PRZEDMIOT values (42, 2, 5, 'aliquam augue quam sollicitudin vitae');
insert into STUDENT_PRZEDMIOT values (43, 15, 3, 'consequat lectus in est risus auctor sed tristique in tempus');
insert into STUDENT_PRZEDMIOT values (44, 20, 2, 'dictumst maecenas ut massa quis augue luctus tincidunt');
insert into STUDENT_PRZEDMIOT values (45, 16, 2, 'amet nulla quisque arcu libero');
insert into STUDENT_PRZEDMIOT values (46, 8, 2, 'erat id mauris vulputate elementum nullam varius');
insert into STUDENT_PRZEDMIOT values (47, 19, 4, 'dapibus at diam nam tristique');
insert into STUDENT_PRZEDMIOT values (48, 13, 5, 'dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis');
insert into STUDENT_PRZEDMIOT values (49, 13, 5, 'tortor sollicitudin mi sit amet lobortis sapien');
insert into STUDENT_PRZEDMIOT values (50, 11, 3, 'iaculis diam erat fermentum justo nec condimentum neque sapien');
insert into STUDENT_PRZEDMIOT values (51, 6, 5, 'in tempor turpis nec euismod scelerisque');
insert into STUDENT_PRZEDMIOT values (52, 5, 4, 'in sapien iaculis congue vivamus metus arcu');
insert into STUDENT_PRZEDMIOT values (53, 1, 5, 'scelerisque quam turpis adipiscing lorem');
insert into STUDENT_PRZEDMIOT values (54, 3, 5, 'in hac habitasse platea dictumst maecenas ut massa quis');
insert into STUDENT_PRZEDMIOT values (55, 20, 3, 'congue etiam justo etiam pretium iaculis justo in hac habitasse');
insert into STUDENT_PRZEDMIOT values (56, 9, 4, 'lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem');
insert into STUDENT_PRZEDMIOT values (57, 1, 4, 'sapien ut nunc vestibulum ante');
insert into STUDENT_PRZEDMIOT values (58, 8, 4, 'aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed');
insert into STUDENT_PRZEDMIOT values (59, 19, 3, 'ligula suspendisse ornare consequat lectus in est risus');
insert into STUDENT_PRZEDMIOT values (60, 14, 4, 'pede justo eu massa donec dapibus duis');
insert into STUDENT_PRZEDMIOT values (61, 1, 5, 'volutpat in congue etiam justo etiam pretium iaculis justo');
insert into STUDENT_PRZEDMIOT values (62, 13, 2, 'posuere cubilia curae duis faucibus accumsan');
insert into STUDENT_PRZEDMIOT values (63, 7, 4, 'quis turpis eget elit sodales scelerisque mauris sit amet');
insert into STUDENT_PRZEDMIOT values (64, 6, 4, 'felis eu sapien cursus vestibulum proin eu mi nulla');
insert into STUDENT_PRZEDMIOT values (65, 18, 5, 'tempus vivamus in felis eu sapien cursus');
insert into STUDENT_PRZEDMIOT values (66, 7, 4, 'in hac habitasse platea dictumst morbi vestibulum');
insert into STUDENT_PRZEDMIOT values (67, 10, 2, 'quam pede lobortis ligula sit amet eleifend pede libero');
insert into STUDENT_PRZEDMIOT values (68, 10, 4, 'dapibus nulla suscipit ligula in');
insert into STUDENT_PRZEDMIOT values (69, 7, 2, 'pharetra magna ac consequat metus sapien ut nunc');
insert into STUDENT_PRZEDMIOT values (70, 3, 4, 'fusce consequat nulla nisl nunc nisl duis');
insert into STUDENT_PRZEDMIOT values (71, 7, 2, 'sed nisl nunc rhoncus dui vel sem sed sagittis nam');
insert into STUDENT_PRZEDMIOT values (72, 3, 3, 'varius nulla facilisi cras non velit nec nisi vulputate nonummy');
insert into STUDENT_PRZEDMIOT values (73, 1, 3, 'quis turpis sed ante vivamus tortor duis mattis egestas');
insert into STUDENT_PRZEDMIOT values (74, 13, 3, 'sit amet erat nulla tempus vivamus in felis');
insert into STUDENT_PRZEDMIOT values (75, 20, 3, 'justo maecenas rhoncus aliquam lacus');
insert into STUDENT_PRZEDMIOT values (76, 3, 5, 'varius ut blandit non interdum in ante vestibulum');
insert into STUDENT_PRZEDMIOT values (77, 13, 2, 'id sapien in sapien iaculis');
insert into STUDENT_PRZEDMIOT values (78, 14, 2, 'amet turpis elementum ligula vehicula consequat');
insert into STUDENT_PRZEDMIOT values (79, 16, 5, 'id nulla ultrices aliquet maecenas leo odio');
insert into STUDENT_PRZEDMIOT values (80, 18, 3, 'eu magna vulputate luctus cum sociis');
insert into STUDENT_PRZEDMIOT values (81, 15, 5, 'platea dictumst maecenas ut massa quis augue luctus tincidunt nulla');
insert into STUDENT_PRZEDMIOT values (82, 10, 3, 'elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis');
insert into STUDENT_PRZEDMIOT values (83, 13, 4, 'dignissim vestibulum vestibulum ante ipsum primis in faucibus');
insert into STUDENT_PRZEDMIOT values (84, 4, 3, 'eros viverra eget congue eget');
insert into STUDENT_PRZEDMIOT values (85, 9, 5, 'duis mattis egestas metus aenean fermentum donec ut mauris');
insert into STUDENT_PRZEDMIOT values (86, 9, 2, 'rhoncus mauris enim leo rhoncus sed');
insert into STUDENT_PRZEDMIOT values (87, 5, 2, 'eleifend quam a odio in hac habitasse');
insert into STUDENT_PRZEDMIOT values (88, 8, 5, 'nulla tempus vivamus in felis eu sapien cursus vestibulum');
insert into STUDENT_PRZEDMIOT values (89, 8, 3, 'mauris lacinia sapien quis libero nullam sit amet turpis');
insert into STUDENT_PRZEDMIOT values (90, 12, 4, 'facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt');
insert into STUDENT_PRZEDMIOT values (91, 5, 5, 'curabitur convallis duis consequat dui');
insert into STUDENT_PRZEDMIOT values (92, 9, 4, 'etiam pretium iaculis justo in hac habitasse platea');
insert into STUDENT_PRZEDMIOT values (93, 1, 4, 'pretium quis lectus suspendisse potenti in eleifend');
insert into STUDENT_PRZEDMIOT values (94, 4, 4, 'orci mauris lacinia sapien quis');
insert into STUDENT_PRZEDMIOT values (95, 2, 4, 'diam erat fermentum justo nec condimentum neque sapien placerat ante');
insert into STUDENT_PRZEDMIOT values (96, 14, 3, 'metus vitae ipsum aliquam non mauris morbi non lectus');
insert into STUDENT_PRZEDMIOT values (97, 7, 2, 'platea dictumst aliquam augue quam sollicitudin vitae consectetuer');
insert into STUDENT_PRZEDMIOT values (98, 19, 3, 'interdum mauris ullamcorper purus sit amet');
insert into STUDENT_PRZEDMIOT values (99, 10, 3, 'platea dictumst aliquam augue quam sollicitudin vitae consectetuer');
insert into STUDENT_PRZEDMIOT values (100, 9, 4, 'porta volutpat erat quisque erat eros viverra eget congue eget');
insert into STUDENT_PRZEDMIOT values (101, 6, 2, 'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque');
insert into STUDENT_PRZEDMIOT values (102, 19, 2, 'morbi non lectus aliquam sit amet diam in magna bibendum');
insert into STUDENT_PRZEDMIOT values (103, 19, 3, 'ut dolor morbi vel lectus in quam fringilla rhoncus mauris');
insert into STUDENT_PRZEDMIOT values (104, 20, 3, 'pellentesque ultrices phasellus id sapien in');
insert into STUDENT_PRZEDMIOT values (105, 6, 5, 'vel dapibus at diam nam');
insert into STUDENT_PRZEDMIOT values (106, 17, 5, 'odio odio elementum eu interdum eu');
insert into STUDENT_PRZEDMIOT values (107, 19, 2, 'nisi nam ultrices libero non mattis');
insert into STUDENT_PRZEDMIOT values (108, 6, 5, 'vitae quam suspendisse potenti nullam porttitor');
insert into STUDENT_PRZEDMIOT values (109, 1, 3, 'dictumst etiam faucibus cursus urna ut tellus');
insert into STUDENT_PRZEDMIOT values (110, 19, 5, 'id consequat in consequat ut nulla sed accumsan felis');
insert into STUDENT_PRZEDMIOT values (111, 20, 2, 'felis eu sapien cursus vestibulum proin eu mi');
insert into STUDENT_PRZEDMIOT values (112, 8, 3, 'nonummy integer non velit donec diam neque');
insert into STUDENT_PRZEDMIOT values (113, 15, 2, 'posuere cubilia curae nulla dapibus dolor');
insert into STUDENT_PRZEDMIOT values (114, 13, 2, 'porttitor id consequat in consequat ut nulla sed accumsan felis');
insert into STUDENT_PRZEDMIOT values (115, 12, 3, 'vitae nisl aenean lectus pellentesque eget nunc donec');
insert into STUDENT_PRZEDMIOT values (116, 1, 5, 'tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida');
insert into STUDENT_PRZEDMIOT values (117, 8, 4, 'pellentesque ultrices mattis odio donec vitae nisi nam ultrices');
insert into STUDENT_PRZEDMIOT values (118, 5, 4, 'vel augue vestibulum rutrum rutrum neque');
insert into STUDENT_PRZEDMIOT values (119, 17, 5, 'morbi a ipsum integer a nibh in quis justo maecenas');
insert into STUDENT_PRZEDMIOT values (120, 2, 2, 'vel nisl duis ac nibh fusce lacus purus aliquet');
insert into STUDENT_PRZEDMIOT values (121, 7, 5, 'ligula suspendisse ornare consequat lectus in');
insert into STUDENT_PRZEDMIOT values (122, 7, 3, 'ut suscipit a feugiat et eros vestibulum ac');
insert into STUDENT_PRZEDMIOT values (123, 8, 3, 'dictumst aliquam augue quam sollicitudin vitae consectetuer eget');
insert into STUDENT_PRZEDMIOT values (124, 15, 3, 'diam cras pellentesque volutpat dui maecenas tristique est');
insert into STUDENT_PRZEDMIOT values (125, 19, 5, 'velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit');
insert into STUDENT_PRZEDMIOT values (126, 6, 2, 'faucibus cursus urna ut tellus nulla');
insert into STUDENT_PRZEDMIOT values (127, 8, 2, 'mauris laoreet ut rhoncus aliquet');
insert into STUDENT_PRZEDMIOT values (128, 5, 3, 'pede ullamcorper augue a suscipit nulla elit ac nulla sed');
insert into STUDENT_PRZEDMIOT values (129, 7, 2, 'nunc donec quis orci eget');
insert into STUDENT_PRZEDMIOT values (130, 20, 2, 'faucibus orci luctus et ultrices posuere');
insert into STUDENT_PRZEDMIOT values (131, 20, 2, 'sit amet justo morbi ut odio cras mi pede malesuada');
insert into STUDENT_PRZEDMIOT values (132, 18, 2, 'ultrices posuere cubilia curae nulla dapibus dolor vel est');
insert into STUDENT_PRZEDMIOT values (133, 19, 5, 'morbi non quam nec dui luctus rutrum nulla');
insert into STUDENT_PRZEDMIOT values (134, 12, 2, 'libero rutrum ac lobortis vel dapibus at');
insert into STUDENT_PRZEDMIOT values (135, 10, 4, 'donec ut mauris eget massa tempor convallis nulla neque libero');
insert into STUDENT_PRZEDMIOT values (136, 5, 5, 'ut massa quis augue luctus');
insert into STUDENT_PRZEDMIOT values (137, 11, 3, 'eget eleifend luctus ultricies eu nibh quisque id');
insert into STUDENT_PRZEDMIOT values (138, 17, 3, 'erat curabitur gravida nisi at nibh in hac');
insert into STUDENT_PRZEDMIOT values (139, 20, 2, 'massa tempor convallis nulla neque libero convallis eget');
insert into STUDENT_PRZEDMIOT values (140, 2, 5, 'duis bibendum felis sed interdum');
insert into STUDENT_PRZEDMIOT values (141, 12, 3, 'tortor risus dapibus augue vel');
insert into STUDENT_PRZEDMIOT values (142, 6, 2, 'fermentum donec ut mauris eget massa tempor');
insert into STUDENT_PRZEDMIOT values (143, 15, 4, 'ante ipsum primis in faucibus');
insert into STUDENT_PRZEDMIOT values (144, 6, 5, 'nec sem duis aliquam convallis nunc proin at turpis');
insert into STUDENT_PRZEDMIOT values (145, 16, 2, 'odio in hac habitasse platea');
insert into STUDENT_PRZEDMIOT values (146, 11, 4, 'nulla nisl nunc nisl duis');
insert into STUDENT_PRZEDMIOT values (147, 14, 5, 'vestibulum sit amet cursus id turpis');
insert into STUDENT_PRZEDMIOT values (148, 9, 3, 'morbi a ipsum integer a nibh in');
insert into STUDENT_PRZEDMIOT values (149, 17, 3, 'ut volutpat sapien arcu sed augue aliquam erat volutpat in');
insert into STUDENT_PRZEDMIOT values (150, 1, 2, 'congue diam id ornare imperdiet sapien urna');
insert into STUDENT_PRZEDMIOT values (151, 4, 5, 'justo in blandit ultrices enim lorem ipsum dolor');
insert into STUDENT_PRZEDMIOT values (152, 10, 5, 'dignissim vestibulum vestibulum ante ipsum primis');
insert into STUDENT_PRZEDMIOT values (153, 10, 5, 'eu magna vulputate luctus cum sociis natoque penatibus et');
insert into STUDENT_PRZEDMIOT values (154, 13, 2, 'id consequat in consequat ut nulla sed');
insert into STUDENT_PRZEDMIOT values (155, 9, 2, 'odio odio elementum eu interdum eu tincidunt in');
insert into STUDENT_PRZEDMIOT values (156, 5, 5, 'in consequat ut nulla sed accumsan felis ut at dolor');
insert into STUDENT_PRZEDMIOT values (157, 15, 4, 'elementum in hac habitasse platea dictumst morbi vestibulum');
insert into STUDENT_PRZEDMIOT values (158, 5, 5, 'faucibus cursus urna ut tellus nulla ut erat id');
insert into STUDENT_PRZEDMIOT values (159, 3, 5, 'eget elit sodales scelerisque mauris sit amet');
insert into STUDENT_PRZEDMIOT values (160, 4, 5, 'sit amet eros suspendisse accumsan tortor quis turpis sed');
insert into STUDENT_PRZEDMIOT values (161, 8, 4, 'odio in hac habitasse platea');
insert into STUDENT_PRZEDMIOT values (162, 6, 3, 'viverra eget congue eget semper');
insert into STUDENT_PRZEDMIOT values (163, 7, 3, 'ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu');
insert into STUDENT_PRZEDMIOT values (164, 15, 5, 'nisi venenatis tristique fusce congue diam');
insert into STUDENT_PRZEDMIOT values (165, 12, 4, 'consectetuer adipiscing elit proin risus praesent lectus');
insert into STUDENT_PRZEDMIOT values (166, 14, 4, 'et ultrices posuere cubilia curae donec');
insert into STUDENT_PRZEDMIOT values (167, 2, 3, 'nunc nisl duis bibendum felis sed');
insert into STUDENT_PRZEDMIOT values (168, 9, 2, 'sed ante vivamus tortor duis mattis egestas metus aenean');
insert into STUDENT_PRZEDMIOT values (169, 5, 5, 'hendrerit at vulputate vitae nisl aenean lectus pellentesque');
insert into STUDENT_PRZEDMIOT values (170, 3, 5, 'vitae nisl aenean lectus pellentesque eget nunc donec quis');
insert into STUDENT_PRZEDMIOT values (171, 10, 4, 'nulla suscipit ligula in lacus curabitur at ipsum');
insert into STUDENT_PRZEDMIOT values (172, 17, 3, 'imperdiet sapien urna pretium nisl ut volutpat');
insert into STUDENT_PRZEDMIOT values (173, 9, 4, 'turpis nec euismod scelerisque quam turpis adipiscing lorem');
insert into STUDENT_PRZEDMIOT values (174, 17, 2, 'non velit donec diam neque');
insert into STUDENT_PRZEDMIOT values (175, 8, 4, 'pharetra magna ac consequat metus sapien ut nunc vestibulum');
insert into STUDENT_PRZEDMIOT values (176, 11, 3, 'in consequat ut nulla sed accumsan felis ut at');
insert into STUDENT_PRZEDMIOT values (177, 9, 3, 'nulla facilisi cras non velit nec nisi vulputate nonummy');
insert into STUDENT_PRZEDMIOT values (178, 5, 2, 'nulla suspendisse potenti cras in');
insert into STUDENT_PRZEDMIOT values (179, 9, 3, 'aenean auctor gravida sem praesent id massa');
insert into STUDENT_PRZEDMIOT values (180, 16, 4, 'sagittis nam congue risus semper porta volutpat quam pede lobortis');
insert into STUDENT_PRZEDMIOT values (181, 18, 2, 'lacinia erat vestibulum sed magna at');
insert into STUDENT_PRZEDMIOT values (182, 19, 2, 'dapibus dolor vel est donec odio');
insert into STUDENT_PRZEDMIOT values (183, 15, 4, 'ac neque duis bibendum morbi non quam');
insert into STUDENT_PRZEDMIOT values (184, 11, 4, 'ligula vehicula consequat morbi a');
insert into STUDENT_PRZEDMIOT values (185, 18, 4, 'tempor convallis nulla neque libero convallis eget eleifend luctus ultricies');
insert into STUDENT_PRZEDMIOT values (186, 18, 2, 'nullam molestie nibh in lectus pellentesque at');
insert into STUDENT_PRZEDMIOT values (187, 8, 5, 'dolor sit amet consectetuer adipiscing elit proin interdum');
insert into STUDENT_PRZEDMIOT values (188, 20, 2, 'sapien placerat ante nulla justo aliquam quis turpis eget elit');
insert into STUDENT_PRZEDMIOT values (189, 3, 2, 'velit vivamus vel nulla eget');
insert into STUDENT_PRZEDMIOT values (190, 20, 2, 'nisl duis ac nibh fusce');
insert into STUDENT_PRZEDMIOT values (191, 5, 4, 'libero ut massa volutpat convallis morbi odio');
insert into STUDENT_PRZEDMIOT values (192, 7, 3, 'aliquet ultrices erat tortor sollicitudin mi sit amet lobortis');
insert into STUDENT_PRZEDMIOT values (193, 14, 2, 'porta volutpat quam pede lobortis ligula sit amet');
insert into STUDENT_PRZEDMIOT values (194, 3, 3, 'suspendisse ornare consequat lectus in est risus');
insert into STUDENT_PRZEDMIOT values (195, 19, 5, 'habitasse platea dictumst aliquam augue quam sollicitudin');
insert into STUDENT_PRZEDMIOT values (196, 7, 2, 'ornare consequat lectus in est risus auctor sed tristique in');
insert into STUDENT_PRZEDMIOT values (197, 8, 3, 'tortor duis mattis egestas metus aenean');
insert into STUDENT_PRZEDMIOT values (198, 6, 4, 'luctus et ultrices posuere cubilia curae mauris');
insert into STUDENT_PRZEDMIOT values (199, 4, 4, 'leo maecenas pulvinar lobortis est phasellus sit amet');
insert into STUDENT_PRZEDMIOT values (200, 11, 4, 'felis donec semper sapien a');
insert into STUDENT_PRZEDMIOT values (1, 3, 5, 'ligula nec sem duis aliquam');
insert into STUDENT_PRZEDMIOT values (2, 7, 5, 'condimentum neque sapien placerat ante nulla justo aliquam');
insert into STUDENT_PRZEDMIOT values (3, 10, 4, 'vel augue vestibulum ante ipsum');
insert into STUDENT_PRZEDMIOT values (4, 18, 3, 'cras pellentesque volutpat dui maecenas');
insert into STUDENT_PRZEDMIOT values (5, 15, 2, 'ultrices enim lorem ipsum dolor sit amet consectetuer');
insert into STUDENT_PRZEDMIOT values (6, 14, 5, 'nibh in quis justo maecenas rhoncus aliquam lacus morbi quis');
insert into STUDENT_PRZEDMIOT values (7, 12, 3, 'primis in faucibus orci luctus');
insert into STUDENT_PRZEDMIOT values (8, 14, 2, 'vestibulum proin eu mi nulla ac');
insert into STUDENT_PRZEDMIOT values (9, 4, 3, 'quisque arcu libero rutrum ac lobortis vel dapibus');
insert into STUDENT_PRZEDMIOT values (10, 12, 4, 'sodales sed tincidunt eu felis fusce posuere');
insert into STUDENT_PRZEDMIOT values (11, 11, 3, 'orci eget orci vehicula condimentum curabitur in libero ut');
insert into STUDENT_PRZEDMIOT values (12, 17, 3, 'nunc commodo placerat praesent blandit nam');
insert into STUDENT_PRZEDMIOT values (13, 8, 4, 'integer ac leo pellentesque ultrices mattis odio');
insert into STUDENT_PRZEDMIOT values (14, 15, 2, 'odio consequat varius integer ac');
insert into STUDENT_PRZEDMIOT values (15, 19, 5, 'sapien arcu sed augue aliquam erat volutpat in');
insert into STUDENT_PRZEDMIOT values (16, 14, 3, 'justo maecenas rhoncus aliquam lacus morbi');
insert into STUDENT_PRZEDMIOT values (17, 16, 4, 'faucibus accumsan odio curabitur convallis duis consequat dui');
insert into STUDENT_PRZEDMIOT values (18, 19, 5, 'iaculis diam erat fermentum justo');
insert into STUDENT_PRZEDMIOT values (19, 11, 3, 'luctus ultricies eu nibh quisque id');
insert into STUDENT_PRZEDMIOT values (20, 1, 4, 'amet sapien dignissim vestibulum vestibulum ante ipsum primis in');
insert into STUDENT_PRZEDMIOT values (21, 20, 4, 'auctor sed tristique in tempus sit amet sem');
insert into STUDENT_PRZEDMIOT values (22, 4, 2, 'platea dictumst aliquam augue quam sollicitudin vitae');
insert into STUDENT_PRZEDMIOT values (23, 15, 3, 'accumsan tellus nisi eu orci mauris lacinia');
insert into STUDENT_PRZEDMIOT values (24, 10, 5, 'interdum venenatis turpis enim blandit mi in porttitor pede justo');
insert into STUDENT_PRZEDMIOT values (25, 5, 3, 'tristique fusce congue diam id ornare');
insert into STUDENT_PRZEDMIOT values (26, 10, 5, 'lectus aliquam sit amet diam in magna bibendum imperdiet');
insert into STUDENT_PRZEDMIOT values (27, 3, 5, 'sem praesent id massa id nisl venenatis');
insert into STUDENT_PRZEDMIOT values (28, 10, 5, 'praesent id massa id nisl venenatis lacinia aenean sit amet');
insert into STUDENT_PRZEDMIOT values (29, 10, 5, 'ut blandit non interdum in');
insert into STUDENT_PRZEDMIOT values (30, 2, 3, 'purus aliquet at feugiat non pretium quis');
insert into STUDENT_PRZEDMIOT values (31, 12, 3, 'mi pede malesuada in imperdiet et');
insert into STUDENT_PRZEDMIOT values (32, 13, 3, 'ipsum integer a nibh in quis justo maecenas rhoncus');
insert into STUDENT_PRZEDMIOT values (33, 16, 5, 'nullam varius nulla facilisi cras');
insert into STUDENT_PRZEDMIOT values (34, 16, 2, 'tempor convallis nulla neque libero convallis eget eleifend');
insert into STUDENT_PRZEDMIOT values (35, 12, 5, 'ultrices posuere cubilia curae mauris viverra diam vitae quam');
insert into STUDENT_PRZEDMIOT values (36, 9, 4, 'aliquet pulvinar sed nisl nunc rhoncus dui');
insert into STUDENT_PRZEDMIOT values (37, 3, 3, 'sem mauris laoreet ut rhoncus aliquet pulvinar sed');
insert into STUDENT_PRZEDMIOT values (38, 15, 3, 'morbi porttitor lorem id ligula suspendisse');
insert into STUDENT_PRZEDMIOT values (39, 1, 5, 'vulputate ut ultrices vel augue vestibulum ante ipsum primis');
insert into STUDENT_PRZEDMIOT values (40, 9, 3, 'velit eu est congue elementum in hac habitasse platea');
insert into STUDENT_PRZEDMIOT values (41, 11, 3, 'sed ante vivamus tortor duis mattis egestas metus aenean');
insert into STUDENT_PRZEDMIOT values (42, 13, 4, 'vestibulum ante ipsum primis in faucibus');
insert into STUDENT_PRZEDMIOT values (43, 9, 3, 'amet consectetuer adipiscing elit proin interdum mauris');
insert into STUDENT_PRZEDMIOT values (44, 8, 2, 'quisque porta volutpat erat quisque erat eros viverra');
insert into STUDENT_PRZEDMIOT values (45, 13, 2, 'at turpis a pede posuere nonummy integer');
insert into STUDENT_PRZEDMIOT values (46, 1, 4, 'donec quis orci eget orci vehicula condimentum');
insert into STUDENT_PRZEDMIOT values (47, 6, 2, 'nullam molestie nibh in lectus');
insert into STUDENT_PRZEDMIOT values (48, 10, 4, 'pellentesque quisque porta volutpat erat quisque erat eros viverra eget');
insert into STUDENT_PRZEDMIOT values (49, 9, 3, 'enim blandit mi in porttitor pede justo eu');
insert into STUDENT_PRZEDMIOT values (50, 13, 2, 'ipsum primis in faucibus orci luctus et ultrices');
insert into STUDENT_PRZEDMIOT values (51, 13, 2, 'lacus at turpis donec posuere metus vitae ipsum');
insert into STUDENT_PRZEDMIOT values (52, 13, 4, 'libero rutrum ac lobortis vel dapibus');
insert into STUDENT_PRZEDMIOT values (53, 12, 5, 'ante ipsum primis in faucibus');
insert into STUDENT_PRZEDMIOT values (54, 10, 3, 'habitasse platea dictumst etiam faucibus cursus urna ut tellus');
insert into STUDENT_PRZEDMIOT values (55, 10, 3, 'rhoncus aliquet pulvinar sed nisl');
insert into STUDENT_PRZEDMIOT values (56, 12, 2, 'velit nec nisi vulputate nonummy maecenas tincidunt lacus at');
insert into STUDENT_PRZEDMIOT values (57, 19, 4, 'bibendum morbi non quam nec dui luctus');
insert into STUDENT_PRZEDMIOT values (58, 11, 3, 'pede morbi porttitor lorem id ligula suspendisse ornare consequat');
insert into STUDENT_PRZEDMIOT values (59, 14, 5, 'cum sociis natoque penatibus et');
insert into STUDENT_PRZEDMIOT values (60, 17, 3, 'duis bibendum felis sed interdum venenatis turpis enim');
insert into STUDENT_PRZEDMIOT values (61, 1, 3, 'sit amet erat nulla tempus vivamus in felis');
insert into STUDENT_PRZEDMIOT values (62, 8, 5, 'lorem quisque ut erat curabitur gravida nisi at');
insert into STUDENT_PRZEDMIOT values (63, 12, 4, 'potenti in eleifend quam a');
insert into STUDENT_PRZEDMIOT values (64, 16, 3, 'nam ultrices libero non mattis pulvinar');
insert into STUDENT_PRZEDMIOT values (65, 20, 4, 'aenean sit amet justo morbi ut odio cras');
insert into STUDENT_PRZEDMIOT values (66, 15, 4, 'augue aliquam erat volutpat in congue etiam justo');
insert into STUDENT_PRZEDMIOT values (67, 15, 4, 'fusce congue diam id ornare imperdiet');
insert into STUDENT_PRZEDMIOT values (68, 3, 5, 'libero non mattis pulvinar nulla');
insert into STUDENT_PRZEDMIOT values (69, 14, 3, 'amet nulla quisque arcu libero');
insert into STUDENT_PRZEDMIOT values (70, 6, 4, 'congue eget semper rutrum nulla nunc purus');
insert into STUDENT_PRZEDMIOT values (71, 13, 3, 'pharetra magna ac consequat metus sapien');
insert into STUDENT_PRZEDMIOT values (72, 1, 2, 'ipsum primis in faucibus orci luctus et');
insert into STUDENT_PRZEDMIOT values (73, 5, 2, 'pellentesque ultrices phasellus id sapien');
insert into STUDENT_PRZEDMIOT values (74, 2, 3, 'in hac habitasse platea dictumst aliquam augue quam sollicitudin');
insert into STUDENT_PRZEDMIOT values (75, 19, 3, 'rhoncus sed vestibulum sit amet');
insert into STUDENT_PRZEDMIOT values (76, 1, 5, 'mus etiam vel augue vestibulum rutrum rutrum neque');
insert into STUDENT_PRZEDMIOT values (77, 3, 4, 'orci luctus et ultrices posuere');
insert into STUDENT_PRZEDMIOT values (78, 8, 5, 'morbi non lectus aliquam sit amet diam in');
insert into STUDENT_PRZEDMIOT values (79, 12, 3, 'aliquet maecenas leo odio condimentum id luctus');
insert into STUDENT_PRZEDMIOT values (80, 5, 3, 'sed vestibulum sit amet cursus id turpis integer');
insert into STUDENT_PRZEDMIOT values (81, 3, 4, 'augue vestibulum rutrum rutrum neque aenean auctor gravida');
insert into STUDENT_PRZEDMIOT values (82, 16, 2, 'quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt');
insert into STUDENT_PRZEDMIOT values (83, 11, 4, 'nisl duis ac nibh fusce lacus purus aliquet at feugiat');
insert into STUDENT_PRZEDMIOT values (84, 19, 4, 'vulputate ut ultrices vel augue vestibulum');
insert into STUDENT_PRZEDMIOT values (85, 12, 4, 'quisque arcu libero rutrum ac lobortis vel dapibus');
insert into STUDENT_PRZEDMIOT values (86, 19, 2, 'libero quis orci nullam molestie nibh in lectus pellentesque');
insert into STUDENT_PRZEDMIOT values (87, 13, 4, 'tempus vel pede morbi porttitor lorem id ligula suspendisse');
insert into STUDENT_PRZEDMIOT values (88, 8, 4, 'imperdiet nullam orci pede venenatis non sodales sed tincidunt');
insert into STUDENT_PRZEDMIOT values (89, 20, 3, 'odio justo sollicitudin ut suscipit a');
insert into STUDENT_PRZEDMIOT values (90, 8, 4, 'nisl duis bibendum felis sed');
insert into STUDENT_PRZEDMIOT values (91, 9, 4, 'odio donec vitae nisi nam ultrices libero');
insert into STUDENT_PRZEDMIOT values (92, 2, 5, 'orci pede venenatis non sodales sed tincidunt eu felis');
insert into STUDENT_PRZEDMIOT values (93, 6, 3, 'donec posuere metus vitae ipsum aliquam non mauris morbi non');
insert into STUDENT_PRZEDMIOT values (94, 19, 2, 'sollicitudin mi sit amet lobortis sapien sapien');
insert into STUDENT_PRZEDMIOT values (95, 9, 4, 'justo in blandit ultrices enim');
insert into STUDENT_PRZEDMIOT values (96, 17, 5, 'vivamus metus arcu adipiscing molestie hendrerit at');
insert into STUDENT_PRZEDMIOT values (97, 2, 2, 'a pede posuere nonummy integer non velit donec diam');
insert into STUDENT_PRZEDMIOT values (98, 3, 4, 'vestibulum ante ipsum primis in faucibus');
insert into STUDENT_PRZEDMIOT values (99, 19, 4, 'nonummy maecenas tincidunt lacus at velit');
insert into STUDENT_PRZEDMIOT values (100, 10, 5, 'id ornare imperdiet sapien urna pretium nisl ut');
insert into STUDENT_PRZEDMIOT values (101, 14, 5, 'et ultrices posuere cubilia curae nulla dapibus dolor');
insert into STUDENT_PRZEDMIOT values (102, 3, 5, 'vitae ipsum aliquam non mauris');
insert into STUDENT_PRZEDMIOT values (103, 12, 4, 'turpis enim blandit mi in porttitor pede justo eu massa');
insert into STUDENT_PRZEDMIOT values (104, 12, 4, 'eget rutrum at lorem integer');
insert into STUDENT_PRZEDMIOT values (105, 14, 2, 'phasellus in felis donec semper sapien');
insert into STUDENT_PRZEDMIOT values (106, 11, 4, 'quisque erat eros viverra eget congue eget semper rutrum nulla');
insert into STUDENT_PRZEDMIOT values (107, 10, 2, 'blandit lacinia erat vestibulum sed magna at');
insert into STUDENT_PRZEDMIOT values (108, 13, 4, 'sapien urna pretium nisl ut volutpat sapien arcu sed augue');
insert into STUDENT_PRZEDMIOT values (109, 10, 2, 'hac habitasse platea dictumst aliquam');
insert into STUDENT_PRZEDMIOT values (110, 6, 5, 'pretium iaculis justo in hac habitasse platea dictumst');
insert into STUDENT_PRZEDMIOT values (111, 5, 4, 'pellentesque ultrices phasellus id sapien in sapien iaculis congue');
insert into STUDENT_PRZEDMIOT values (112, 5, 3, 'et magnis dis parturient montes nascetur ridiculus mus etiam');
insert into STUDENT_PRZEDMIOT values (113, 14, 5, 'elementum in hac habitasse platea');
insert into STUDENT_PRZEDMIOT values (114, 10, 5, 'mauris eget massa tempor convallis nulla neque libero convallis');
insert into STUDENT_PRZEDMIOT values (115, 10, 5, 'quam pharetra magna ac consequat metus sapien ut nunc');
insert into STUDENT_PRZEDMIOT values (116, 7, 5, 'vestibulum ac est lacinia nisi');
insert into STUDENT_PRZEDMIOT values (117, 6, 4, 'quis justo maecenas rhoncus aliquam');
insert into STUDENT_PRZEDMIOT values (118, 20, 4, 'posuere nonummy integer non velit donec diam');
insert into STUDENT_PRZEDMIOT values (119, 14, 3, 'vel sem sed sagittis nam congue risus semper');
insert into STUDENT_PRZEDMIOT values (120, 10, 4, 'cum sociis natoque penatibus et magnis dis parturient montes nascetur');
insert into STUDENT_PRZEDMIOT values (121, 5, 4, 'suscipit nulla elit ac nulla sed vel enim');
insert into STUDENT_PRZEDMIOT values (122, 8, 4, 'sodales scelerisque mauris sit amet eros suspendisse');
insert into STUDENT_PRZEDMIOT values (123, 11, 5, 'elit ac nulla sed vel enim');
insert into STUDENT_PRZEDMIOT values (124, 5, 5, 'vulputate elementum nullam varius nulla facilisi cras non');
insert into STUDENT_PRZEDMIOT values (125, 19, 5, 'turpis eget elit sodales scelerisque mauris sit amet');
insert into STUDENT_PRZEDMIOT values (126, 15, 3, 'sed ante vivamus tortor duis mattis egestas metus');
insert into STUDENT_PRZEDMIOT values (127, 20, 4, 'in tempus sit amet sem fusce consequat');
insert into STUDENT_PRZEDMIOT values (128, 19, 5, 'sem fusce consequat nulla nisl nunc nisl duis bibendum felis');
insert into STUDENT_PRZEDMIOT values (129, 19, 2, 'quisque ut erat curabitur gravida nisi at');
insert into STUDENT_PRZEDMIOT values (130, 14, 5, 'libero ut massa volutpat convallis morbi odio odio elementum');
insert into STUDENT_PRZEDMIOT values (131, 17, 2, 'vehicula condimentum curabitur in libero ut massa');
insert into STUDENT_PRZEDMIOT values (132, 1, 4, 'odio elementum eu interdum eu tincidunt in');
insert into STUDENT_PRZEDMIOT values (133, 12, 4, 'diam vitae quam suspendisse potenti nullam porttitor lacus at turpis');
insert into STUDENT_PRZEDMIOT values (134, 10, 3, 'lobortis est phasellus sit amet erat');
insert into STUDENT_PRZEDMIOT values (135, 16, 5, 'gravida sem praesent id massa id');
insert into STUDENT_PRZEDMIOT values (136, 20, 5, 'ultricies eu nibh quisque id justo');
insert into STUDENT_PRZEDMIOT values (137, 14, 5, 'id turpis integer aliquet massa id lobortis convallis tortor');
insert into STUDENT_PRZEDMIOT values (138, 1, 5, 'amet consectetuer adipiscing elit proin interdum mauris non ligula');
insert into STUDENT_PRZEDMIOT values (139, 2, 2, 'id sapien in sapien iaculis congue vivamus metus arcu');
insert into STUDENT_PRZEDMIOT values (140, 6, 4, 'semper porta volutpat quam pede');
insert into STUDENT_PRZEDMIOT values (141, 13, 2, 'platea dictumst etiam faucibus cursus urna ut tellus');
insert into STUDENT_PRZEDMIOT values (142, 16, 4, 'sed tincidunt eu felis fusce');
insert into STUDENT_PRZEDMIOT values (143, 5, 2, 'ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent');
insert into STUDENT_PRZEDMIOT values (144, 8, 5, 'erat nulla tempus vivamus in');
insert into STUDENT_PRZEDMIOT values (145, 8, 4, 'orci nullam molestie nibh in lectus pellentesque at nulla suspendisse');
insert into STUDENT_PRZEDMIOT values (146, 13, 5, 'eu massa donec dapibus duis');
insert into STUDENT_PRZEDMIOT values (147, 9, 3, 'platea dictumst maecenas ut massa quis');
insert into STUDENT_PRZEDMIOT values (148, 20, 3, 'elementum nullam varius nulla facilisi');
insert into STUDENT_PRZEDMIOT values (149, 2, 3, 'sagittis dui vel nisl duis ac nibh fusce lacus');
insert into STUDENT_PRZEDMIOT values (150, 5, 4, 'accumsan tellus nisi eu orci mauris lacinia sapien');
insert into STUDENT_PRZEDMIOT values (151, 19, 3, 'magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum');
insert into STUDENT_PRZEDMIOT values (152, 4, 2, 'sapien dignissim vestibulum vestibulum ante');
insert into STUDENT_PRZEDMIOT values (153, 17, 2, 'dui maecenas tristique est et');
insert into STUDENT_PRZEDMIOT values (154, 14, 3, 'sit amet sem fusce consequat nulla nisl nunc');
insert into STUDENT_PRZEDMIOT values (155, 5, 5, 'lectus suspendisse potenti in eleifend quam a odio');
insert into STUDENT_PRZEDMIOT values (156, 4, 3, 'morbi odio odio elementum eu');
insert into STUDENT_PRZEDMIOT values (157, 12, 4, 'est risus auctor sed tristique in tempus');
insert into STUDENT_PRZEDMIOT values (158, 4, 2, 'nec condimentum neque sapien placerat');
insert into STUDENT_PRZEDMIOT values (159, 13, 4, 'felis sed lacus morbi sem mauris laoreet');
insert into STUDENT_PRZEDMIOT values (160, 14, 2, 'magnis dis parturient montes nascetur ridiculus mus etiam vel');
insert into STUDENT_PRZEDMIOT values (161, 15, 2, 'turpis nec euismod scelerisque quam');
insert into STUDENT_PRZEDMIOT values (162, 9, 4, 'amet justo morbi ut odio cras');
insert into STUDENT_PRZEDMIOT values (163, 5, 5, 'ac nibh fusce lacus purus aliquet at feugiat non');
insert into STUDENT_PRZEDMIOT values (164, 2, 4, 'nullam molestie nibh in lectus pellentesque at nulla suspendisse');
insert into STUDENT_PRZEDMIOT values (165, 9, 3, 'duis aliquam convallis nunc proin at turpis a');
insert into STUDENT_PRZEDMIOT values (166, 14, 3, 'sed lacus morbi sem mauris laoreet');
insert into STUDENT_PRZEDMIOT values (167, 10, 3, 'neque sapien placerat ante nulla');
insert into STUDENT_PRZEDMIOT values (168, 18, 4, 'turpis eget elit sodales scelerisque mauris sit amet eros');
insert into STUDENT_PRZEDMIOT values (169, 2, 2, 'nisi venenatis tristique fusce congue diam');
insert into STUDENT_PRZEDMIOT values (170, 18, 3, 'quis lectus suspendisse potenti in eleifend quam a odio in');
insert into STUDENT_PRZEDMIOT values (171, 16, 2, 'a nibh in quis justo maecenas rhoncus aliquam');
insert into STUDENT_PRZEDMIOT values (172, 20, 5, 'donec ut dolor morbi vel lectus in quam fringilla');
insert into STUDENT_PRZEDMIOT values (173, 17, 4, 'congue vivamus metus arcu adipiscing molestie hendrerit');
insert into STUDENT_PRZEDMIOT values (174, 7, 4, 'pede ullamcorper augue a suscipit nulla elit ac');
insert into STUDENT_PRZEDMIOT values (175, 19, 3, 'in lacus curabitur at ipsum ac tellus');
insert into STUDENT_PRZEDMIOT values (176, 15, 3, 'rutrum nulla nunc purus phasellus in');
insert into STUDENT_PRZEDMIOT values (177, 20, 2, 'elementum nullam varius nulla facilisi');
insert into STUDENT_PRZEDMIOT values (178, 13, 2, 'integer aliquet massa id lobortis convallis tortor risus dapibus augue');
insert into STUDENT_PRZEDMIOT values (179, 20, 3, 'morbi vestibulum velit id pretium iaculis diam erat fermentum');
insert into STUDENT_PRZEDMIOT values (180, 13, 5, 'ante vivamus tortor duis mattis egestas metus aenean fermentum');
insert into STUDENT_PRZEDMIOT values (181, 20, 2, 'et magnis dis parturient montes nascetur ridiculus');
insert into STUDENT_PRZEDMIOT values (182, 17, 2, 'praesent id massa id nisl venenatis lacinia aenean sit amet');
insert into STUDENT_PRZEDMIOT values (183, 13, 4, 'eget nunc donec quis orci eget orci vehicula condimentum');
insert into STUDENT_PRZEDMIOT values (184, 9, 5, 'sapien urna pretium nisl ut volutpat sapien arcu sed');
insert into STUDENT_PRZEDMIOT values (185, 7, 4, 'lorem quisque ut erat curabitur gravida nisi at nibh');
insert into STUDENT_PRZEDMIOT values (186, 10, 5, 'in felis donec semper sapien a libero nam dui');
insert into STUDENT_PRZEDMIOT values (187, 11, 2, 'id mauris vulputate elementum nullam');
insert into STUDENT_PRZEDMIOT values (188, 1, 5, 'morbi ut odio cras mi pede malesuada in imperdiet');
insert into STUDENT_PRZEDMIOT values (189, 20, 5, 'lorem ipsum dolor sit amet consectetuer adipiscing');
insert into STUDENT_PRZEDMIOT values (190, 5, 4, 'diam id ornare imperdiet sapien urna pretium nisl ut');
insert into STUDENT_PRZEDMIOT values (191, 20, 3, 'egestas metus aenean fermentum donec ut mauris eget massa');
insert into STUDENT_PRZEDMIOT values (192, 2, 5, 'orci nullam molestie nibh in lectus pellentesque at nulla suspendisse');
insert into STUDENT_PRZEDMIOT values (193, 1, 5, 'leo odio condimentum id luctus nec molestie sed justo pellentesque');
insert into STUDENT_PRZEDMIOT values (194, 16, 2, 'quam turpis adipiscing lorem vitae mattis nibh ligula nec');
insert into STUDENT_PRZEDMIOT values (195, 20, 3, 'quisque arcu libero rutrum ac lobortis vel dapibus at diam');
insert into STUDENT_PRZEDMIOT values (196, 15, 2, 'cras in purus eu magna vulputate luctus cum sociis');
insert into STUDENT_PRZEDMIOT values (197, 3, 4, 'lacus at velit vivamus vel nulla eget eros elementum');
insert into STUDENT_PRZEDMIOT values (198, 19, 5, 'bibendum morbi non quam nec dui luctus rutrum');
insert into STUDENT_PRZEDMIOT values (199, 5, 3, 'tincidunt eu felis fusce posuere felis sed lacus morbi');
insert into STUDENT_PRZEDMIOT values (200, 3, 3, 'nullam porttitor lacus at turpis donec posuere metus');
insert into STUDENT_PRZEDMIOT values (1, 1, 3, 'aenean fermentum donec ut mauris');
insert into STUDENT_PRZEDMIOT values (2, 17, 2, 'quis libero nullam sit amet turpis elementum');
insert into STUDENT_PRZEDMIOT values (3, 10, 2, 'curabitur convallis duis consequat dui nec nisi volutpat eleifend donec');
insert into STUDENT_PRZEDMIOT values (4, 14, 5, 'interdum in ante vestibulum ante ipsum primis');
insert into STUDENT_PRZEDMIOT values (5, 1, 2, 'et tempus semper est quam pharetra');
insert into STUDENT_PRZEDMIOT values (6, 3, 4, 'mi in porttitor pede justo eu massa donec dapibus');
insert into STUDENT_PRZEDMIOT values (7, 4, 5, 'non quam nec dui luctus rutrum nulla tellus in');
insert into STUDENT_PRZEDMIOT values (8, 18, 5, 'felis sed lacus morbi sem mauris laoreet ut rhoncus');
insert into STUDENT_PRZEDMIOT values (9, 1, 5, 'at dolor quis odio consequat varius integer ac leo pellentesque');
insert into STUDENT_PRZEDMIOT values (10, 8, 5, 'cubilia curae duis faucibus accumsan odio curabitur');
insert into STUDENT_PRZEDMIOT values (11, 6, 3, 'pretium iaculis justo in hac habitasse platea');
insert into STUDENT_PRZEDMIOT values (12, 2, 5, 'sodales sed tincidunt eu felis fusce');
insert into STUDENT_PRZEDMIOT values (13, 17, 5, 'lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar');
insert into STUDENT_PRZEDMIOT values (14, 5, 4, 'id mauris vulputate elementum nullam varius nulla facilisi cras non');
insert into STUDENT_PRZEDMIOT values (15, 3, 3, 'integer ac leo pellentesque ultrices mattis odio donec');
insert into STUDENT_PRZEDMIOT values (16, 2, 4, 'nisi volutpat eleifend donec ut dolor morbi vel lectus');
insert into STUDENT_PRZEDMIOT values (17, 11, 4, 'morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl');
insert into STUDENT_PRZEDMIOT values (18, 1, 5, 'arcu adipiscing molestie hendrerit at vulputate vitae');
insert into STUDENT_PRZEDMIOT values (19, 14, 3, 'cubilia curae mauris viverra diam vitae quam');
insert into STUDENT_PRZEDMIOT values (20, 19, 4, 'sollicitudin vitae consectetuer eget rutrum');
insert into STUDENT_PRZEDMIOT values (21, 6, 2, 'donec diam neque vestibulum eget vulputate ut');
insert into STUDENT_PRZEDMIOT values (22, 8, 4, 'massa id nisl venenatis lacinia');
insert into STUDENT_PRZEDMIOT values (23, 17, 5, 'ut ultrices vel augue vestibulum ante ipsum primis in faucibus');
insert into STUDENT_PRZEDMIOT values (24, 15, 3, 'rhoncus aliquam lacus morbi quis tortor id');
insert into STUDENT_PRZEDMIOT values (25, 9, 2, 'sapien dignissim vestibulum vestibulum ante');
insert into STUDENT_PRZEDMIOT values (26, 1, 2, 'turpis enim blandit mi in');
insert into STUDENT_PRZEDMIOT values (27, 19, 4, 'non mattis pulvinar nulla pede ullamcorper augue a suscipit');
insert into STUDENT_PRZEDMIOT values (28, 3, 5, 'cursus vestibulum proin eu mi nulla ac');
insert into STUDENT_PRZEDMIOT values (29, 18, 3, 'est et tempus semper est');
insert into STUDENT_PRZEDMIOT values (30, 19, 5, 'rutrum nulla nunc purus phasellus');
insert into STUDENT_PRZEDMIOT values (31, 17, 2, 'elit ac nulla sed vel enim');
insert into STUDENT_PRZEDMIOT values (32, 8, 5, 'sed augue aliquam erat volutpat in congue');
insert into STUDENT_PRZEDMIOT values (33, 14, 5, 'convallis duis consequat dui nec nisi volutpat eleifend donec');
insert into STUDENT_PRZEDMIOT values (34, 18, 3, 'lacus purus aliquet at feugiat non');
insert into STUDENT_PRZEDMIOT values (35, 5, 2, 'praesent id massa id nisl venenatis lacinia aenean sit amet');
insert into STUDENT_PRZEDMIOT values (36, 7, 2, 'mi sit amet lobortis sapien sapien');
insert into STUDENT_PRZEDMIOT values (37, 1, 5, 'etiam faucibus cursus urna ut tellus nulla');
insert into STUDENT_PRZEDMIOT values (38, 19, 5, 'aliquam quis turpis eget elit sodales scelerisque');
insert into STUDENT_PRZEDMIOT values (39, 18, 5, 'interdum venenatis turpis enim blandit');
insert into STUDENT_PRZEDMIOT values (40, 1, 5, 'purus aliquet at feugiat non pretium quis lectus suspendisse');
insert into STUDENT_PRZEDMIOT values (41, 11, 2, 'nulla sed vel enim sit amet nunc');
insert into STUDENT_PRZEDMIOT values (42, 3, 2, 'id nulla ultrices aliquet maecenas leo odio condimentum');
insert into STUDENT_PRZEDMIOT values (43, 12, 4, 'nunc purus phasellus in felis donec semper');
insert into STUDENT_PRZEDMIOT values (44, 2, 4, 'sapien ut nunc vestibulum ante ipsum primis in');
insert into STUDENT_PRZEDMIOT values (45, 7, 4, 'at nulla suspendisse potenti cras in purus');
insert into STUDENT_PRZEDMIOT values (46, 3, 3, 'lobortis sapien sapien non mi integer ac neque duis');
insert into STUDENT_PRZEDMIOT values (47, 2, 5, 'habitasse platea dictumst etiam faucibus cursus urna ut tellus');
insert into STUDENT_PRZEDMIOT values (48, 4, 3, 'in tempus sit amet sem');
insert into STUDENT_PRZEDMIOT values (49, 9, 3, 'nibh quisque id justo sit amet sapien dignissim');
insert into STUDENT_PRZEDMIOT values (50, 15, 4, 'eu tincidunt in leo maecenas');
insert into STUDENT_PRZEDMIOT values (51, 4, 3, 'urna ut tellus nulla ut erat id mauris vulputate');
insert into STUDENT_PRZEDMIOT values (52, 1, 4, 'sit amet cursus id turpis integer');
insert into STUDENT_PRZEDMIOT values (53, 15, 3, 'nam nulla integer pede justo lacinia eget');
insert into STUDENT_PRZEDMIOT values (54, 8, 3, 'lorem ipsum dolor sit amet consectetuer adipiscing');
insert into STUDENT_PRZEDMIOT values (55, 19, 4, 'ipsum dolor sit amet consectetuer adipiscing');
insert into STUDENT_PRZEDMIOT values (56, 2, 5, 'amet cursus id turpis integer');
insert into STUDENT_PRZEDMIOT values (57, 5, 4, 'dolor vel est donec odio justo sollicitudin ut');
insert into STUDENT_PRZEDMIOT values (58, 6, 3, 'id luctus nec molestie sed justo pellentesque viverra pede');
insert into STUDENT_PRZEDMIOT values (59, 4, 3, 'maecenas ut massa quis augue luctus tincidunt nulla mollis');
insert into STUDENT_PRZEDMIOT values (60, 18, 5, 'tristique est et tempus semper est');
insert into STUDENT_PRZEDMIOT values (61, 19, 2, 'dictumst etiam faucibus cursus urna ut tellus');
insert into STUDENT_PRZEDMIOT values (62, 15, 4, 'nulla sed vel enim sit amet nunc viverra dapibus nulla');
insert into STUDENT_PRZEDMIOT values (63, 13, 3, 'porta volutpat erat quisque erat eros');
insert into STUDENT_PRZEDMIOT values (64, 18, 4, 'massa donec dapibus duis at');
insert into STUDENT_PRZEDMIOT values (65, 18, 5, 'quam nec dui luctus rutrum');
insert into STUDENT_PRZEDMIOT values (66, 16, 4, 'in imperdiet et commodo vulputate justo in blandit ultrices');
insert into STUDENT_PRZEDMIOT values (67, 18, 4, 'id ligula suspendisse ornare consequat lectus in');
insert into STUDENT_PRZEDMIOT values (68, 12, 4, 'mi in porttitor pede justo eu massa donec');
insert into STUDENT_PRZEDMIOT values (69, 11, 2, 'mi nulla ac enim in tempor');
insert into STUDENT_PRZEDMIOT values (70, 14, 3, 'sit amet cursus id turpis');
insert into STUDENT_PRZEDMIOT values (71, 14, 4, 'nulla pede ullamcorper augue a suscipit nulla elit ac');
insert into STUDENT_PRZEDMIOT values (72, 20, 2, 'pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus');
insert into STUDENT_PRZEDMIOT values (73, 2, 3, 'habitasse platea dictumst maecenas ut massa quis');
insert into STUDENT_PRZEDMIOT values (74, 11, 5, 'curabitur gravida nisi at nibh in hac');
insert into STUDENT_PRZEDMIOT values (75, 2, 2, 'semper est quam pharetra magna ac consequat metus sapien');
insert into STUDENT_PRZEDMIOT values (76, 3, 3, 'orci luctus et ultrices posuere cubilia curae duis faucibus accumsan');
insert into STUDENT_PRZEDMIOT values (77, 14, 3, 'ultrices vel augue vestibulum ante ipsum primis');
insert into STUDENT_PRZEDMIOT values (78, 15, 5, 'nascetur ridiculus mus vivamus vestibulum');
insert into STUDENT_PRZEDMIOT values (79, 14, 2, 'orci luctus et ultrices posuere cubilia curae duis faucibus accumsan');
insert into STUDENT_PRZEDMIOT values (80, 7, 2, 'quis lectus suspendisse potenti in eleifend quam');
insert into STUDENT_PRZEDMIOT values (81, 20, 3, 'consequat ut nulla sed accumsan felis ut at dolor');
insert into STUDENT_PRZEDMIOT values (82, 2, 2, 'pharetra magna ac consequat metus sapien ut nunc');
insert into STUDENT_PRZEDMIOT values (83, 15, 5, 'ut ultrices vel augue vestibulum ante ipsum primis in');
insert into STUDENT_PRZEDMIOT values (84, 20, 5, 'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus');
insert into STUDENT_PRZEDMIOT values (85, 14, 2, 'morbi ut odio cras mi pede malesuada');
insert into STUDENT_PRZEDMIOT values (86, 20, 2, 'sagittis nam congue risus semper porta volutpat');
insert into STUDENT_PRZEDMIOT values (87, 10, 2, 'luctus tincidunt nulla mollis molestie lorem quisque ut');
insert into STUDENT_PRZEDMIOT values (88, 20, 4, 'ipsum dolor sit amet consectetuer');
insert into STUDENT_PRZEDMIOT values (89, 8, 4, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia');
insert into STUDENT_PRZEDMIOT values (90, 6, 3, 'rhoncus mauris enim leo rhoncus sed');
insert into STUDENT_PRZEDMIOT values (91, 16, 5, 'proin eu mi nulla ac enim in tempor turpis nec');
insert into STUDENT_PRZEDMIOT values (92, 17, 4, 'suspendisse ornare consequat lectus in est risus auctor sed');
insert into STUDENT_PRZEDMIOT values (93, 10, 3, 'mattis nibh ligula nec sem duis');
insert into STUDENT_PRZEDMIOT values (94, 5, 3, 'nisi eu orci mauris lacinia sapien quis libero');
insert into STUDENT_PRZEDMIOT values (95, 15, 4, 'at nulla suspendisse potenti cras in purus eu magna');
insert into STUDENT_PRZEDMIOT values (96, 13, 4, 'eget tempus vel pede morbi porttitor');
insert into STUDENT_PRZEDMIOT values (97, 6, 2, 'bibendum felis sed interdum venenatis turpis enim');
insert into STUDENT_PRZEDMIOT values (98, 8, 2, 'metus vitae ipsum aliquam non mauris morbi non lectus aliquam');
insert into STUDENT_PRZEDMIOT values (99, 4, 3, 'sapien arcu sed augue aliquam erat');
insert into STUDENT_PRZEDMIOT values (100, 10, 3, 'erat volutpat in congue etiam justo etiam pretium');
insert into STUDENT_PRZEDMIOT values (101, 8, 2, 'cubilia curae mauris viverra diam vitae');
insert into STUDENT_PRZEDMIOT values (102, 11, 2, 'rhoncus aliquet pulvinar sed nisl');
insert into STUDENT_PRZEDMIOT values (103, 19, 2, 'posuere metus vitae ipsum aliquam non');
insert into STUDENT_PRZEDMIOT values (104, 16, 2, 'eleifend donec ut dolor morbi vel lectus in');
insert into STUDENT_PRZEDMIOT values (105, 9, 5, 'potenti nullam porttitor lacus at turpis donec posuere metus vitae');
insert into STUDENT_PRZEDMIOT values (106, 3, 4, 'lobortis est phasellus sit amet');
insert into STUDENT_PRZEDMIOT values (107, 5, 4, 'augue vel accumsan tellus nisi eu orci mauris lacinia');
insert into STUDENT_PRZEDMIOT values (108, 16, 2, 'ultrices erat tortor sollicitudin mi sit amet lobortis');
insert into STUDENT_PRZEDMIOT values (109, 16, 5, 'odio in hac habitasse platea dictumst');
insert into STUDENT_PRZEDMIOT values (110, 3, 2, 'ipsum dolor sit amet consectetuer adipiscing');
insert into STUDENT_PRZEDMIOT values (111, 13, 4, 'vulputate elementum nullam varius nulla');
insert into STUDENT_PRZEDMIOT values (112, 13, 2, 'enim lorem ipsum dolor sit amet consectetuer adipiscing elit');
insert into STUDENT_PRZEDMIOT values (113, 20, 4, 'integer pede justo lacinia eget tincidunt eget');
insert into STUDENT_PRZEDMIOT values (114, 14, 4, 'sed magna at nunc commodo placerat praesent blandit nam nulla');
insert into STUDENT_PRZEDMIOT values (115, 2, 3, 'nulla facilisi cras non velit nec nisi vulputate nonummy maecenas');
insert into STUDENT_PRZEDMIOT values (116, 9, 4, 'id pretium iaculis diam erat fermentum justo nec condimentum neque');
insert into STUDENT_PRZEDMIOT values (117, 16, 3, 'odio consequat varius integer ac leo pellentesque ultrices mattis');
insert into STUDENT_PRZEDMIOT values (118, 2, 4, 'proin eu mi nulla ac enim in');
insert into STUDENT_PRZEDMIOT values (119, 19, 3, 'luctus rutrum nulla tellus in');
insert into STUDENT_PRZEDMIOT values (120, 18, 2, 'magnis dis parturient montes nascetur ridiculus mus etiam vel');
insert into STUDENT_PRZEDMIOT values (121, 13, 3, 'odio cras mi pede malesuada in imperdiet et commodo vulputate');
insert into STUDENT_PRZEDMIOT values (122, 2, 5, 'ac diam cras pellentesque volutpat dui maecenas tristique est');
insert into STUDENT_PRZEDMIOT values (123, 11, 4, 'a nibh in quis justo maecenas rhoncus aliquam lacus');
insert into STUDENT_PRZEDMIOT values (124, 19, 4, 'habitasse platea dictumst etiam faucibus cursus');
insert into STUDENT_PRZEDMIOT values (125, 20, 2, 'vel nisl duis ac nibh fusce');
insert into STUDENT_PRZEDMIOT values (126, 10, 2, 'at velit eu est congue elementum in');
insert into STUDENT_PRZEDMIOT values (127, 5, 2, 'pede justo eu massa donec');
insert into STUDENT_PRZEDMIOT values (128, 12, 4, 'consequat morbi a ipsum integer a nibh');
insert into STUDENT_PRZEDMIOT values (129, 7, 4, 'sed tincidunt eu felis fusce posuere felis sed');
insert into STUDENT_PRZEDMIOT values (130, 2, 5, 'bibendum felis sed interdum venenatis turpis enim blandit mi in');
insert into STUDENT_PRZEDMIOT values (131, 16, 5, 'et ultrices posuere cubilia curae mauris viverra diam');
insert into STUDENT_PRZEDMIOT values (132, 6, 4, 'elit ac nulla sed vel enim');
insert into STUDENT_PRZEDMIOT values (133, 8, 5, 'ut rhoncus aliquet pulvinar sed nisl nunc rhoncus');
insert into STUDENT_PRZEDMIOT values (134, 7, 5, 'viverra diam vitae quam suspendisse potenti nullam porttitor lacus');
insert into STUDENT_PRZEDMIOT values (135, 2, 5, 'natoque penatibus et magnis dis parturient montes nascetur');
insert into STUDENT_PRZEDMIOT values (136, 14, 2, 'lectus pellentesque eget nunc donec quis orci eget orci');
insert into STUDENT_PRZEDMIOT values (137, 5, 3, 'nec nisi volutpat eleifend donec ut dolor');
insert into STUDENT_PRZEDMIOT values (138, 11, 2, 'orci pede venenatis non sodales sed');
insert into STUDENT_PRZEDMIOT values (139, 16, 3, 'elementum nullam varius nulla facilisi cras non velit nec');
insert into STUDENT_PRZEDMIOT values (140, 2, 5, 'luctus cum sociis natoque penatibus et magnis dis parturient');
insert into STUDENT_PRZEDMIOT values (141, 12, 3, 'vel pede morbi porttitor lorem');
insert into STUDENT_PRZEDMIOT values (142, 1, 2, 'amet cursus id turpis integer');
insert into STUDENT_PRZEDMIOT values (143, 12, 5, 'tincidunt in leo maecenas pulvinar lobortis est phasellus');
insert into STUDENT_PRZEDMIOT values (144, 20, 5, 'ut massa quis augue luctus tincidunt nulla');
insert into STUDENT_PRZEDMIOT values (145, 6, 3, 'lacus curabitur at ipsum ac tellus');
insert into STUDENT_PRZEDMIOT values (146, 10, 5, 'ut volutpat sapien arcu sed augue');
insert into STUDENT_PRZEDMIOT values (147, 16, 2, 'suspendisse potenti in eleifend quam a odio in hac habitasse');
insert into STUDENT_PRZEDMIOT values (148, 20, 4, 'elementum eu interdum eu tincidunt in leo maecenas');
insert into STUDENT_PRZEDMIOT values (149, 10, 2, 'suscipit nulla elit ac nulla');
insert into STUDENT_PRZEDMIOT values (150, 11, 3, 'pede ac diam cras pellentesque volutpat dui maecenas tristique');
insert into STUDENT_PRZEDMIOT values (151, 17, 2, 'sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in');
insert into STUDENT_PRZEDMIOT values (152, 3, 3, 'dolor vel est donec odio justo sollicitudin');
insert into STUDENT_PRZEDMIOT values (153, 20, 2, 'lectus pellentesque at nulla suspendisse potenti cras');
insert into STUDENT_PRZEDMIOT values (154, 2, 5, 'leo rhoncus sed vestibulum sit amet cursus id turpis');
insert into STUDENT_PRZEDMIOT values (155, 8, 5, 'faucibus cursus urna ut tellus nulla ut');
insert into STUDENT_PRZEDMIOT values (156, 2, 4, 'libero convallis eget eleifend luctus ultricies eu nibh quisque');
insert into STUDENT_PRZEDMIOT values (157, 10, 3, 'nec molestie sed justo pellentesque viverra pede ac diam cras');
insert into STUDENT_PRZEDMIOT values (158, 1, 3, 'rhoncus mauris enim leo rhoncus sed vestibulum sit amet');
insert into STUDENT_PRZEDMIOT values (159, 2, 3, 'mi sit amet lobortis sapien sapien non');
insert into STUDENT_PRZEDMIOT values (160, 20, 4, 'hac habitasse platea dictumst aliquam');
insert into STUDENT_PRZEDMIOT values (161, 10, 5, 'in faucibus orci luctus et ultrices posuere');
insert into STUDENT_PRZEDMIOT values (162, 7, 4, 'mauris ullamcorper purus sit amet nulla quisque');
insert into STUDENT_PRZEDMIOT values (163, 1, 3, 'vulputate ut ultrices vel augue vestibulum ante');
insert into STUDENT_PRZEDMIOT values (164, 1, 4, 'tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet');
insert into STUDENT_PRZEDMIOT values (165, 4, 2, 'justo pellentesque viverra pede ac diam cras');
insert into STUDENT_PRZEDMIOT values (166, 19, 4, 'quisque arcu libero rutrum ac lobortis');
insert into STUDENT_PRZEDMIOT values (167, 8, 5, 'vel pede morbi porttitor lorem id ligula suspendisse ornare');
insert into STUDENT_PRZEDMIOT values (168, 14, 3, 'eleifend pede libero quis orci');
insert into STUDENT_PRZEDMIOT values (169, 10, 2, 'in hac habitasse platea dictumst');
insert into STUDENT_PRZEDMIOT values (170, 8, 3, 'ultrices enim lorem ipsum dolor sit amet consectetuer');
insert into STUDENT_PRZEDMIOT values (171, 7, 5, 'morbi odio odio elementum eu interdum eu tincidunt in leo');
insert into STUDENT_PRZEDMIOT values (172, 14, 4, 'lobortis est phasellus sit amet erat nulla tempus vivamus');
insert into STUDENT_PRZEDMIOT values (173, 7, 5, 'platea dictumst morbi vestibulum velit id');
insert into STUDENT_PRZEDMIOT values (174, 11, 5, 'non velit donec diam neque');
insert into STUDENT_PRZEDMIOT values (175, 11, 2, 'duis faucibus accumsan odio curabitur convallis');
insert into STUDENT_PRZEDMIOT values (176, 12, 2, 'leo rhoncus sed vestibulum sit amet cursus id turpis integer');
insert into STUDENT_PRZEDMIOT values (177, 2, 2, 'tellus in sagittis dui vel nisl duis ac nibh fusce');
insert into STUDENT_PRZEDMIOT values (178, 14, 4, 'blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing');
insert into STUDENT_PRZEDMIOT values (179, 3, 2, 'montes nascetur ridiculus mus vivamus vestibulum sagittis sapien');
insert into STUDENT_PRZEDMIOT values (180, 7, 5, 'in leo maecenas pulvinar lobortis est phasellus sit');
insert into STUDENT_PRZEDMIOT values (181, 2, 3, 'erat tortor sollicitudin mi sit amet lobortis');
insert into STUDENT_PRZEDMIOT values (182, 8, 2, 'enim sit amet nunc viverra');
insert into STUDENT_PRZEDMIOT values (183, 4, 4, 'mauris non ligula pellentesque ultrices phasellus id sapien in sapien');
insert into STUDENT_PRZEDMIOT values (184, 1, 2, 'lacinia nisi venenatis tristique fusce congue diam');
insert into STUDENT_PRZEDMIOT values (185, 16, 3, 'faucibus orci luctus et ultrices posuere cubilia');
insert into STUDENT_PRZEDMIOT values (186, 6, 4, 'nam nulla integer pede justo lacinia eget tincidunt');
insert into STUDENT_PRZEDMIOT values (187, 13, 3, 'in tempus sit amet sem fusce consequat');
insert into STUDENT_PRZEDMIOT values (188, 11, 4, 'porttitor pede justo eu massa donec');
insert into STUDENT_PRZEDMIOT values (189, 1, 5, 'non velit donec diam neque');
insert into STUDENT_PRZEDMIOT values (190, 9, 3, 'odio porttitor id consequat in consequat');
insert into STUDENT_PRZEDMIOT values (191, 16, 4, 'ante ipsum primis in faucibus orci luctus');
insert into STUDENT_PRZEDMIOT values (192, 13, 5, 'lacus at velit vivamus vel nulla');
insert into STUDENT_PRZEDMIOT values (193, 7, 2, 'nunc rhoncus dui vel sem sed sagittis nam congue');
insert into STUDENT_PRZEDMIOT values (194, 20, 5, 'sollicitudin mi sit amet lobortis sapien sapien');
insert into STUDENT_PRZEDMIOT values (195, 16, 4, 'donec dapibus duis at velit eu');
insert into STUDENT_PRZEDMIOT values (196, 6, 5, 'libero ut massa volutpat convallis');
insert into STUDENT_PRZEDMIOT values (197, 7, 2, 'ut odio cras mi pede malesuada');
insert into STUDENT_PRZEDMIOT values (198, 6, 4, 'donec quis orci eget orci');
insert into STUDENT_PRZEDMIOT values (199, 7, 5, 'iaculis justo in hac habitasse platea dictumst etiam faucibus cursus');
insert into STUDENT_PRZEDMIOT values (200, 2, 2, 'quam sapien varius ut blandit non interdum in ante vestibulum');
insert into STUDENT_PRZEDMIOT values (1, 6, 5, 'nulla eget eros elementum pellentesque quisque porta volutpat');
insert into STUDENT_PRZEDMIOT values (2, 2, 3, 'sit amet cursus id turpis');
insert into STUDENT_PRZEDMIOT values (3, 18, 5, 'primis in faucibus orci luctus et ultrices posuere cubilia curae');
insert into STUDENT_PRZEDMIOT values (4, 19, 3, 'ut erat id mauris vulputate elementum nullam varius nulla');
insert into STUDENT_PRZEDMIOT values (5, 7, 5, 'mauris viverra diam vitae quam suspendisse potenti nullam');
insert into STUDENT_PRZEDMIOT values (6, 17, 2, 'non lectus aliquam sit amet diam in magna bibendum imperdiet');
insert into STUDENT_PRZEDMIOT values (7, 16, 5, 'vitae consectetuer eget rutrum at lorem integer');
insert into STUDENT_PRZEDMIOT values (8, 5, 5, 'leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices');
insert into STUDENT_PRZEDMIOT values (9, 3, 4, 'in tempus sit amet sem');
insert into STUDENT_PRZEDMIOT values (10, 15, 5, 'dictumst maecenas ut massa quis');
insert into STUDENT_PRZEDMIOT values (11, 11, 2, 'tristique fusce congue diam id ornare imperdiet');
insert into STUDENT_PRZEDMIOT values (12, 6, 2, 'donec odio justo sollicitudin ut');
insert into STUDENT_PRZEDMIOT values (13, 11, 2, 'lobortis ligula sit amet eleifend pede libero quis orci nullam');
insert into STUDENT_PRZEDMIOT values (14, 10, 5, 'id turpis integer aliquet massa');
insert into STUDENT_PRZEDMIOT values (15, 18, 2, 'vestibulum ante ipsum primis in faucibus');
insert into STUDENT_PRZEDMIOT values (16, 19, 2, 'nullam orci pede venenatis non sodales sed tincidunt eu');
insert into STUDENT_PRZEDMIOT values (17, 8, 2, 'ut rhoncus aliquet pulvinar sed');
insert into STUDENT_PRZEDMIOT values (18, 20, 4, 'elementum pellentesque quisque porta volutpat erat quisque erat eros viverra');
insert into STUDENT_PRZEDMIOT values (19, 10, 5, 'ut massa quis augue luctus');
insert into STUDENT_PRZEDMIOT values (20, 18, 5, 'sollicitudin mi sit amet lobortis');
insert into STUDENT_PRZEDMIOT values (21, 14, 4, 'vel dapibus at diam nam tristique tortor');
insert into STUDENT_PRZEDMIOT values (22, 9, 4, 'sociis natoque penatibus et magnis dis parturient');
insert into STUDENT_PRZEDMIOT values (23, 5, 2, 'justo pellentesque viverra pede ac diam cras');
insert into STUDENT_PRZEDMIOT values (24, 8, 3, 'sed justo pellentesque viverra pede ac');
insert into STUDENT_PRZEDMIOT values (25, 18, 2, 'penatibus et magnis dis parturient montes nascetur');
insert into STUDENT_PRZEDMIOT values (26, 13, 5, 'justo maecenas rhoncus aliquam lacus');
insert into STUDENT_PRZEDMIOT values (27, 15, 2, 'arcu sed augue aliquam erat volutpat in congue');
insert into STUDENT_PRZEDMIOT values (28, 15, 2, 'in quis justo maecenas rhoncus aliquam');
insert into STUDENT_PRZEDMIOT values (29, 19, 2, 'id ligula suspendisse ornare consequat lectus in est risus auctor');
insert into STUDENT_PRZEDMIOT values (30, 7, 5, 'eget tincidunt eget tempus vel pede morbi');
insert into STUDENT_PRZEDMIOT values (31, 14, 4, 'amet consectetuer adipiscing elit proin');
insert into STUDENT_PRZEDMIOT values (32, 16, 5, 'luctus tincidunt nulla mollis molestie lorem quisque ut erat');
insert into STUDENT_PRZEDMIOT values (33, 18, 3, 'duis mattis egestas metus aenean fermentum donec ut mauris');
insert into STUDENT_PRZEDMIOT values (34, 14, 2, 'phasellus in felis donec semper sapien');
insert into STUDENT_PRZEDMIOT values (35, 12, 4, 'donec ut mauris eget massa');
insert into STUDENT_PRZEDMIOT values (36, 18, 5, 'rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet');
insert into STUDENT_PRZEDMIOT values (37, 13, 3, 'lobortis est phasellus sit amet erat');
insert into STUDENT_PRZEDMIOT values (38, 13, 3, 'sed vel enim sit amet nunc viverra dapibus');
insert into STUDENT_PRZEDMIOT values (39, 20, 5, 'ornare consequat lectus in est');
insert into STUDENT_PRZEDMIOT values (40, 8, 2, 'turpis adipiscing lorem vitae mattis nibh ligula nec sem duis');
insert into STUDENT_PRZEDMIOT values (41, 19, 5, 'lorem quisque ut erat curabitur gravida nisi');
insert into STUDENT_PRZEDMIOT values (42, 14, 5, 'vel ipsum praesent blandit lacinia');
insert into STUDENT_PRZEDMIOT values (43, 2, 3, 'aliquet ultrices erat tortor sollicitudin mi sit amet lobortis');
insert into STUDENT_PRZEDMIOT values (44, 13, 4, 'in consequat ut nulla sed accumsan felis ut');
insert into STUDENT_PRZEDMIOT values (45, 15, 2, 'eu nibh quisque id justo');
insert into STUDENT_PRZEDMIOT values (46, 8, 4, 'pulvinar lobortis est phasellus sit amet');
insert into STUDENT_PRZEDMIOT values (47, 9, 3, 'aliquam non mauris morbi non');
insert into STUDENT_PRZEDMIOT values (48, 14, 4, 'libero quis orci nullam molestie nibh in lectus pellentesque at');
insert into STUDENT_PRZEDMIOT values (49, 7, 4, 'eu magna vulputate luctus cum sociis');
insert into STUDENT_PRZEDMIOT values (50, 2, 2, 'id luctus nec molestie sed justo pellentesque viverra pede ac');
insert into STUDENT_PRZEDMIOT values (51, 13, 3, 'luctus et ultrices posuere cubilia');
insert into STUDENT_PRZEDMIOT values (52, 6, 4, 'proin leo odio porttitor id consequat in consequat ut nulla');
insert into STUDENT_PRZEDMIOT values (53, 13, 4, 'in quam fringilla rhoncus mauris enim leo rhoncus sed');
insert into STUDENT_PRZEDMIOT values (54, 3, 4, 'ipsum praesent blandit lacinia erat');
insert into STUDENT_PRZEDMIOT values (55, 8, 5, 'in eleifend quam a odio in hac habitasse platea');
insert into STUDENT_PRZEDMIOT values (56, 8, 5, 'turpis adipiscing lorem vitae mattis nibh ligula nec sem duis');
insert into STUDENT_PRZEDMIOT values (57, 11, 3, 'suscipit a feugiat et eros vestibulum ac est');
insert into STUDENT_PRZEDMIOT values (58, 5, 5, 'est donec odio justo sollicitudin ut suscipit a feugiat et');
insert into STUDENT_PRZEDMIOT values (59, 3, 5, 'leo maecenas pulvinar lobortis est');
insert into STUDENT_PRZEDMIOT values (60, 15, 4, 'ante ipsum primis in faucibus orci luctus');
insert into STUDENT_PRZEDMIOT values (61, 10, 2, 'mi sit amet lobortis sapien sapien non mi integer ac');
insert into STUDENT_PRZEDMIOT values (62, 4, 2, 'pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas');
insert into STUDENT_PRZEDMIOT values (63, 5, 4, 'quam sapien varius ut blandit non interdum in ante vestibulum');
insert into STUDENT_PRZEDMIOT values (64, 18, 5, 'eu massa donec dapibus duis at velit eu');
insert into STUDENT_PRZEDMIOT values (65, 15, 4, 'maecenas ut massa quis augue luctus tincidunt nulla mollis');
insert into STUDENT_PRZEDMIOT values (66, 10, 4, 'curae donec pharetra magna vestibulum aliquet ultrices erat tortor');
insert into STUDENT_PRZEDMIOT values (67, 1, 5, 'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus');
insert into STUDENT_PRZEDMIOT values (68, 19, 2, 'accumsan felis ut at dolor quis odio consequat varius');
insert into STUDENT_PRZEDMIOT values (69, 20, 3, 'sapien cum sociis natoque penatibus et magnis dis');
insert into STUDENT_PRZEDMIOT values (70, 18, 5, 'odio in hac habitasse platea dictumst maecenas ut massa');
insert into STUDENT_PRZEDMIOT values (71, 14, 5, 'nulla eget eros elementum pellentesque quisque porta volutpat erat');
insert into STUDENT_PRZEDMIOT values (72, 11, 2, 'curabitur convallis duis consequat dui nec');
insert into STUDENT_PRZEDMIOT values (73, 9, 2, 'convallis nulla neque libero convallis eget eleifend luctus ultricies');
insert into STUDENT_PRZEDMIOT values (74, 16, 4, 'sit amet eleifend pede libero quis orci nullam molestie nibh');
insert into STUDENT_PRZEDMIOT values (75, 15, 2, 'bibendum felis sed interdum venenatis turpis enim');
insert into STUDENT_PRZEDMIOT values (76, 17, 3, 'non mi integer ac neque duis bibendum morbi non');
insert into STUDENT_PRZEDMIOT values (77, 7, 2, 'duis consequat dui nec nisi volutpat');
insert into STUDENT_PRZEDMIOT values (78, 6, 5, 'eu felis fusce posuere felis sed lacus morbi sem mauris');
insert into STUDENT_PRZEDMIOT values (79, 15, 2, 'diam neque vestibulum eget vulputate ut ultrices vel');
insert into STUDENT_PRZEDMIOT values (80, 19, 3, 'dictumst maecenas ut massa quis augue luctus tincidunt nulla');
insert into STUDENT_PRZEDMIOT values (81, 2, 5, 'tempus semper est quam pharetra magna');
insert into STUDENT_PRZEDMIOT values (82, 8, 4, 'turpis nec euismod scelerisque quam turpis adipiscing lorem');
insert into STUDENT_PRZEDMIOT values (83, 7, 3, 'penatibus et magnis dis parturient montes nascetur ridiculus mus');
insert into STUDENT_PRZEDMIOT values (84, 10, 2, 'blandit ultrices enim lorem ipsum dolor sit amet');
insert into STUDENT_PRZEDMIOT values (85, 16, 3, 'consequat varius integer ac leo pellentesque ultrices mattis odio donec');
insert into STUDENT_PRZEDMIOT values (86, 12, 5, 'quisque porta volutpat erat quisque erat eros viverra');
insert into STUDENT_PRZEDMIOT values (87, 6, 4, 'at lorem integer tincidunt ante vel ipsum praesent blandit lacinia');
insert into STUDENT_PRZEDMIOT values (88, 3, 5, 'rhoncus sed vestibulum sit amet cursus id turpis');
insert into STUDENT_PRZEDMIOT values (89, 18, 2, 'orci luctus et ultrices posuere cubilia');
insert into STUDENT_PRZEDMIOT values (90, 19, 2, 'purus aliquet at feugiat non pretium quis lectus');
insert into STUDENT_PRZEDMIOT values (91, 20, 5, 'integer non velit donec diam neque vestibulum eget vulputate');
insert into STUDENT_PRZEDMIOT values (92, 1, 2, 'in hac habitasse platea dictumst morbi vestibulum velit id');
insert into STUDENT_PRZEDMIOT values (93, 13, 3, 'volutpat convallis morbi odio odio elementum eu');
insert into STUDENT_PRZEDMIOT values (94, 14, 4, 'platea dictumst morbi vestibulum velit id pretium iaculis diam erat');
insert into STUDENT_PRZEDMIOT values (95, 3, 3, 'dui nec nisi volutpat eleifend');
insert into STUDENT_PRZEDMIOT values (96, 14, 5, 'condimentum curabitur in libero ut massa volutpat');
insert into STUDENT_PRZEDMIOT values (97, 2, 4, 'elit proin risus praesent lectus vestibulum quam sapien');
insert into STUDENT_PRZEDMIOT values (98, 14, 4, 'congue eget semper rutrum nulla nunc purus phasellus in felis');
insert into STUDENT_PRZEDMIOT values (99, 2, 4, 'magnis dis parturient montes nascetur ridiculus');
insert into STUDENT_PRZEDMIOT values (100, 19, 3, 'justo aliquam quis turpis eget elit sodales scelerisque mauris');
insert into STUDENT_PRZEDMIOT values (101, 4, 4, 'penatibus et magnis dis parturient');
insert into STUDENT_PRZEDMIOT values (102, 18, 2, 'nulla ut erat id mauris vulputate elementum');
insert into STUDENT_PRZEDMIOT values (103, 8, 2, 'eleifend donec ut dolor morbi vel lectus in');
insert into STUDENT_PRZEDMIOT values (104, 14, 5, 'volutpat eleifend donec ut dolor morbi vel lectus in');
insert into STUDENT_PRZEDMIOT values (105, 2, 4, 'quisque arcu libero rutrum ac');
insert into STUDENT_PRZEDMIOT values (106, 7, 5, 'a suscipit nulla elit ac nulla sed vel enim sit');
insert into STUDENT_PRZEDMIOT values (107, 4, 5, 'et magnis dis parturient montes nascetur ridiculus');
insert into STUDENT_PRZEDMIOT values (108, 8, 3, 'elit sodales scelerisque mauris sit amet eros');
insert into STUDENT_PRZEDMIOT values (109, 7, 3, 'aliquet maecenas leo odio condimentum id luctus nec molestie');
insert into STUDENT_PRZEDMIOT values (110, 6, 3, 'sit amet consectetuer adipiscing elit proin risus praesent');
insert into STUDENT_PRZEDMIOT values (111, 14, 2, 'mi integer ac neque duis bibendum morbi non quam nec');
insert into STUDENT_PRZEDMIOT values (112, 11, 4, 'nisi volutpat eleifend donec ut dolor');
insert into STUDENT_PRZEDMIOT values (113, 6, 3, 'proin leo odio porttitor id consequat in');
insert into STUDENT_PRZEDMIOT values (114, 12, 5, 'ultrices erat tortor sollicitudin mi');
insert into STUDENT_PRZEDMIOT values (115, 19, 3, 'in purus eu magna vulputate luctus cum');
insert into STUDENT_PRZEDMIOT values (116, 20, 2, 'consequat lectus in est risus auctor sed tristique');
insert into STUDENT_PRZEDMIOT values (117, 12, 5, 'dapibus at diam nam tristique tortor eu');
insert into STUDENT_PRZEDMIOT values (118, 13, 2, 'libero convallis eget eleifend luctus ultricies eu nibh');
insert into STUDENT_PRZEDMIOT values (119, 19, 4, 'dapibus duis at velit eu est congue');
insert into STUDENT_PRZEDMIOT values (120, 5, 3, 'mattis nibh ligula nec sem duis aliquam convallis nunc proin');
insert into STUDENT_PRZEDMIOT values (121, 5, 2, 'id ornare imperdiet sapien urna pretium nisl ut');
insert into STUDENT_PRZEDMIOT values (122, 18, 4, 'in magna bibendum imperdiet nullam orci');
insert into STUDENT_PRZEDMIOT values (123, 4, 5, 'tellus semper interdum mauris ullamcorper');
insert into STUDENT_PRZEDMIOT values (124, 18, 5, 'turpis eget elit sodales scelerisque');
insert into STUDENT_PRZEDMIOT values (125, 11, 4, 'vel accumsan tellus nisi eu orci mauris lacinia');
insert into STUDENT_PRZEDMIOT values (126, 2, 2, 'varius nulla facilisi cras non velit nec');
insert into STUDENT_PRZEDMIOT values (127, 14, 4, 'lorem ipsum dolor sit amet consectetuer adipiscing elit');
insert into STUDENT_PRZEDMIOT values (128, 12, 3, 'venenatis lacinia aenean sit amet justo morbi');
insert into STUDENT_PRZEDMIOT values (129, 10, 2, 'congue diam id ornare imperdiet sapien urna pretium nisl ut');
insert into STUDENT_PRZEDMIOT values (130, 5, 3, 'neque libero convallis eget eleifend luctus ultricies');
insert into STUDENT_PRZEDMIOT values (131, 6, 3, 'odio donec vitae nisi nam ultrices libero non mattis');
insert into STUDENT_PRZEDMIOT values (132, 9, 5, 'amet diam in magna bibendum imperdiet nullam orci pede venenatis');
insert into STUDENT_PRZEDMIOT values (133, 14, 3, 'quam turpis adipiscing lorem vitae mattis nibh ligula nec sem');
insert into STUDENT_PRZEDMIOT values (134, 14, 5, 'amet diam in magna bibendum imperdiet nullam orci');
insert into STUDENT_PRZEDMIOT values (135, 13, 2, 'ante vivamus tortor duis mattis egestas metus aenean fermentum donec');
insert into STUDENT_PRZEDMIOT values (136, 16, 5, 'faucibus cursus urna ut tellus nulla ut erat');
insert into STUDENT_PRZEDMIOT values (137, 13, 2, 'scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis');
insert into STUDENT_PRZEDMIOT values (138, 10, 4, 'sit amet consectetuer adipiscing elit');
insert into STUDENT_PRZEDMIOT values (139, 19, 5, 'eu felis fusce posuere felis');
insert into STUDENT_PRZEDMIOT values (140, 6, 2, 'vestibulum sed magna at nunc commodo placerat praesent blandit');
insert into STUDENT_PRZEDMIOT values (141, 1, 4, 'turpis a pede posuere nonummy integer non velit donec diam');
insert into STUDENT_PRZEDMIOT values (142, 2, 4, 'rutrum rutrum neque aenean auctor');
insert into STUDENT_PRZEDMIOT values (143, 8, 2, 'platea dictumst maecenas ut massa quis augue luctus');
insert into STUDENT_PRZEDMIOT values (144, 6, 3, 'ut massa volutpat convallis morbi odio');
insert into STUDENT_PRZEDMIOT values (145, 15, 4, 'vulputate justo in blandit ultrices enim lorem ipsum');
insert into STUDENT_PRZEDMIOT values (146, 19, 2, 'cubilia curae mauris viverra diam vitae quam suspendisse potenti');
insert into STUDENT_PRZEDMIOT values (147, 17, 3, 'vel ipsum praesent blandit lacinia erat vestibulum sed');
insert into STUDENT_PRZEDMIOT values (148, 4, 2, 'nulla neque libero convallis eget eleifend luctus ultricies');
insert into STUDENT_PRZEDMIOT values (149, 1, 4, 'amet cursus id turpis integer aliquet massa id');
insert into STUDENT_PRZEDMIOT values (150, 17, 3, 'lorem vitae mattis nibh ligula nec sem');
insert into STUDENT_PRZEDMIOT values (151, 16, 5, 'nibh fusce lacus purus aliquet at feugiat non pretium');
insert into STUDENT_PRZEDMIOT values (152, 13, 4, 'eu magna vulputate luctus cum');
insert into STUDENT_PRZEDMIOT values (153, 11, 2, 'nulla nisl nunc nisl duis bibendum felis');
insert into STUDENT_PRZEDMIOT values (154, 15, 5, 'potenti cras in purus eu magna vulputate luctus cum sociis');
insert into STUDENT_PRZEDMIOT values (155, 5, 2, 'in leo maecenas pulvinar lobortis est');
insert into STUDENT_PRZEDMIOT values (156, 13, 2, 'semper rutrum nulla nunc purus phasellus in felis donec');
insert into STUDENT_PRZEDMIOT values (157, 2, 4, 'sapien placerat ante nulla justo');
insert into STUDENT_PRZEDMIOT values (158, 14, 5, 'vivamus vestibulum sagittis sapien cum');
insert into STUDENT_PRZEDMIOT values (159, 4, 3, 'ullamcorper augue a suscipit nulla elit');
insert into STUDENT_PRZEDMIOT values (160, 18, 4, 'in felis donec semper sapien');
insert into STUDENT_PRZEDMIOT values (161, 4, 3, 'blandit lacinia erat vestibulum sed magna');
insert into STUDENT_PRZEDMIOT values (162, 2, 4, 'sapien non mi integer ac neque');
insert into STUDENT_PRZEDMIOT values (163, 6, 5, 'vestibulum ante ipsum primis in faucibus orci luctus');
insert into STUDENT_PRZEDMIOT values (164, 1, 5, 'vel est donec odio justo sollicitudin ut suscipit');
insert into STUDENT_PRZEDMIOT values (165, 14, 4, 'pellentesque ultrices mattis odio donec vitae nisi nam ultrices');
insert into STUDENT_PRZEDMIOT values (166, 20, 4, 'enim sit amet nunc viverra dapibus');
insert into STUDENT_PRZEDMIOT values (167, 8, 2, 'lobortis vel dapibus at diam nam tristique');
insert into STUDENT_PRZEDMIOT values (168, 5, 2, 'natoque penatibus et magnis dis parturient montes');
insert into STUDENT_PRZEDMIOT values (169, 15, 4, 'maecenas ut massa quis augue luctus tincidunt nulla mollis molestie');
insert into STUDENT_PRZEDMIOT values (170, 13, 3, 'eget tincidunt eget tempus vel pede morbi porttitor lorem');
insert into STUDENT_PRZEDMIOT values (171, 4, 2, 'massa tempor convallis nulla neque libero convallis eget eleifend');
insert into STUDENT_PRZEDMIOT values (172, 19, 4, 'gravida sem praesent id massa id');
insert into STUDENT_PRZEDMIOT values (173, 7, 4, 'morbi sem mauris laoreet ut');
insert into STUDENT_PRZEDMIOT values (174, 9, 2, 'mauris enim leo rhoncus sed');
insert into STUDENT_PRZEDMIOT values (175, 5, 4, 'nullam varius nulla facilisi cras non');
insert into STUDENT_PRZEDMIOT values (176, 17, 2, 'mauris morbi non lectus aliquam sit amet diam in');
insert into STUDENT_PRZEDMIOT values (177, 3, 5, 'duis bibendum felis sed interdum venenatis');
insert into STUDENT_PRZEDMIOT values (178, 4, 3, 'enim leo rhoncus sed vestibulum sit amet cursus id');
insert into STUDENT_PRZEDMIOT values (179, 17, 2, 'duis at velit eu est congue elementum in hac habitasse');
insert into STUDENT_PRZEDMIOT values (180, 2, 3, 'tellus in sagittis dui vel nisl duis ac');
insert into STUDENT_PRZEDMIOT values (181, 18, 2, 'sapien arcu sed augue aliquam erat volutpat');
insert into STUDENT_PRZEDMIOT values (182, 10, 3, 'elit sodales scelerisque mauris sit amet eros suspendisse');
insert into STUDENT_PRZEDMIOT values (183, 10, 5, 'aliquam erat volutpat in congue');
insert into STUDENT_PRZEDMIOT values (184, 3, 5, 'hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc');
insert into STUDENT_PRZEDMIOT values (185, 17, 3, 'at ipsum ac tellus semper interdum mauris');
insert into STUDENT_PRZEDMIOT values (186, 10, 3, 'suscipit nulla elit ac nulla sed vel');
insert into STUDENT_PRZEDMIOT values (187, 11, 5, 'lectus aliquam sit amet diam in magna bibendum imperdiet');
insert into STUDENT_PRZEDMIOT values (188, 5, 4, 'iaculis justo in hac habitasse');
insert into STUDENT_PRZEDMIOT values (189, 10, 2, 'sapien cursus vestibulum proin eu');
insert into STUDENT_PRZEDMIOT values (190, 19, 4, 'id pretium iaculis diam erat fermentum justo');
insert into STUDENT_PRZEDMIOT values (191, 2, 2, 'turpis integer aliquet massa id lobortis convallis tortor risus dapibus');
insert into STUDENT_PRZEDMIOT values (192, 16, 4, 'sapien quis libero nullam sit amet');
insert into STUDENT_PRZEDMIOT values (193, 2, 2, 'diam id ornare imperdiet sapien urna');
insert into STUDENT_PRZEDMIOT values (194, 18, 3, 'lorem quisque ut erat curabitur gravida nisi at nibh in');
insert into STUDENT_PRZEDMIOT values (195, 15, 4, 'feugiat et eros vestibulum ac est lacinia');
insert into STUDENT_PRZEDMIOT values (196, 19, 4, 'lacinia nisi venenatis tristique fusce congue diam id ornare');
insert into STUDENT_PRZEDMIOT values (197, 18, 2, 'aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien');
insert into STUDENT_PRZEDMIOT values (198, 14, 5, 'luctus ultricies eu nibh quisque id justo sit amet sapien');
insert into STUDENT_PRZEDMIOT values (199, 8, 4, 'pulvinar nulla pede ullamcorper augue a');
insert into STUDENT_PRZEDMIOT values (200, 7, 4, 'sapien placerat ante nulla justo aliquam quis turpis');



INSERT INTO PROJEKT VALUES ('Aplikacja bazodanowa', 1, NULL, NULL, NULL);	





