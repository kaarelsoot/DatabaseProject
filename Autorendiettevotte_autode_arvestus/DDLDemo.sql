DROP TABLE IF EXISTS "Tootaja" CASCADE
;

DROP TABLE IF EXISTS "Klient" CASCADE
;

DROP TABLE IF EXISTS "Amet" CASCADE
;

DROP TABLE IF EXISTS "Auto_kategooria" CASCADE
;

DROP TABLE IF EXISTS "Auto_kategooria_tyyp" CASCADE
;

DROP TABLE IF EXISTS "Auto_kytuse_liik" CASCADE
;

DROP TABLE IF EXISTS "Auto_mark" CASCADE
;

DROP TABLE IF EXISTS "Auto_seisundi_liik" CASCADE
;

DROP TABLE IF EXISTS "Isiku_seisundi_liik" CASCADE
;

DROP TABLE IF EXISTS "Kliendi_seisundi_liik" CASCADE
;

DROP TABLE IF EXISTS "Riik" CASCADE
;

DROP TABLE IF EXISTS "Tootaja_seisundi_liik" CASCADE
;

DROP TABLE IF EXISTS "Isik" CASCADE
;

DROP TABLE IF EXISTS "Auto" CASCADE
;

DROP TABLE IF EXISTS "Auto_kategooria_omamine" CASCADE
;

CREATE TABLE "Tootaja"
(
	"isik_id" integer NOT NULL,
	"amet_kood" smallint NOT NULL,
	"tootaja_seisundi_liik_kood" char NOT NULL DEFAULT 'T',
	"mentor" integer
)
;

CREATE TABLE "Klient"
(
	"isik_id" integer NOT NULL,
	"kliendi_seisundi_liik_kood" char NOT NULL DEFAULT 'A',
	"on_nous_tylitamisega" boolean NOT NULL DEFAULT FALSE
)
;

CREATE TABLE "Amet"
(
	"amet_kood" smallint NOT NULL,
	"nimetus" varchar(255)	 NOT NULL,
	"kirjeldus" text
)
;

CREATE TABLE "Auto_kategooria"
(
	"auto_kategooria_kood" smallint NOT NULL,
	"nimetus" varchar(255)	 NOT NULL,
	"auto_kategooria_tyyp_kood" smallint NOT NULL
)
;

CREATE TABLE "Auto_kategooria_tyyp"
(
	"auto_kategooria_tyyp_kood" integer NOT NULL,
	"nimetus" varchar(255)	 NOT NULL
)
;

CREATE TABLE "Auto_kytuse_liik"
(
	"auto_kytuse_liik_kood" smallint NOT NULL,
	"nimetus" varchar(255)	 NOT NULL
)
;

CREATE TABLE "Auto_mark"
(
	"auto_mark_kood" smallint NOT NULL,
	"nimetus" varchar(255)	 NOT NULL
)
;

CREATE TABLE "Auto_seisundi_liik"
(
	"auto_seisundi_liik_kood" char(1)	 NOT NULL,
	"nimetus" varchar(255)	 NOT NULL
)
;

CREATE TABLE "Isiku_seisundi_liik"
(
	"isiku_seisundi_liik_kood" char(1)	 NOT NULL,
	"nimetus" varchar(255)	 NOT NULL
)
;

CREATE TABLE "Kliendi_seisundi_liik"
(
	"kliendi_seisundi_liik_kood" char(1)	 NOT NULL,
	"nimetus" varchar(255)	 NOT NULL
)
;

CREATE TABLE "Riik"
(
	"riik_kood" char(3)	 NOT NULL,
	"nimetus" varchar(255)	 NOT NULL
)
;

CREATE TABLE "Tootaja_seisundi_liik"
(
	"tootaja_seisundi_liik_kood" char(1)	 NOT NULL,
	"nimetus" varchar(255)	 NOT NULL
)
;

CREATE TABLE "Isik"
(
	"isik_id" serial NOT NULL,
	"e_meil" varchar(254)	 NOT NULL,
	"isikukood" varchar(255)	 NOT NULL,
	"riik_kood" char(3)	 NOT NULL,
	"isiku_seisundi_liik_kood" char(1)	 NOT NULL DEFAULT 'E',
	"synni_kp" date NOT NULL,
	"parool" varchar(60)	 NOT NULL,
	"reg_aeg" timestamp NOT NULL DEFAULT LOCALTIMESTAMP(0),
	"eesnimi" varchar(255)	 NOT NULL,
	"perenimi" varchar(255)	,
	"elukoht" varchar(255)	,
	"auto_kood" smallint
)
;

CREATE TABLE "Auto"
(
	"auto_kood" integer NOT NULL,
	"nimetus" varchar(255)	 NOT NULL,
	"vin_kood" varchar(17)	 NOT NULL,
	"auto_kytuse_liik_kood" smallint NOT NULL,
	"auto_mark_kood" smallint NOT NULL,
	"auto_seisundi_liik_kood" char(1)	 NOT NULL DEFAULT 'V',
	"isik_id" integer NOT NULL,
	"mudel" varchar(50)	 NOT NULL,
	"valjalaske_aasta" smallint NOT NULL,
	"reg_number" varchar(9)	 NOT NULL,
	"istekohtade_arv" smallint NOT NULL,
	"reg_aeg" timestamp NOT NULL DEFAULT LOCALTIMESTAMP(0),
	"mootori_maht" decimal(4,3)
)
;

CREATE TABLE "Auto_kategooria_omamine"
(
	"auto_kood" integer NOT NULL,
	"auto_kategooria_kood" smallint NOT NULL
)
;

CREATE SEQUENCE "isik_isik_id_seq" INCREMENT 1 START 1
;

CREATE INDEX "IXFK_Tootaja_Amet" ON "Tootaja" ("amet_kood" ASC)
;

CREATE INDEX "IXFK_Tootaja_Isik" ON "Tootaja" ("isik_id" ASC)
;

CREATE INDEX "IXFK_Tootaja_Mentor" ON "Tootaja" ("mentor" ASC)
;

CREATE INDEX "IXFK_Tootaja_Tootaja_seisundi_liik" ON "Tootaja" ("tootaja_seisundi_liik_kood" ASC)
;

ALTER TABLE "Tootaja" ADD CONSTRAINT "PK_Tootaja"
	PRIMARY KEY ("isik_id")
;

CREATE INDEX "IXFK_Klient_Isik" ON "Klient" ("isik_id" ASC)
;

CREATE INDEX "IXFK_Klient_Kliendi_seisundi_liik" ON "Klient" ("kliendi_seisundi_liik_kood" ASC)
;

ALTER TABLE "Klient" ADD CONSTRAINT "PK_Klient"
	PRIMARY KEY ("isik_id")
;

ALTER TABLE "Amet" ADD CONSTRAINT "PK_Amet"
	PRIMARY KEY ("amet_kood")
;

ALTER TABLE "Amet" ADD CONSTRAINT "AK_Amet_nimetus" UNIQUE ("nimetus")
;

ALTER TABLE "Amet" ADD CONSTRAINT "CHK_Amet_kirjeldus_ei_ole_tyhi" CHECK (trim(kirjeldus)<>'')
;

ALTER TABLE "Amet" ADD CONSTRAINT "CHK_Amet_nimetus_ei_ole_tyhi" CHECK (trim(nimetus) <> '')
;

CREATE INDEX "IXFK_Auto_kategooria_Auto_kategooria_tyyp" ON "Auto_kategooria" ("auto_kategooria_tyyp_kood" ASC)
;

ALTER TABLE "Auto_kategooria" ADD CONSTRAINT "PK_Auto_kategooria"
	PRIMARY KEY ("auto_kategooria_kood")
;

ALTER TABLE "Auto_kategooria" ADD CONSTRAINT "AK_Auto_kategooria_Nimetus" UNIQUE ("auto_kategooria_tyyp_kood","nimetus")
;

ALTER TABLE "Auto_kategooria" ADD CONSTRAINT "CHK_Auto_kategooria_nimetus_ei_ole_tyhi" CHECK (trim(nimetus) <> '')
;

ALTER TABLE "Auto_kategooria_tyyp" ADD CONSTRAINT "PK_Auto_kategooria_tyyp"
	PRIMARY KEY ("auto_kategooria_tyyp_kood")
;

ALTER TABLE "Auto_kategooria_tyyp" ADD CONSTRAINT "AK_Auto_kategooria_nimetus" UNIQUE ("nimetus")
;

ALTER TABLE "Auto_kategooria_tyyp" ADD CONSTRAINT "CHK_Auto_kategooria_nimetus_ei_ole_tyhi" CHECK (trim(nimetus) <> '')
;

ALTER TABLE "Auto_kytuse_liik" ADD CONSTRAINT "PK_Auto_kytuse_liik"
	PRIMARY KEY ("auto_kytuse_liik_kood")
;

ALTER TABLE "Auto_kytuse_liik" ADD CONSTRAINT "AK_Auto_kytuse_liik_Nimetus" UNIQUE ("nimetus")
;

ALTER TABLE "Auto_kytuse_liik" ADD CONSTRAINT "CHK_Auto_kytuse_liik_nimetus_ei_ole_tyhi" CHECK (trim(nimetus) <> '')
;

ALTER TABLE "Auto_mark" ADD CONSTRAINT "PK_Auto_mark"
	PRIMARY KEY ("auto_mark_kood")
;

ALTER TABLE "Auto_mark" ADD CONSTRAINT "AK_Auto_mark_Nimetus" UNIQUE ("nimetus")
;

ALTER TABLE "Auto_mark" ADD CONSTRAINT "CHK_Auto_mark_nimetus_ei_ole_tyhi" CHECK (trim(nimetus) <> '')
;

ALTER TABLE "Auto_seisundi_liik" ADD CONSTRAINT "PK_Auto_seisundi_liik"
	PRIMARY KEY ("auto_seisundi_liik_kood")
;

ALTER TABLE "Auto_seisundi_liik" ADD CONSTRAINT "AK_Auto_seisundi_liik_nimetus" UNIQUE ("nimetus")
;

ALTER TABLE "Auto_seisundi_liik" ADD CONSTRAINT "CHK_Auto_seisundi_liik_kood_ei_ole_tyhi" CHECK (trim(auto_seisundi_liik_kood) <> '')
;

ALTER TABLE "Auto_seisundi_liik" ADD CONSTRAINT "CHK_Auto_seisundi_liik_nimetus" CHECK (trim(nimetus) <> '')
;

ALTER TABLE "Isiku_seisundi_liik" ADD CONSTRAINT "PK_Isiku_seisundi_liik"
	PRIMARY KEY ("isiku_seisundi_liik_kood")
;

ALTER TABLE "Isiku_seisundi_liik" ADD CONSTRAINT "AK_Isiku_seisundi_liik_nimetus" UNIQUE ("nimetus")
;

ALTER TABLE "Isiku_seisundi_liik" ADD CONSTRAINT "CHK_Isiku_seisundi_liik_nimetus_ei_ole_tyhi" CHECK (trim(nimetus) <> '')
;

ALTER TABLE "Isiku_seisundi_liik" ADD CONSTRAINT "CHK_Isiku_seisundi_liik_kood_ei_ole_tyhi" CHECK (trim(isiku_seisundi_liik_kood) <> '')
;

ALTER TABLE "Kliendi_seisundi_liik" ADD CONSTRAINT "PK_Kliendi_seisundi_liik"
	PRIMARY KEY ("kliendi_seisundi_liik_kood")
;

ALTER TABLE "Kliendi_seisundi_liik" ADD CONSTRAINT "AK_Kliendi_seisundi_liik_Nimetus" UNIQUE ("nimetus")
;

ALTER TABLE "Kliendi_seisundi_liik" ADD CONSTRAINT "CHK_Kliendi_seisundi_liik_nimetus_ei_ole_tyhi" CHECK (trim(nimetus) <> '')
;

ALTER TABLE "Kliendi_seisundi_liik" ADD CONSTRAINT "CHK_Kliendi_seisundi_liik_kood_ei_ole_tyhi" CHECK (trim(kliendi_seisundi_liik_kood) <> '')
;

ALTER TABLE "Riik" ADD CONSTRAINT "PK_Riik"
	PRIMARY KEY ("riik_kood")
;

ALTER TABLE "Riik" ADD CONSTRAINT "AK_Riik_nimetus" UNIQUE ("nimetus")
;

ALTER TABLE "Riik" ADD CONSTRAINT "CHK_Riik_kood_koosneb_kolmest_suurt2hest" CHECK (riik_kood ~ '^[A-Z]{3}$')
;

ALTER TABLE "Riik" ADD CONSTRAINT "CHK_Riik_nimetus_ei_ole_tyhi" CHECK (trim(nimetus) <> '')
;

ALTER TABLE "Tootaja_seisundi_liik" ADD CONSTRAINT "PK_Tootaja_seisundi_liik"
	PRIMARY KEY ("tootaja_seisundi_liik_kood")
;

ALTER TABLE "Tootaja_seisundi_liik" ADD CONSTRAINT "AK_Tootaja_seisundi_liik" UNIQUE ("nimetus")
;

ALTER TABLE "Tootaja_seisundi_liik" ADD CONSTRAINT "CHK_Tootaja_seisundi_liik_nimetus_ei_ole_tyhi" CHECK (trim(nimetus) <> '')
;

ALTER TABLE "Tootaja_seisundi_liik" ADD CONSTRAINT "CHK_Tootaja_seisundi_liik_kood_ei_ole_tyhi" CHECK (trim(tootaja_seisundi_liik_kood) <> '')
;

CREATE INDEX "IXFK_Isik_Auto" ON "Isik" ("auto_kood" ASC)
;

CREATE INDEX "IXFK_Isik_Isiku_seisundi_liik" ON "Isik" ("isiku_seisundi_liik_kood" ASC)
;

CREATE INDEX "IXFK_Isik_Riik" ON "Isik" ("riik_kood" ASC)
;

ALTER TABLE "Isik" ADD CONSTRAINT "PK_Isik"
	PRIMARY KEY ("isik_id")
;

ALTER TABLE "Isik" ADD CONSTRAINT "AK_Isik_e_meil" UNIQUE ("e_meil")
;

ALTER TABLE "Isik" ADD CONSTRAINT "AK_Isik_Isikukood_Riik" UNIQUE ("isikukood","riik_kood")
;

ALTER TABLE "Isik" ADD CONSTRAINT "CHK_Isik_Isikukood_vastab_mustrile" CHECK (isikukood ~ '^[a-zA-Z0-9 -\/]*$')
;

ALTER TABLE "Isik" ADD CONSTRAINT "CHK_Isik_Isikukood_ei_ole_tyhi" CHECK (trim(isikukood) <> '')
;

ALTER TABLE "Isik" ADD CONSTRAINT "CHK_Isik_Synni_kp_vahemikus" CHECK (synni_kp>='1900-01-01' AND
synni_kp<'2101-01-01')
;

ALTER TABLE "Isik" ADD CONSTRAINT "CHK_Isik_Reg_aeg_vahemikus" CHECK (reg_aeg>='2010-01-01' AND
reg_aeg<'2101-01-01')
;

ALTER TABLE "Isik" ADD CONSTRAINT "CHK_Isik_Elukoht_ei_ole_tyhi" CHECK (trim(elukoht) <> '')
;

ALTER TABLE "Isik" ADD CONSTRAINT "CHK_Isik_E_meil_pikkus_kuni_254_m2rki" CHECK (LENGTH(e_meil)<=254)
;

ALTER TABLE "Isik" ADD CONSTRAINT "CHK_Isik_Eesnimi_voi_perenimi_pole_tyhi" CHECK (trim(eesnimi) <> '' OR trim(perenimi) <> '')
;

ALTER TABLE "Isik" ADD CONSTRAINT "CHK_Isik_Synni_kp_v�iksem_kui_reg_aeg" CHECK (synni_kp<now())
;

ALTER TABLE "Isik" ADD CONSTRAINT "CHK_Isik_E_meil_sisladab_v2hemalt_yht_@_m2rki" CHECK (e_meil  ~ '^[^@]*@[^@]*$')
;

ALTER TABLE "Isik" ADD CONSTRAINT "CHK_Isik_Reg_aeg_on_vahemikus" CHECK (reg_aeg >= '2010-01-01' AND reg_aeg < '2101-01-01')
;

CREATE INDEX "IXFK_Auto_Auto_kytuse_liik" ON "Auto" ("auto_kytuse_liik_kood" ASC)
;

CREATE INDEX "IXFK_Auto_Auto_mark" ON "Auto" ("auto_mark_kood" ASC)
;

CREATE INDEX "IXFK_Auto_Auto_seisundi_liik" ON "Auto" ("auto_seisundi_liik_kood" ASC)
;

CREATE INDEX "IXFK_Auto_Tootaja" ON "Auto" ("isik_id" ASC)
;

ALTER TABLE "Auto" ADD CONSTRAINT "PK_Auto"
	PRIMARY KEY ("auto_kood")
;

ALTER TABLE "Auto" ADD CONSTRAINT "AK_Auto_Vin_kood" UNIQUE ("vin_kood")
;

ALTER TABLE "Auto" ADD CONSTRAINT "AK_Auto_Nimetus" UNIQUE ("nimetus")
;

ALTER TABLE "Auto" ADD CONSTRAINT "CHK_Auto_Valjalaske_aasta_on_vahemikus_2000_ja_2100" CHECK (valjalaske_aasta BETWEEN 2000 AND 2100)
;

ALTER TABLE "Auto" ADD CONSTRAINT "CHK_Auto_Nimetus_ei_ole_tyhi" CHECK (trim(nimetus) <> '')
;

ALTER TABLE "Auto" ADD CONSTRAINT "CHK_Auto_Reg_number_koosneb_suurtahtedest_numbritest_ja_vastab_mustrile" CHECK (reg_number ~ '^([A-Z][0-9]{1,8}|[0-9]{2,3}[A-Z]{3})$')
;

ALTER TABLE "Auto" ADD CONSTRAINT "CHK_Auto_VIN_kood_vahemikus_11_17_ja_koosneb_suurtahtedest_numbritest" CHECK (vin_kood ~ '^[A-Z1-9]{11,17}$')
;

ALTER TABLE "Auto" ADD CONSTRAINT "CHK_Auto_Istekohtade_arv_vahemikus_2_11" CHECK (istekohtade_arv BETWEEN 2000 AND 2100)
;

ALTER TABLE "Auto" ADD CONSTRAINT "CHK_Auto_mudel_ei_ole_tyhi" CHECK (trim(mudel) <> '')
;

ALTER TABLE "Auto" ADD CONSTRAINT "CHK_Auto_Mootori_maht_ei_ole_negatiivne_arv" CHECK (mootori_maht >= 0)
;

ALTER TABLE "Auto" ADD CONSTRAINT "CHK_Auto_reg_aeg_vahemikus" CHECK (reg_aeg>='2010-01-01' AND
reg_aeg<'2101-01-01')
;

CREATE INDEX "IXFK_Auto_kategooria_omamine_Auto" ON "Auto_kategooria_omamine" ("auto_kood" ASC)
;

CREATE INDEX "IXFK_Auto_kategooria_omamine_Auto_kategooria" ON "Auto_kategooria_omamine" ("auto_kategooria_kood" ASC)
;

ALTER TABLE "Auto_kategooria_omamine" ADD CONSTRAINT "PK_Auto_kategooria_omamine"
	PRIMARY KEY ("auto_kood","auto_kategooria_kood")
;

ALTER TABLE "Tootaja" ADD CONSTRAINT "FK_Tootaja_Tootaja"
	FOREIGN KEY ("mentor") REFERENCES "Tootaja" ("isik_id") ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE "Tootaja" ADD CONSTRAINT "FK_Tootaja_Amet"
	FOREIGN KEY ("amet_kood") REFERENCES "Amet" ("amet_kood") ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE "Tootaja" ADD CONSTRAINT "FK_Tootaja_Tootaja_seisundi_liik"
	FOREIGN KEY ("tootaja_seisundi_liik_kood") REFERENCES "Tootaja_seisundi_liik" ("tootaja_seisundi_liik_kood") ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE "Tootaja" ADD CONSTRAINT "FK_Tootaja_Isik"
	FOREIGN KEY ("isik_id") REFERENCES "Isik" ("isik_id") ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE "Klient" ADD CONSTRAINT "FK_Klient_Kliendi_seisundi_liik"
	FOREIGN KEY ("kliendi_seisundi_liik_kood") REFERENCES "Kliendi_seisundi_liik" ("kliendi_seisundi_liik_kood") ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE "Klient" ADD CONSTRAINT "FK_Klient_Isik"
	FOREIGN KEY ("isik_id") REFERENCES "Isik" ("isik_id") ON DELETE Cascade ON UPDATE Cascade
;

ALTER TABLE "Auto_kategooria" ADD CONSTRAINT "FK_Auto_kategooria_Auto_kategooria_tyyp"
	FOREIGN KEY ("auto_kategooria_tyyp_kood") REFERENCES "Auto_kategooria_tyyp" ("auto_kategooria_tyyp_kood") ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE "Isik" ADD CONSTRAINT "FK_Isik_Isiku_seisundi_liik"
	FOREIGN KEY ("isiku_seisundi_liik_kood") REFERENCES "Isiku_seisundi_liik" ("isiku_seisundi_liik_kood") ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE "Isik" ADD CONSTRAINT "FK_Isik_Riik"
	FOREIGN KEY ("riik_kood") REFERENCES "Riik" ("riik_kood") ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE "Auto" ADD CONSTRAINT "FK_Auto_Auto_mark"
	FOREIGN KEY ("auto_mark_kood") REFERENCES "Auto_mark" ("auto_mark_kood") ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE "Auto" ADD CONSTRAINT "FK_Auto_Tootaja"
	FOREIGN KEY ("isik_id") REFERENCES "Isik" ("isik_id") ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE "Auto" ADD CONSTRAINT "FK_Auto_Auto_kytuse_liik"
	FOREIGN KEY ("auto_kytuse_liik_kood") REFERENCES "Auto_kytuse_liik" ("auto_kytuse_liik_kood") ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE "Auto" ADD CONSTRAINT "FK_Auto_Auto_seisundi_liik"
	FOREIGN KEY ("auto_seisundi_liik_kood") REFERENCES "Auto_seisundi_liik" ("auto_seisundi_liik_kood") ON DELETE No Action ON UPDATE Cascade
;

ALTER TABLE "Auto_kategooria_omamine" ADD CONSTRAINT "FK_Auto_kategooria_omamine_Auto"
	FOREIGN KEY ("auto_kood") REFERENCES "Auto" ("auto_kood") ON DELETE Cascade ON UPDATE Cascade
;

ALTER TABLE "Auto_kategooria_omamine" ADD CONSTRAINT "FK_Auto_kategooria_omamine_Auto_kategooria"
	FOREIGN KEY ("auto_kategooria_kood") REFERENCES "Auto_kategooria" ("auto_kategooria_kood") ON DELETE No Action ON UPDATE Cascade
;
