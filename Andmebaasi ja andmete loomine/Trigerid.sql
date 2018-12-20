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
COMMENT ON FUNCTION f_auto_seisundimuutuse_kontroll (
    p_auto_kood auto.auto_kood%TYPE)
IS 'Selle trigeri funktsiooni abil toimub auto seisundimuutuse kontrollimine.
 
Eeltingimuseks on, et auto on seisundis Aktiivne või Mitteaktiivne.
Funktsioonile vastab operatsioon OP5';

DROP TRIGGER IF EXISTS t_auto_seisundimuutuse_kontroll ON auto;
CREATE TRIGGER t_auto_seisundimuutuse_kontroll
BEFORE UPDATE OF auto_seisundi_liik_kood ON auto
FOR EACH ROW
    EXECUTE FUNCTION f_auto_seisundimuutuse_kontroll();

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