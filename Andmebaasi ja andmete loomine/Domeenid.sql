CREATE DOMAIN d_reg_aeg
TIMESTAMP NOT NULL DEFAULT LOCALTIMESTAMP(0)
CONSTRAINT chk_d_reg_aeg_vahemik CHECK (VALUE BETWEEN '2010-01-01 00:00:00' AND '2099-01-01 23:59:59');

ALTER TABLE isik
ALTER COLUMN reg_aeg TYPE d_reg_aeg;
ALTER TABLE auto
ALTER COLUMN reg_aeg TYPE d_reg_aeg;

CREATE DOMAIN d_klassifikaatori_nimetus
VARCHAR(50) NOT NULL
CONSTRAINT chk_klassifikaatori_nimetus_ei_ole_tyhi CHECK (btrim(nimetus::text) <> ''::text);

ALTER TABLE amet
ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus;
ALTER TABLE auto_kategooria
ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus;
ALTER TABLE auto_kategooria_tyyp
ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus;
ALTER TABLE auto_kytuse_liik
ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus;
ALTER TABLE auto_mark
ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus;
ALTER TABLE auto_seisundi_liik
ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus;
ALTER TABLE isiku_seisundi_liik
ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus;
ALTER TABLE kliendi_seisundi_liik
ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus;
ALTER TABLE riik
ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus;
ALTER TABLE tootaja_seisundi_liik
ALTER COLUMN nimetus TYPE d_klassifikaatori_nimetus;