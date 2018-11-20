INSERT INTO amet (amet_kood, nimetus, kirjeldus)
VALUES 
(1, 'Juhataja', 'Juhib organisatsiooni igapäevast tööd ning langetab strateegilisi otsuseid'), 
(2, 'Klienditeenindaja', 'Teenindab kliente ja lahendab klientide igapäevaseid küsimusi'), 
(3, 'Autode haldur', 'Tegeleb autode sisseostu, ettevalmistamise organiseerimisega rendiks ja suhtleb remonditöökodadega');

INSERT INTO isiku_seisundi_liik (isiku_seisundi_liik_kood, nimetus)
VALUES ('E', 'Elus'), ('S', 'Surnud');

INSERT INTO kliendi_seisundi_liik (kliendi_seisundi_liik_kood, nimetus)
VALUES ('A', 'Aktiivne'), ('M', 'Mustas nimekirjas'), ('O', 'Ootel'), ('K', 'Kustutatud');

INSERT INTO tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)
VALUES ('T', 'Tööl'), ('P', 'Puhkusel'), ('M', 'Mitteaktiivne');

INSERT INTO riik (riik_kood, nimetus)
VALUES ('EST', 'Eesti'), ('DEU', 'Saksamaa'), ('FIN', 'Soome');

INSERT INTO auto_seisundi_liik (auto_seisundi_liik_kood, nimetus)
VALUES ('O', 'Ootel'), ('A', 'Aktiivne'), ('M', 'Mitteaktiivne'), ('U', 'Unustatud'), ('L', 'Lõpetatud');

INSERT INTO auto_kytuse_liik (auto_kytuse_liik_kood, nimetus)
VALUES (1, 'Bensiin'), (2, 'Diisel'), (3, 'Elekter'), (4, 'Gaas');

INSERT INTO auto_mark (auto_mark_kood, nimetus)
VALUES (1, 'Audi'), (2, 'Peugeot'), (3, 'Volvo'), (4, 'Tesla'), (5, 'Renault');

INSERT INTO auto_kategooria_tyyp (auto_kategooria_tyyp_kood, nimetus)
VALUES (1, 'Sihtgrupp'), (2, 'Keretüüp');

INSERT INTO auto_kategooria (auto_kategooria_kood, nimetus, auto_kategooria_tyyp_kood)
VALUES (1, 'Pereauto', 1), (2, 'Väikeauto', 1), (3, 'Väikeklass', 2), (4, 'Keskklass', 2), (5, 'Luksusauto', 2), (6, 'Maastur', 2), (7, 'Tarbesõiduk', 2);

INSERT INTO isik (e_meil, isikukood, riik_kood, isiku_seisundi_liik_kood, synni_kp, parool, eesnimi, perenimi, elukoht)
VALUES ('juhanmartens@cool.ee', '38711542746', 'EST', 'E', '12.01.1971', 'ajeeMaOlenParoolSuperKrypto8)', 'Juhan', 'Martens', 'Rapla'),
('klient@cool.ee', '38711542745', 'EST', 'E', '12.01.1970', 'ajeeMaOlenParoolSuperKrypto8)', 'Klient', 'Martens', 'Rapla');

INSERT INTO klient (klient_id, kliendi_seisundi_liik_kood, on_nous_tylitamisega)
VALUES (2, 'A', False);

INSERT INTO tootaja (tootaja_id, amet_kood, tootaja_seisundi_liik_kood)
VALUES (1, 2, 'T');

INSERT INTO auto (auto_kood, nimetus, vin_kood, auto_kytuse_liik_kood, auto_mark_kood, auto_seisundi_liik_kood, lisaja_id, mudel, valjalaske_aasta, reg_number, istekohtade_arv, mootori_maht)
VALUES (1234, 'Audi A6 2018', 'ABC123123123123', 1, 1, 'A', 1, 'A6', 2018, '123ABC', 5, 2.8), (1235, 'Peugeot Boxer 2018 kaubik', 'ABC123123123555', 2, 2, 'A', 1, 'Boxer', 2018, '456DEF', 3, 2.0);

INSERT INTO auto_kategooria_omamine (auto_kood, auto_kategooria_kood) 
VALUES (1234, 1), (1235, 2);
