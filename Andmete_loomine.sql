INSERT INTO "Amet" (amet_kood, nimetus, kirjeldus)
VALUES (1, 'Juhataja', 'On tähtis nina'), (2, 'Klienditeenindaja', 'Kuulab ja sekeldab');

INSERT INTO "Isiku_seisundi_liik" (isiku_seisundi_liik_kood, nimetus)
VALUES ('E', 'Elus'), ('S', 'Surnud');

INSERT INTO "Kliendi_seisundi_liik" (kliendi_seisundi_liik_kood, nimetus)
VALUES ('A', 'Aktiivne'), ('M', 'Mustas nimekirjas');

INSERT INTO "Tootaja_seisundi_liik" (tootaja_seisundi_liik_kood, nimetus)
VALUES ('T', 'Tööl'), ('P', 'Puhkusel');

INSERT INTO "Riik" (riik_kood, nimetus)
VALUES ('EST', 'Eesti'), ('DEU', 'Saksamaa'), ('FIN', 'Soome');

INSERT INTO "Auto_seisundi_liik" (auto_seisundi_liik_kood, nimetus)
VALUES ('V', 'Vaba'), ('K', 'Kinni');

INSERT INTO "Auto_kytuse_liik" (auto_kytuse_liik_kood, nimetus)
VALUES (1, 'Bensiin'), (2, 'Diisel');

INSERT INTO "Auto_mark" (auto_mark_kood, nimetus)
VALUES (1, 'Audi'), (2, 'Peugeot');

INSERT INTO "Auto_kategooria_tyyp" (auto_kategooria_tyyp_kood, nimetus)
VALUES (1, 'Sihtgrupp');

INSERT INTO "Auto_kategooria" (auto_kategooria_kood, nimetus, auto_kategooria_tyyp_kood)
VALUES (1, 'Pereauto', 1), (2, 'Väikeauto', 1);

INSERT INTO "Isik" (e_meil, isikukood, riik_kood, isiku_seisundi_liik_kood, synni_kp, parool, eesnimi, perenimi, elukoht)
VALUES ('juhanmartens@cool.ee', '38711542746', 'EST', 'E', '12.01.1971', 'ajeeMaOlenParoolSuperKrypto8)', 'Juhan', 'Martens', 'Rapla'),
('klient@cool.ee', '38711542745', 'EST', 'E', '12.01.1970', 'ajeeMaOlenParoolSuperKrypto8)', 'Klient', 'Martens', 'Rapla');

INSERT INTO "Klient" (isik_id, kliendi_seisundi_liik_kood, on_nous_tylitamisega)
VALUES (2, 'A', False);

INSERT INTO "Tootaja" (isik_id, amet_kood, tootaja_seisundi_liik_kood)
VALUES (1, 2, 'T');

INSERT INTO "Auto" (auto_kood, nimetus, vin_kood, auto_kytuse_liik_kood, auto_mark_kood, auto_seisundi_liik_kood, isik_id, mudel, valjalaske_aasta, reg_number, istekohtade_arv, mootori_maht)
VALUES (1234, 'Audi A6 2018', 'ABC123123123123', 1, 1, 1, 1, 'A6', 2018, '123ABC', 5, 2.8)