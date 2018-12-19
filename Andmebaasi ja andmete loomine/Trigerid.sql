-- Triger selle kohta, et auto seisundi muudatus oleks legaalne.

CREATE OR REPLACE FUNCTION f_auto_seisundimuutuse_kontroll() RETURNS
TRIGGER AS $$
BEGIN
IF 
    NOT(OLD.auto_seisundi_liik_kood=NEW.auto_seisundi_liik_kood
    OR (OLD.auto_seisundi_liik_kood='A' OR OLD.auto_seisundi_liik_kood='M') 
    AND NEW.auto_seisundi_liik_kood='L'
    OR OLD.auto_seisundi_liik_kood='M'AND NEW.auto_seisundi_liik_kood='A'
    OR OLD.auto_seisundi_liik_kood='A'AND NEW.auto_seisundi_liik_kood='M')
THEN
    RAISE EXCEPTION 'Soovitud seisundimuudatust ei või teostada';
END IF;
RETURN NEW;
END; $$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public, pg_temp;

DROP TRIGGER IF EXISTS t_auto_seisundimuutuse_kontroll ON auto;
CREATE TRIGGER t_auto_seisundimuutuse_kontroll
BEFORE UPDATE OF auto_seisundi_liik_kood ON auto
FOR EACH ROW
    EXECUTE FUNCTION f_auto_seisundimuutuse_kontroll();

-- Triger selle kohta, et auto saab lisada vaid seisundis 'O'.

-- Triger selle kohta, et auto lisajat ja liaatud aega ei saa muuta.

-- Triger selle kohta, et auto on määratud vähemalt ühte auto kategooriasse.

-- Triger selle kohta, et autot saab kustutada vaid seisundist 'O'

CREATE OR REPLACE FUNCTION f_auto_unustamise_kontroll() RETURNS
TRIGGER AS $$
BEGIN
IF 
    NOT(OLD.auto_seisundi_liik_kood='O')
THEN
    RAISE EXCEPTION 'Autot võib unustada vaid "ootel" seisundist';
END IF;
RETURN NEW;
END; $$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public, pg_temp;

DROP TRIGGER IF EXISTS t_auto_unustamise_kontroll ON auto;
CREATE TRIGGER t_auto_unustamise_kontroll
BEFORE DELETE ON auto
FOR EACH ROW
    EXECUTE FUNCTION f_auto_unustamise_kontroll();