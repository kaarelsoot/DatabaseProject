CREATE OR REPLACE VIEW koik_autod AS
    SELECT auto.auto_kood, 
    auto.nimetus AS auto_nimetus, 
    auto_seisundi_liik.nimetus AS auto_seisund, 
    auto_mark.nimetus AS auto_mark, 
    auto.mudel, 
    auto.valjalaske_aasta, 
    auto.reg_number,
    auto.vin_kood
    FROM auto
    INNER JOIN auto_seisundi_liik ON auto.auto_seisundi_liik_kood=auto_seisundi_liik.auto_seisundi_liik_kood
    INNER JOIN auto_mark ON auto.auto_mark_kood=auto_mark.auto_mark_kood;
COMMENT ON VIEW koik_autod 
IS 'Vaade leiab andmed kõikide autode kohta. Vaates näidatakse ka auto hetkeseisundit.';

CREATE OR REPLACE VIEW ootel_ja_mitteaktiivsed_autod AS
    SELECT auto.auto_kood, 
    auto.nimetus AS auto_nimetus, 
    auto_seisundi_liik.nimetus AS auto_seisund, 
    auto_mark.nimetus AS auto_mark, 
    auto.mudel, 
    auto.valjalaske_aasta, 
    auto.reg_number,
    auto.vin_kood
    FROM auto
    INNER JOIN auto_seisundi_liik ON auto.auto_seisundi_liik_kood=auto_seisundi_liik.auto_seisundi_liik_kood
    INNER JOIN auto_mark ON auto.auto_mark_kood=auto_mark.auto_mark_kood
    WHERE auto_seisundi_liik.auto_seisundi_liik_kood IN ('O', 'M');
COMMENT ON VIEW ootel_ja_mitteaktiivsed_autod 
IS 'Vaade leiab andmed kõikide ootel ja mitteaktiivsed autode kohta.. Vaates näidatakse ka auto hetkeseisundit.';

CREATE OR REPLACE VIEW aktiivsed_autod AS
    SELECT auto.auto_kood, 
    auto.nimetus AS auto_nimetus, 
    auto_seisundi_liik.nimetus AS auto_seisund, 
    auto_mark.nimetus AS auto_mark, 
    auto.mudel, 
    auto.valjalaske_aasta, 
    auto.reg_number,
    auto.vin_kood
    FROM auto
    INNER JOIN auto_seisundi_liik ON auto.auto_seisundi_liik_kood=auto_seisundi_liik.auto_seisundi_liik_kood
    INNER JOIN auto_mark ON auto.auto_mark_kood=auto_mark.auto_mark_kood
    WHERE auto_seisundi_liik.auto_seisundi_liik_kood = 'A';
COMMENT ON VIEW aktiivsed_autod 
IS 'Vaade leiab andmed kõikide ootel ja mitteaktiivsed autode kohta.. Vaates näidatakse ka auto hetkeseisundit.';

CREATE OR REPLACE VIEW autode_koondaruanne AS
    SELECT auto.auto_seisundi_liik_kood AS seisundi_kood, 
    Upper(auto_seisundi_liik.nimetus) AS seisundi_nimetus, 
    COUNT(auto_seisundi_liik.nimetus) AS autode_arv
    FROM auto
    INNER JOIN auto_seisundi_liik ON auto.auto_seisundi_liik_kood=auto_seisundi_liik.auto_seisundi_liik_kood
    GROUP BY auto.auto_seisundi_liik_kood, auto_seisundi_liik.nimetus
    ORDER BY autode_arv DESC, seisundi_nimetus ASC;
COMMENT ON VIEW autode_koondaruanne 
IS 'Vaade leiab andmed autode seisunditesse kuuluvuse kohta. Seisundid on sorteeritud autode arvu järgi kahanevalt.
Kui seisunditel on samaväärne arv, siis sorteeritakse suurtähtedega nime järgi tähestiku järjekorras.';

CREATE OR REPLACE VIEW autode_kategooriad AS
    SELECT auto_kategooria_kood, nimetus
    FROM auto_kategooria
    ORDER BY nimetus ASC;
COMMENT ON VIEW autode_kategooriad 
IS 'Vaade leiab andmed võimalike autode kategooriate kohta. 
Vaatele vastab operatsioon OP2.1';


CREATE OR REPLACE VIEW autode_kategooriatesse_kuulumine AS
    SELECT auto.auto_kood, 
    auto_kategooria.nimetus as kategooria,
    auto_kategooria_tyyp.nimetus as kategooria_tyyp
    FROM auto
    INNER JOIN auto_kategooria_omamine ON auto.auto_kood=auto_kategooria_omamine.auto_kood
    INNER JOIN auto_kategooria ON auto_kategooria_omamine.auto_kategooria_kood=auto_kategooria.auto_kategooria_kood
    INNER JOIN auto_kategooria_tyyp ON auto_kategooria_tyyp.auto_kategooria_tyyp_kood=auto_kategooria.auto_kategooria_tyyp_kood;
COMMENT ON VIEW autode_kategooriasse_kuulumine 
IS 'Vaade leiab andmed autode kategooriatesse kuulumise kohta. Iga kategooria juures on ka sellele vastava tüübi nimetus.
Vaatele vastab operatsioon OP2.2';

CREATE OR REPLACE VIEW autode_detailid AS
    SELECT auto.auto_kood, auto.nimetus, auto_mark.nimetus as mark, auto.mudel,
    auto.valjalaske_aasta, auto.mootori_maht, auto_kytuse_liik.nimetus as kytus,
    auto.istekohtade_arv, auto.reg_number, auto.vin_kood, auto.reg_aeg,
    isik.eesnimi ||' '|| isik.perenimi ||' '|| isik.e_meil AS registreerija,
    auto_seisundi_liik.nimetus as seisund
    FROM auto, auto_seisundi_liik, auto_mark, auto_kytuse_liik, isik
    WHERE auto.auto_seisundi_liik_kood=auto_seisundi_liik.auto_seisundi_liik_kood AND
    auto.auto_mark_kood=auto_mark.auto_mark_kood AND
    auto.auto_kytuse_liik_kood=auto_kytuse_liik.auto_kytuse_liik_kood AND
    auto.lisaja_id=isik.isik_id;
COMMENT ON VIEW autode_detailid 
IS '';