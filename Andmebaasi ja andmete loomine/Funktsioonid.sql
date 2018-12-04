--!--
-- Auto margi sisetamine (seda probably vaja ei lähe - tegin, et harjutada funktsiooni kirjutamist)
CREATE OR REPLACE FUNCTION f_lisa_auto_mark (
  p_auto_mark_kood auto_mark.auto_mark_kood%TYPE, 
  p_nimetus auto_mark.nimetus%TYPE) 
  RETURNS auto_mark.auto_mark_kood%TYPE AS $$
INSERT INTO auto_mark(auto_mark_kood, nimetus) VALUES
(p_auto_mark_kood, p_nimetus) ON CONFLICT DO NOTHING
RETURNING auto_mark_kood;
$$ LANGUAGE SQL SECURITY DEFINER
SET search_path=public, pg_temp;

COMMENT ON FUNCTION f_lisa_auto_mark (
  p_auto_mark_kood auto_mark.auto_mark_kood%TYPE, 
  p_nimetus auto_mark.nimetus%TYPE) 
  IS 'Selle funktsiooni abil saab sisestada uue auto margi';
-- Näide kasutamisest
SELECT f_lisa_auto_mark(p_auto_mark_kood:=7::SMALLINT, p_nimetus:='Toyota');


--!--
-- Auto registreerimine
CREATE OR REPLACE FUNCTION f_lisa_auto (
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

-- Näide funktsiooni kasutamisest
SELECT f_lisa_auto(
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

COMMENT ON FUNCTION f_lisa_auto (
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
IS 'Selle funktsiooni abil saab sisestada uue auto';

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
Eeltingimuseks on, et auto on seisundis Ootel';

-- Näide funktsiooni kasutamisest
SELECT f_unusta_auto(p_auto_kood:=3);
