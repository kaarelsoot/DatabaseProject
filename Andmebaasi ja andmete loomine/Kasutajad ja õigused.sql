CREATE USER juhataja_t154838 WITH PASSWORD 't154838';

REVOKE CONNECT, TEMP ON DATABASE t154838 FROM PUBLIC;
REVOKE CREATE, USAGE ON SCHEMA public FROM PUBLIC;
REVOKE USAGE ON LANGUAGE plpgsql FROM PUBLIC;

REVOKE EXECUTE ON FUNCTION 
f_registreeri_auto (
    p_auto_kood auto.auto_kood%TYPE,
    p_nimetus auto.nimetus%TYPE,
    p_vin_kood auto.vin_kood%TYPE,
    p_auto_kytuse_liik_kood auto.auto_kytuse_liik_kood%TYPE,
    p_auto_mark_kood auto.auto_mark_kood%TYPE,
    p_lisaja_id auto.lisaja_id%TYPE,
    p_mudel auto.mudel%TYPE,
    p_valjalaske_aasta auto.valjalaske_aasta%TYPE,
    p_reg_number auto.reg_number%TYPE,
    p_istekohtade_arv auto.istekohtade_arv%TYPE,
    p_mootori_maht auto.mootori_maht%TYPE),
f_unusta_auto (
    p_auto_kood auto.auto_kood%TYPE),
f_aktiveeri_auto (
    p_auto_kood auto.auto_kood%TYPE),
f_muuda_auto_mitteaktiivseks (
    p_auto_kood auto.auto_kood%TYPE),
f_muuda_auto (
    p_auto_kood_vana auto.auto_kood%TYPE,
    p_auto_kood_uus auto.auto_kood%TYPE,
    p_nimetus auto.nimetus%TYPE,
    p_vin_kood auto.vin_kood%TYPE,
    p_auto_kytuse_liik_kood auto.auto_kytuse_liik_kood%TYPE,
    p_auto_mark_kood auto.auto_mark_kood%TYPE,
    p_mudel auto.mudel%TYPE,
    p_valjalaske_aasta auto.valjalaske_aasta%TYPE,
    p_reg_number auto.reg_number%TYPE,
    p_istekohtade_arv auto.istekohtade_arv%TYPE,
    p_mootori_maht auto.mootori_maht%TYPE),
f_tuvasta_juhataja(
    p_e_meil text, 
    p_parool text),
f_lopeta_auto (
    p_auto_kood auto.auto_kood%TYPE)
FROM PUBLIC;

REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA public FROM PUBLIC;

GRANT CONNECT ON DATABASE t154838 TO juhataja_t154838;
GRANT USAGE ON SCHEMA public TO juhataja_t154838;

GRANT SELECT ON
aktiivsed_ja_mitteaktiivsed_autod,
koik_autod,
autode_detailandmed,
autode_koondaruanne
TO juhataja_t154838;

GRANT EXECUTE ON FUNCTION
f_tuvasta_juhataja(
    p_e_meil text, 
    p_parool text),
f_lopeta_auto (
    p_auto_kood auto.auto_kood%TYPE)
TO juhataja_t154838;

ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;