-- installeerib krüpto mooduli
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;

-- räsib paroolid
UPDATE isik 
SET parool = public.crypt(parool, public.gen_salt('bf', 11));

-- loob uue constrainti tõstutundetu kasutajanime jaoks
ALTER TABLE isik
DROP CONSTRAINT ak_isik_e_meil;

CREATE UNIQUE INDEX ak_isik_e_meil
ON isik (Upper(e_meil));
