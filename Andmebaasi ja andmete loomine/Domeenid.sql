--Loob domeenid, muudab vastavate tulpade tüübid ning kustutab ebavajalikud checkid.

CREATE DOMAIN d_reg_aeg
TIMESTAMP NOT NULL DEFAULT LOCALTIMESTAMP(0)
CONSTRAINT chk_d_reg_aeg_vahemik CHECK (VALUE BETWEEN '2010-01-01 00:00:00' AND '2099-01-01 23:59:59');

ALTER TABLE isik
	ALTER COLUMN reg_aeg TYPE d_reg_aeg,
	DROP CONSTRAINT CHK_Isik_reg_aeg_vahemikus;
ALTER TABLE auto
	ALTER COLUMN reg_aeg TYPE d_reg_aeg;
	DROP CONSTRAINT CHK_Auto_reg_aeg_vahemikus;

CREATE DOMAIN d_klassifikaatori_nimetus
VARCHAR(50) NOT NULL
CONSTRAINT chk_klassifikaatori_nimetus_ei_ole_tyhi CHECK (btrim(VALUE::text) <> ''::text);

ALTER TABLE amet
	ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus,
	DROP CONSTRAINT CHK_Amet_nimetus_ei_ole_tyhi;
ALTER TABLE auto_kategooria
	ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus,
	DROP CONSTRAINT CHK_Auto_kategooria_nimetus_ei_ole_tyhi;
ALTER TABLE auto_kategooria_tyyp
	ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus,
	DROP CONSTRAINT CHK_Auto_kategooria_tyyp_nimetus_ei_ole_tyhi;
ALTER TABLE auto_kytuse_liik
	ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus,
	DROP CONSTRAINT CHK_Auto_kytuse_liik_nimetus_ei_ole_tyhi;
ALTER TABLE auto_mark
	ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus,
	DROP CONSTRAINT CHK_Auto_mark_nimetus_ei_ole_tyhi;
ALTER TABLE auto_seisundi_liik
	ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus,
	DROP CONSTRAINT CHK_Auto_seisundi_liik_nimetus_ei_ole_tyhi;
ALTER TABLE isiku_seisundi_liik
	ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus,
	DROP CONSTRAINT CHK_Isiku_seisundi_liik_nimetus_ei_ole_tyhi;
ALTER TABLE kliendi_seisundi_liik
	ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus,
	DROP CONSTRAINT CHK_Kliendi_seisundi_liik_nimetus_ei_ole_tyhi;
ALTER TABLE riik
	ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus,
	DROP CONSTRAINT CHK_Riik_nimetus_ei_ole_tyhi;
ALTER TABLE tootaja_seisundi_liik
	ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus,
	DROP CONSTRAINT CHK_Tootaja_seisundi_liik_nimetus_ei_ole_tyhi;