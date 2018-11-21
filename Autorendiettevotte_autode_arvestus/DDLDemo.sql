DROP SEQUENCE IF EXISTS isik_isik_id_seq
;

DROP TABLE IF EXISTS tootaja CASCADE
;

DROP TABLE IF EXISTS klient CASCADE
;

DROP TABLE IF EXISTS amet CASCADE
;

DROP TABLE IF EXISTS auto_kategooria CASCADE
;

DROP TABLE IF EXISTS auto_kategooria_tyyp CASCADE
;

DROP TABLE IF EXISTS auto_kytuse_liik CASCADE
;

DROP TABLE IF EXISTS auto_mark CASCADE
;

DROP TABLE IF EXISTS auto_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS isiku_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS kliendi_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS riik CASCADE
;

DROP TABLE IF EXISTS tootaja_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS isik CASCADE
;

DROP TABLE IF EXISTS auto CASCADE
;

DROP TABLE IF EXISTS auto_kategooria_omamine CASCADE
;

CREATE TABLE tootaja
(
	tootaja_id integer NOT NULL,
	amet_kood smallint NOT NULL,
	tootaja_seisundi_liik_kood char NOT NULL DEFAULT 'T',
	mentor_id integer
)
;

CREATE TABLE klient
(
	klient_id integer NOT NULL,
	kliendi_seisundi_liik_kood char NOT NULL DEFAULT 'A',
	on_nous_tylitamisega boolean NOT NULL DEFAULT FALSE
)
;

CREATE TABLE amet
(
	amet_kood smallint NOT NULL,
	nimetus varchar(255)	 NOT NULL,
	kirjeldus text
)
;

CREATE TABLE auto_kategooria
(
	auto_kategooria_kood smallint NOT NULL,
	nimetus varchar(255)	 NOT NULL,
	auto_kategooria_tyyp_kood smallint NOT NULL
)
;

CREATE TABLE auto_kategooria_tyyp
(
	auto_kategooria_tyyp_kood smallint NOT NULL,
	nimetus varchar(255)	 NOT NULL
)
;

CREATE TABLE auto_kytuse_liik
(
	auto_kytuse_liik_kood smallint NOT NULL,
	nimetus varchar(255)	 NOT NULL
)
;

CREATE TABLE auto_mark
(
	auto_mark_kood smallint NOT NULL,
	nimetus varchar(255)	 NOT NULL
)
;

CREATE TABLE auto_seisundi_liik
(
	auto_seisundi_liik_kood char(1)	 NOT NULL,
	nimetus varchar(255)	 NOT NULL
)
;

CREATE TABLE isiku_seisundi_liik
(
	isiku_seisundi_liik_kood char(1)	 NOT NULL,
	nimetus varchar(255)	 NOT NULL
)
;

CREATE TABLE kliendi_seisundi_liik
(
	kliendi_seisundi_liik_kood char(1)	 NOT NULL,
	nimetus varchar(255)	 NOT NULL
)
;

CREATE TABLE riik
(
	riik_kood char(3)	 NOT NULL,
	nimetus varchar(255)	 NOT NULL
)
;

CREATE TABLE tootaja_seisundi_liik
(
	tootaja_seisundi_liik_kood char(1)	 NOT NULL,
	nimetus varchar(255)	 NOT NULL
)
;

CREATE TABLE isik
(
	isik_id serial NOT NULL,
	e_meil varchar(254)	 NOT NULL,
	isikukood varchar(255)	 NOT NULL,
	riik_kood char(3)	 NOT NULL,
	isiku_seisundi_liik_kood char(1)	 NOT NULL DEFAULT 'E',
	synni_kp date NOT NULL,
	parool varchar(60)	 NOT NULL,
	reg_aeg timestamp NOT NULL DEFAULT LOCALTIMESTAMP(0),
	eesnimi varchar(1000)	,
	perenimi varchar(1000)	,
	elukoht varchar(255)	
)
;

CREATE TABLE auto
(
	auto_kood integer NOT NULL,
	nimetus varchar(255)	 NOT NULL,
	vin_kood varchar(17)	 NOT NULL,
	auto_kytuse_liik_kood smallint NOT NULL,
	auto_mark_kood smallint NOT NULL,
	auto_seisundi_liik_kood char(1)	 NOT NULL DEFAULT 'V',
	lisaja_id integer NOT NULL,
	mudel varchar(50)	 NOT NULL,
	valjalaske_aasta smallint NOT NULL,
	reg_number varchar(9)	 NOT NULL,
	istekohtade_arv smallint NOT NULL,
	reg_aeg timestamp NOT NULL DEFAULT LOCALTIMESTAMP(0),
	mootori_maht decimal(4,3) NOT NULL
)
;

CREATE TABLE auto_kategooria_omamine
(
	auto_kood integer NOT NULL,
	auto_kategooria_kood smallint NOT NULL
)
;

CREATE INDEX IXFK_Tootaja_Amet ON tootaja (amet_kood ASC)
;

CREATE INDEX IXFK_Tootaja_Mentor ON tootaja (mentor_id ASC)
;

CREATE INDEX IXFK_Tootaja_Tootaja_seisundi_liik ON tootaja (tootaja_seisundi_liik_kood ASC)
;

ALTER TABLE tootaja ADD CONSTRAINT PK_Tootaja
	PRIMARY KEY (tootaja_id)
;

ALTER TABLE tootaja ADD CONSTRAINT CHK_Tootaja_Mentor_Tootaja_ei_ole_iseenda_mentor CHECK (mentor_id <> tootaja_id)
;

CREATE INDEX IXFK_Klient_Kliendi_seisundi_liik ON klient (kliendi_seisundi_liik_kood ASC)
;

ALTER TABLE klient ADD CONSTRAINT PK_Klient
	PRIMARY KEY (klient_id)
;

ALTER TABLE amet ADD CONSTRAINT PK_Amet
	PRIMARY KEY (amet_kood)
;

ALTER TABLE amet ADD CONSTRAINT AK_Amet_nimetus UNIQUE (nimetus)
;

ALTER TABLE amet ADD CONSTRAINT CHK_Amet_kirjeldus_ei_ole_tyhi CHECK (trim(kirjeldus)<>'')
;

ALTER TABLE amet ADD CONSTRAINT CHK_Amet_nimetus_ei_ole_tyhi CHECK (trim(nimetus) <> '')
;

ALTER TABLE auto_kategooria ADD CONSTRAINT PK_Auto_kategooria
	PRIMARY KEY (auto_kategooria_kood)
;

ALTER TABLE auto_kategooria ADD CONSTRAINT AK_Auto_kategooria_Nimetus UNIQUE (auto_kategooria_tyyp_kood,nimetus)
;

ALTER TABLE auto_kategooria ADD CONSTRAINT CHK_Auto_kategooria_nimetus_ei_ole_tyhi CHECK (trim(nimetus) <> '')
;

ALTER TABLE auto_kategooria_tyyp ADD CONSTRAINT PK_Auto_kategooria_tyyp
	PRIMARY KEY (auto_kategooria_tyyp_kood)
;

ALTER TABLE auto_kategooria_tyyp ADD CONSTRAINT AK_Auto_kategooria_tyyp_nimetus UNIQUE (nimetus)
;

ALTER TABLE auto_kategooria_tyyp ADD CONSTRAINT CHK_Auto_kategooria_tyyp_nimetus_ei_ole_tyhi CHECK (trim(nimetus) <> '')
;

ALTER TABLE auto_kytuse_liik ADD CONSTRAINT PK_Auto_kytuse_liik
	PRIMARY KEY (auto_kytuse_liik_kood)
;

ALTER TABLE auto_kytuse_liik ADD CONSTRAINT AK_Auto_kytuse_liik_Nimetus UNIQUE (nimetus)
;

ALTER TABLE auto_kytuse_liik ADD CONSTRAINT CHK_Auto_kytuse_liik_nimetus_ei_ole_tyhi CHECK (trim(nimetus) <> '')
;

ALTER TABLE auto_mark ADD CONSTRAINT PK_Auto_mark
	PRIMARY KEY (auto_mark_kood)
;

ALTER TABLE auto_mark ADD CONSTRAINT AK_Auto_mark_Nimetus UNIQUE (nimetus)
;

ALTER TABLE auto_mark ADD CONSTRAINT CHK_Auto_mark_nimetus_ei_ole_tyhi CHECK (trim(nimetus) <> '')
;

ALTER TABLE auto_seisundi_liik ADD CONSTRAINT PK_Auto_seisundi_liik
	PRIMARY KEY (auto_seisundi_liik_kood)
;

ALTER TABLE auto_seisundi_liik ADD CONSTRAINT AK_Auto_seisundi_liik_nimetus UNIQUE (nimetus)
;

ALTER TABLE auto_seisundi_liik ADD CONSTRAINT CHK_Auto_seisundi_liik_auto_seisundi_liik_kood_ei_ole_tyhi CHECK (trim(auto_seisundi_liik_kood) <> '')
;

ALTER TABLE auto_seisundi_liik ADD CONSTRAINT CHK_Auto_seisundi_liik_nimetus_ei_ole_tyhi CHECK (trim(nimetus) <> '')
;

ALTER TABLE isiku_seisundi_liik ADD CONSTRAINT PK_Isiku_seisundi_liik
	PRIMARY KEY (isiku_seisundi_liik_kood)
;

ALTER TABLE isiku_seisundi_liik ADD CONSTRAINT AK_Isiku_seisundi_liik_nimetus UNIQUE (nimetus)
;

ALTER TABLE isiku_seisundi_liik ADD CONSTRAINT CHK_Isiku_seisundi_liik_nimetus_ei_ole_tyhi CHECK (trim(nimetus) <> '')
;

ALTER TABLE isiku_seisundi_liik ADD CONSTRAINT CHK_Isiku_seisundi_liik_isiku_seisundi_liik_kood_ei_ole_tyhi CHECK (trim(isiku_seisundi_liik_kood) <> '')
;

ALTER TABLE kliendi_seisundi_liik ADD CONSTRAINT PK_Kliendi_seisundi_liik
	PRIMARY KEY (kliendi_seisundi_liik_kood)
;

ALTER TABLE kliendi_seisundi_liik ADD CONSTRAINT AK_Kliendi_seisundi_liik_Nimetus UNIQUE (nimetus)
;

ALTER TABLE kliendi_seisundi_liik ADD CONSTRAINT CHK_Kliendi_seisundi_liik_nimetus_ei_ole_tyhi CHECK (trim(nimetus) <> '')
;

ALTER TABLE kliendi_seisundi_liik ADD CONSTRAINT CHK_Kliendi_seisundi_liik_kliendi_seisundi_liik_kood_ei_ole_tyhi CHECK (trim(kliendi_seisundi_liik_kood) <> '')
;

ALTER TABLE riik ADD CONSTRAINT PK_Riik
	PRIMARY KEY (riik_kood)
;

ALTER TABLE riik ADD CONSTRAINT AK_Riik_nimetus UNIQUE (nimetus)
;

ALTER TABLE riik ADD CONSTRAINT CHK_Riik_kood_koosneb_kolmest_suurt2hest CHECK (riik_kood ~ '^[A-Z]{3}$')
;

ALTER TABLE riik ADD CONSTRAINT CHK_Riik_nimetus_ei_ole_tyhi CHECK (trim(nimetus) <> '')
;

ALTER TABLE tootaja_seisundi_liik ADD CONSTRAINT PK_Tootaja_seisundi_liik
	PRIMARY KEY (tootaja_seisundi_liik_kood)
;

ALTER TABLE tootaja_seisundi_liik ADD CONSTRAINT AK_Tootaja_seisundi_liik UNIQUE (nimetus)
;

ALTER TABLE tootaja_seisundi_liik ADD CONSTRAINT CHK_Tootaja_seisundi_liik_nimetus_ei_ole_tyhi CHECK (trim(nimetus) <> '')
;

ALTER TABLE tootaja_seisundi_liik ADD CONSTRAINT CHK_Tootaja_seisundi_liik_tootaja_seisundi_liik_kood_ei_ole_tyhi CHECK (trim(tootaja_seisundi_liik_kood) <> '')
;

CREATE INDEX IXFK_Isik_Isiku_seisundi_liik ON isik (isiku_seisundi_liik_kood ASC)
;

CREATE INDEX IXFK_Isik_Riik ON isik (riik_kood ASC)
;

ALTER TABLE isik ADD CONSTRAINT PK_Isik
	PRIMARY KEY (isik_id)
;

ALTER TABLE isik ADD CONSTRAINT AK_Isik_e_meil UNIQUE (e_meil)
;

ALTER TABLE isik ADD CONSTRAINT AK_Isik_Isikukood_Riik UNIQUE (isikukood,riik_kood)
;

ALTER TABLE isik ADD CONSTRAINT CHK_Isik_Isikukood_vastab_mustrile CHECK (isikukood ~ '^[a-zA-Z0-9 -\/]*$')
;

ALTER TABLE isik ADD CONSTRAINT CHK_Isik_Isikukood_ei_ole_tyhi CHECK (trim(isikukood) <> '')
;

ALTER TABLE isik ADD CONSTRAINT CHK_Isik_Synni_kp_vahemikus CHECK (synni_kp>='1900-01-01' AND
synni_kp<'2101-01-01')
;

ALTER TABLE isik ADD CONSTRAINT CHK_Isik_Reg_aeg_vahemikus CHECK (reg_aeg>='2010-01-01' AND
reg_aeg<'2101-01-01')
;

ALTER TABLE isik ADD CONSTRAINT CHK_Isik_Elukoht_ei_ole_tyhi CHECK (trim(elukoht) <> '')
;

ALTER TABLE isik ADD CONSTRAINT CHK_Isik_Eesnimi_voi_perenimi_pole_tyhi CHECK (trim(eesnimi) <> '' OR trim(perenimi) <> '')
;

ALTER TABLE isik ADD CONSTRAINT CHK_Isik_Synni_kp_v�iksem_kui_reg_aeg CHECK (synni_kp<now())
;

ALTER TABLE isik ADD CONSTRAINT CHK_Isik_E_meil_vastab_mustrile CHECK (e_meil  ~ '^[^@]*@[^@]*$')
;

CREATE INDEX IXFK_Auto_Auto_kytuse_liik ON auto (auto_kytuse_liik_kood ASC)
;

CREATE INDEX IXFK_Auto_Auto_mark ON auto (auto_mark_kood ASC)
;

CREATE INDEX IXFK_Auto_Auto_seisundi_liik ON auto (auto_seisundi_liik_kood ASC)
;

CREATE INDEX IXFK_Auto_Lisaja ON auto (lisaja_id ASC)
;

ALTER TABLE auto ADD CONSTRAINT PK_Auto
	PRIMARY KEY (auto_kood)
;

ALTER TABLE auto ADD CONSTRAINT AK_Auto_Vin_kood UNIQUE (vin_kood)
;

ALTER TABLE auto ADD CONSTRAINT AK_Auto_Nimetus UNIQUE (nimetus)
;

ALTER TABLE auto ADD CONSTRAINT CHK_Auto_Valjalaske_aasta_on_vahemikus_2000_ja_2100 CHECK (valjalaske_aasta BETWEEN 2000 AND 2100)
;

ALTER TABLE auto ADD CONSTRAINT CHK_Auto_Nimetus_ei_ole_tyhi CHECK (trim(nimetus) <> '')
;

ALTER TABLE auto ADD CONSTRAINT CHK_Auto_Reg_number_vastab_mustrile CHECK (reg_number ~ '^([A-Z][0-9]{1,8}|[0-9]{2,3}[A-Z]{3})$')
;

ALTER TABLE auto ADD CONSTRAINT CHK_Auto_VIN_kood_koosneb_suurtahtedest_numbritest CHECK (vin_kood ~ '^[A-Z1-9]*$')
;

ALTER TABLE auto ADD CONSTRAINT CHK_Auto_Istekohtade_arv_vahemikus_2_11 CHECK (istekohtade_arv BETWEEN 2 AND 11)
;

ALTER TABLE auto ADD CONSTRAINT CHK_Auto_mudel_ei_ole_tyhi CHECK (trim(mudel) <> '')
;

ALTER TABLE auto ADD CONSTRAINT CHK_Auto_Mootori_maht_ei_ole_negatiivne_arv CHECK (mootori_maht >= 0)
;

ALTER TABLE auto ADD CONSTRAINT CHK_Auto_reg_aeg_vahemikus CHECK (reg_aeg>='2010-01-01' AND
reg_aeg<'2101-01-01')
;

ALTER TABLE auto ADD CONSTRAINT CHK_Auto_VIN_kood_vahemikus_11_17 CHECK (LENGTH(vin_kood) BETWEEN 11 AND 17)
;

CREATE INDEX IXFK_Auto_kategooria_omamine_Auto_kategooria ON auto_kategooria_omamine (auto_kategooria_kood ASC)
;

ALTER TABLE auto_kategooria_omamine ADD CONSTRAINT PK_Auto_kategooria_omamine
	PRIMARY KEY (auto_kood,auto_kategooria_kood)
;

ALTER TABLE tootaja ADD CONSTRAINT FK_Tootaja_Mentor
	FOREIGN KEY (mentor_id) REFERENCES tootaja (tootaja_id) ON DELETE Set Null ON UPDATE Cascade
;

ALTER TABLE tootaja ADD CONSTRAINT FK_Tootaja_Amet
	FOREIGN KEY (amet_kood) REFERENCES amet (amet_kood) ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE tootaja ADD CONSTRAINT FK_Tootaja_Tootaja_seisundi_liik
	FOREIGN KEY (tootaja_seisundi_liik_kood) REFERENCES tootaja_seisundi_liik (tootaja_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE tootaja ADD CONSTRAINT FK_Tootaja_Isik
	FOREIGN KEY (tootaja_id) REFERENCES isik (isik_id) ON DELETE Cascade ON UPDATE Cascade
;

ALTER TABLE klient ADD CONSTRAINT FK_Klient_Kliendi_seisundi_liik
	FOREIGN KEY (kliendi_seisundi_liik_kood) REFERENCES kliendi_seisundi_liik (kliendi_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE klient ADD CONSTRAINT FK_Klient_Isik
	FOREIGN KEY (klient_id) REFERENCES isik (isik_id) ON DELETE Cascade ON UPDATE Cascade
;

ALTER TABLE auto_kategooria ADD CONSTRAINT FK_Auto_kategooria_Auto_kategooria_tyyp
	FOREIGN KEY (auto_kategooria_tyyp_kood) REFERENCES auto_kategooria_tyyp (auto_kategooria_tyyp_kood) ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE isik ADD CONSTRAINT FK_Isik_Isiku_seisundi_liik
	FOREIGN KEY (isiku_seisundi_liik_kood) REFERENCES isiku_seisundi_liik (isiku_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE isik ADD CONSTRAINT FK_Isik_Riik
	FOREIGN KEY (riik_kood) REFERENCES riik (riik_kood) ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE auto ADD CONSTRAINT FK_Auto_Auto_mark
	FOREIGN KEY (auto_mark_kood) REFERENCES auto_mark (auto_mark_kood) ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE auto ADD CONSTRAINT FK_Auto_Lisaja
	FOREIGN KEY (lisaja_id) REFERENCES isik (isik_id) ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE auto ADD CONSTRAINT FK_Auto_Auto_kytuse_liik
	FOREIGN KEY (auto_kytuse_liik_kood) REFERENCES auto_kytuse_liik (auto_kytuse_liik_kood) ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE auto ADD CONSTRAINT FK_Auto_Auto_seisundi_liik
	FOREIGN KEY (auto_seisundi_liik_kood) REFERENCES auto_seisundi_liik (auto_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE auto_kategooria_omamine ADD CONSTRAINT FK_Auto_kategooria_omamine_Auto
	FOREIGN KEY (auto_kood) REFERENCES auto (auto_kood) ON DELETE Cascade ON UPDATE Cascade
;

ALTER TABLE auto_kategooria_omamine ADD CONSTRAINT FK_Auto_kategooria_omamine_Auto_kategooria
	FOREIGN KEY (auto_kategooria_kood) REFERENCES auto_kategooria (auto_kategooria_kood) ON DELETE No Action ON UPDATE Cascade
;
