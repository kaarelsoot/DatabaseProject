--!--
-- Auto registreerimine
CREATE OR REPLACE FUNCTION f_registreeri_auto (
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
  p_mootori_maht auto.mootori_maht%TYPE) 
  RETURNS auto.auto_kood%TYPE AS $$
INSERT INTO auto(
  auto_kood,
  nimetus,
  vin_kood,
  auto_kytuse_liik_kood,
  auto_mark_kood,
  lisaja_id,
  mudel,
  valjalaske_aasta,
  reg_number,
  istekohtade_arv,
  mootori_maht
  ) VALUES (
  p_auto_kood,
  p_nimetus,
  p_vin_kood,
  p_auto_kytuse_liik_kood,
  p_auto_mark_kood,
  p_lisaja_id,
  p_mudel,
  p_valjalaske_aasta,
  p_reg_number,
  p_istekohtade_arv,
  p_mootori_maht
  ) ON CONFLICT DO NOTHING
RETURNING auto_kood;
$$ LANGUAGE SQL SECURITY DEFINER
SET search_path=public, pg_temp;

COMMENT ON FUNCTION f_registreeri_auto (
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
  p_mootori_maht auto.mootori_maht%TYPE)
IS 'Selle funktsiooni abil saab sisestada uue auto.
Funktsioonile vastab operatsioon OP1';

-- Näide funktsiooni kasutamisest
SELECT f_registreeri_auto(
  p_auto_kood:=3,
  p_nimetus:='Volvo V70 2018',
  p_vin_kood:='V123123123123',
  p_auto_kytuse_liik_kood:=2::SMALLINT,
  p_auto_mark_kood:=3::SMALLINT,
  p_lisaja_id:=1,
  p_mudel:='V70',
  p_valjalaske_aasta:=2018::SMALLINT,
  p_reg_number:='777VVV',
  p_istekohtade_arv:=5::SMALLINT,
  p_mootori_maht:=2.500
);

--!--
-- Auto unustamine (peab olema seisundis 'O')
CREATE OR REPLACE FUNCTION f_unusta_auto (
  p_auto_kood auto.auto_kood%TYPE) 
RETURNS VOID AS $$
UPDATE auto SET auto_seisundi_liik_kood='U'
WHERE p_auto_kood = auto.auto_kood
AND auto_seisundi_liik_kood='O'
RETURNING auto_seisundi_liik_kood
;
$$ LANGUAGE sql SECURITY DEFINER
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_unusta_auto (
  p_auto_kood auto.auto_kood%TYPE)
IS 'Selle funktsiooni abil saab auto unustada. 
Eeltingimuseks on, et auto on seisundis Ootel.
Funktsioonile vastab operatsioon OP2';

-- Näide funktsiooni kasutamisest
SELECT f_unusta_auto(p_auto_kood:=3);


--!--
-- Auto aktiveerimine (peab olema seisundis 'A')
CREATE OR REPLACE FUNCTION f_aktiveeri_auto (
  p_auto_kood auto.auto_kood%TYPE) 
RETURNS VOID AS $$
UPDATE auto SET auto_seisundi_liik_kood='A'
WHERE p_auto_kood = auto.auto_kood
AND auto_seisundi_liik_kood IN ('O', 'M')
RETURNING auto_seisundi_liik_kood
;
$$ LANGUAGE sql SECURITY DEFINER
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_aktiveeri_auto (
  p_auto_kood auto.auto_kood%TYPE)
IS 'Selle funktsiooni abil saab auto aktiveerida. 
Eeltingimuseks on, et auto on seisundis Ootel või Mitteaktiivne.
Funktsioonile vastab operatsioon OP3';

-- Näide funktsiooni kasutamisest
SELECT f_aktiveeri_auto(p_auto_kood:=1234);


--!--
-- Auto mitteaktiivseks muutmine (peab olema seisundis 'A')
CREATE OR REPLACE FUNCTION f_muuda_auto_mitteaktiivseks (
  p_auto_kood auto.auto_kood%TYPE) 
RETURNS VOID AS $$
UPDATE auto SET auto_seisundi_liik_kood='M'
WHERE p_auto_kood = auto.auto_kood
AND auto_seisundi_liik_kood='A'
RETURNING auto_seisundi_liik_kood
;
$$ LANGUAGE sql SECURITY DEFINER
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_muuda_auto_mitteaktiivseks (
  p_auto_kood auto.auto_kood%TYPE)
IS 'Selle funktsiooni abil saab muuta auto mitteaktiivseks. 
Eeltingimuseks on, et auto on seisundis Aktiivne.
Funktsioonile vastab operatsioon OP4';

-- Näide funktsiooni kasutamisest
SELECT f_muuda_auto_mitteaktiivseks(p_auto_kood:=1234);


--!--
-- Auto andmete muutmine 
CREATE OR REPLACE FUNCTION f_muuda_auto (
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
  p_mootori_maht auto.mootori_maht%TYPE) 
RETURNS auto.auto_kood%TYPE AS $$
UPDATE auto SET
  auto_kood = p_auto_kood_uus,
  nimetus = p_nimetus,
  vin_kood = p_vin_kood,
  auto_kytuse_liik_kood = p_auto_kytuse_liik_kood,
  auto_mark_kood = p_auto_mark_kood,
  mudel = p_mudel,
  valjalaske_aasta = p_valjalaske_aasta,
  reg_number = p_reg_number,
  istekohtade_arv = p_istekohtade_arv,
  mootori_maht = p_mootori_maht
WHERE auto_kood = p_auto_kood_vana 
AND auto_seisundi_liik_kood IN ('O', 'M')
RETURNING auto_kood;
$$ LANGUAGE SQL SECURITY DEFINER
SET search_path=public, pg_temp;

COMMENT ON FUNCTION f_muuda_auto (
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
  p_mootori_maht auto.mootori_maht%TYPE)
IS 'Selle funktsiooni abil saab muuta auto andmeid. 
Eeltingimuseks, et auto on olekus Ootel või Mitteaktiivne.
Funktsioonile vastab operatsioon OP6';

-- Näide funktsiooni kasutamisest
SELECT f_muuda_auto(
  p_auto_kood_vana:=1234,
  p_auto_kood_uus:=1234,
  p_nimetus:='Audi A6 2018 Bensiin',
  p_vin_kood:='ABC123123123123',
  p_auto_kytuse_liik_kood:=1::SMALLINT,
  p_auto_mark_kood:=1::SMALLINT,
  p_mudel:='A6 Quattro',
  p_valjalaske_aasta:=2018::SMALLINT,
  p_reg_number:='123ABC',
  p_istekohtade_arv:=5::SMALLINT,
  p_mootori_maht:=2.800
);

--!
-- Juhataja autentimise funktsioon
CREATE OR REPLACE FUNCTION f_tuvasta_juhataja(
  p_e_meil text, 
  p_parool text)
RETURNS boolean AS $$
DECLARE rslt boolean;
BEGIN
SELECT INTO rslt (parool = public.crypt(p_parool, parool))
FROM isik 
JOIN tootaja ON isik.isik_id = tootaja.tootaja_id
WHERE Upper(e_meil) = Upper(p_e_meil)
AND amet_kood = 1
AND tootaja_seisundi_liik_kood IN ('T', 'P');
RETURN coalesce(rslt, FALSE);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_tuvasta_autode_haldur(
  p_e_meil text, 
  p_parool text)
IS 'Selle funktsiooni abil toimub juhataja autentimine. 
Funktsiooni esimene argument on kasutajanimi (e-meil).
Funktsiooni teine argument on parool.
Funktsioon tagastab TRUE, kui kasutajanime ja parooliga töötaja eksisteerib
ja tema ametikohaks on Autode haldur ning on seisundis Tööl või Puhkusel,
vastasel juhul tagastatakse FALSE.
Funktsioonile vastab operatsioon OP1.1';

-- Funktsiooni kasutamine
SELECT f_tuvasta_autode_haldur(p_e_meil:='ward.richard@comvoy.co.uk', p_parool:='incididunt');


--!
-- Kliendi autentimise funktsioon (ei lähe meil vaja)
CREATE OR REPLACE FUNCTION f_on_klient(
  p_e_meil text, 
  p_parool text)
RETURNS boolean AS $$
DECLARE rslt boolean;
BEGIN
SELECT INTO rslt (parool = public.crypt(p_parool, parool))
FROM isik 
JOIN klient ON isik.isik_id = klient.klient_id
WHERE Upper(e_meil) = Upper(p_e_meil)
AND kliendi_seisundi_liik_kood = 'A';
RETURN coalesce(rslt, FALSE);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_on_klient(
  p_e_meil text, 
  p_parool text)
IS 'Selle funktsiooni abil toimub kliendi kasutaja autentimine. 
Funktsiooni esimene argument on kasutajanimi (e-meil).
Funktsiooni teine argument on parool.
Funktsioon tagastab TRUE, kui kasutajanime ja parooliga isik eksisteerib
ja on seisundis Aktiivne,
vastasel juhul tagastatakse FALSE.';

SELECT f_on_klient(p_e_meil:='lucile.burgess@frolix.net', p_parool:='laborum');


--!
-- Töötaja autentimise funktsioon (ei lähe meil vaja)
CREATE OR REPLACE FUNCTION f_on_tootaja(
  p_e_meil text, 
  p_parool text)
RETURNS boolean AS $$
DECLARE rslt boolean;
BEGIN
SELECT INTO rslt (parool = public.crypt(p_parool, parool))
FROM isik 
JOIN tootaja ON isik.isik_id = tootaja.tootaja_id
WHERE Upper(e_meil) = Upper(p_e_meil)
AND tootaja_seisundi_liik_kood IN ('T', 'P');
RETURN coalesce(rslt, FALSE);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_on_tootaja(
  p_e_meil text, 
  p_parool text)
IS 'Selle funktsiooni abil toimub töötaja kasutaja autentimine. 
Funktsiooni esimene argument on kasutajanimi (e-meil).
Funktsiooni teine argument on parool.
Funktsioon tagastab TRUE, kui kasutajanime ja parooliga töötaja eksisteerib
ja on seisundis Tööl või Puhkusel,
vastasel juhul tagastatakse FALSE.';

-- Funktsiooni kasutamine
SELECT f_on_tootaja(p_e_meil:='ward.richard@comvoy.co.uk', p_parool:='incididunt');


-- !
-- Kasutaja tuvastamise funktsioon (ei lähe meil vaja)
CREATE OR REPLACE FUNCTION f_on_kasutaja(
  p_e_meil text, 
  p_parool text)
RETURNS boolean AS $$
DECLARE rslt boolean;
BEGIN
SELECT INTO rslt (parool = public.crypt(p_parool, parool))
FROM isik WHERE Upper(e_meil) = Upper(p_e_meil);

RETURN coalesce(rslt, FALSE);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_on_kasutaja(
  p_e_meil text, 
  p_parool text)
IS 'Selle funktsiooni abil toimub kasutaja autentimine. 
Funktsiooni esimene argument on kasutajanimi (e-meil).
Funktsiooni teine argument on parool.
Funktsioon tagastab TRUE, kui kasutajanime ja parooliga isik eksisteerib,
vastasel juhul tagastatakse FALSE.';

-- funktsiooni kasutamine
SELECT f_on_kasutaja(p_e_meil:='ward.richard@comvoy.co.uk', p_parool:='incididunt'); -- returns true


-- TODO: op7 ( Süsteem salvestab auto andmed (op1) ning ükshaaval kõikide kategooriasse kuulumiste andmed (op7). )


-- Juhataja töökohaga seotud funktsioonid:
--!--
-- Auto lõpetamine
CREATE OR REPLACE FUNCTION f_lopeta_auto (
  p_auto_kood auto.auto_kood%TYPE) 
RETURNS VOID AS $$
UPDATE auto SET auto_seisundi_liik_kood='L'
WHERE p_auto_kood = auto.auto_kood
AND auto_seisundi_liik_kood IN ('A', 'M')
RETURNING auto_seisundi_liik_kood
;
$$ LANGUAGE sql SECURITY DEFINER
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_lopeta_auto (
  p_auto_kood auto.auto_kood%TYPE)
IS 'Selle funktsiooni abil saab auto lõpetada. 
Eeltingimuseks on, et auto on seisundis Aktiivne või Mitteaktiivne.
Funktsioonile vastab operatsioon OP5';

-- Näide funktsiooni kasutamisest
SELECT f_lopeta_auto(p_auto_kood:=1234);