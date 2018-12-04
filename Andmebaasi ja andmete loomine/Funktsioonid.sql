CREATE OR REPLACE VIEW aktiivsed_mitteaktiivsed_autod AS
    SELECT auto.auto_kood, auto.nimetus, auto_seisundi_liik.nimetus, 
    auto_mark.nimetus, auto.mudel, auto.valjalaske_aasta, auto.reg_number,
    auto.vin_kood
    FROM auto, auto_seisundi_liik, auto_mark
    WHERE auto.auto_seisundi_liik_kood=auto_seisundi_liik.auto_seisundi_liik_kood AND
    auto.auto_mark_kood=auto_mark.auto_mark_kood;
COMMENT ON VIEW aktiivsed_mitteaktiivsed_autod IS '';

CREATE OR REPLACE VIEW auto_kategooria_omamine_alamparing AS
    SELECT auto.auto_kood, auto_kategooria.nimetus as kategooria
    FROM auto, auto_kategooria, auto_kategooria_omamine
    WHERE auto.auto_kood=auto_kategooria_omamine.auto_kood AND
    auto_kategooria_omamine.auto_kategooria_kood=auto_kategooria.auto_kategooria_kood;
COMMENT ON VIEW auto_kategooria_omamine_alamparing IS '';

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
COMMENT ON VIEW autode_detailid IS '';

CREATE OR REPLACE VIEW autode_koondaruanne AS
    SELECT auto.auto_seisundi_liik_kood, 
    auto_seisundi_liik.nimetus, COUNT(auto_seisundi_liik.nimetus) as hulk
    FROM auto, auto_seisundi_liik
    WHERE auto.auto_seisundi_liik_kood=auto_seisundi_liik.auto_seisundi_liik_kood
    GROUP BY auto.auto_seisundi_liik_kood, auto_seisundi_liik.nimetus;
COMMENT ON VIEW autode_koondaruanne IS '';

CREATE OR REPLACE VIEW koik_autod AS
    SELECT auto.auto_kood, auto.nimetus, auto_seisundi_liik.nimetus as seisund,
    auto_mark.nimetus as mark, auto.mudel, auto.valjalaske_aasta,
    auto.reg_number, auto.vin_kood
    FROM auto, auto_seisundi_liik, auto_mark
    WHERE auto.auto_seisundi_liik_kood=auto_seisundi_liik.auto_seisundi_liik_kood AND
    auto.auto_mark_kood=auto_mark.auto_mark_kood
COMMENT ON VIEW koik_autod IS '';