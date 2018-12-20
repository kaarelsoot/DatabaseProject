CREATE OR REPLACE FUNCTION f_auto_seisundimuutuse_kontroll() RETURNS
TRIGGER AS $$
BEGIN
RAISE EXCEPTION 'Soovitud seisundimuudatust ei või teostada';
RETURN NULL;
END; $$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public, pg_temp;
COMMENT ON FUNCTION f_auto_seisundimuutuse_kontroll ()
IS 'Selle trigeri funktsiooni abil toimub auto seisundimuutuse kontrollimine.
Triger keelab andmebaasi tasemel ärireeglitega vastuolus olevate seisundimuutuste teostamist.';

DROP TRIGGER IF EXISTS t_auto_seisundimuutuse_kontroll ON auto;
CREATE TRIGGER t_auto_seisundimuutuse_kontroll
BEFORE UPDATE OF auto_seisundi_liik_kood ON auto
FOR EACH ROW
    WHEN (
        NOT(OLD.auto_seisundi_liik_kood=NEW.auto_seisundi_liik_kood
        OR (OLD.auto_seisundi_liik_kood='A' OR OLD.auto_seisundi_liik_kood='M') 
        AND NEW.auto_seisundi_liik_kood='L'
        OR OLD.auto_seisundi_liik_kood='M'AND NEW.auto_seisundi_liik_kood='A'
        OR OLD.auto_seisundi_liik_kood='A'AND NEW.auto_seisundi_liik_kood='M')
    )
    EXECUTE FUNCTION f_auto_seisundimuutuse_kontroll();


CREATE OR REPLACE FUNCTION f_auto_unustamise_kontroll() RETURNS
TRIGGER AS $$
BEGIN
RAISE EXCEPTION 'Autot võib unustada vaid "ootel" seisundist';
RETURN NULL;
END; $$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public, pg_temp;
COMMENT ON FUNCTION f_auto_unustamise_kontroll ()
IS 'Selle trigeri funktsiooni abil toimub auto kustutamise legaalsuse kontrollimine.
Eeltingimuseks on, et auto on seisundis Ootel.';

DROP TRIGGER IF EXISTS t_auto_unustamise_kontroll ON auto;
CREATE TRIGGER t_auto_unustamise_kontroll
BEFORE DELETE ON auto
FOR EACH ROW
    WHEN ( NOT(OLD.auto_seisundi_liik_kood='O') )
    EXECUTE FUNCTION f_auto_unustamise_kontroll();