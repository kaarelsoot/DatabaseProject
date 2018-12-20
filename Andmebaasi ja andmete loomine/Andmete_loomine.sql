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

INSERT INTO auto_seisundi_liik (auto_seisundi_liik_kood, nimetus)
VALUES ('O', 'Ootel'), ('A', 'Aktiivne'), ('M', 'Mitteaktiivne'), ('U', 'Unustatud'), ('L', 'Lõpetatud');

INSERT INTO auto_kytuse_liik (auto_kytuse_liik_kood, nimetus)
VALUES (1, 'Bensiin'), (2, 'Diisel'), (3, 'Elekter'), (4, 'Gaas');

INSERT INTO auto_mark (auto_mark_kood, nimetus)
VALUES (1, 'Audi'), (2, 'Peugeot'), (3, 'Volvo'), (4, 'Jeep'), (5, 'Renault');

INSERT INTO auto_kategooria_tyyp (auto_kategooria_tyyp_kood, nimetus)
VALUES (1, 'Sihtgrupp'), (2, 'Keretüüp');

INSERT INTO auto_kategooria (auto_kategooria_kood, nimetus, auto_kategooria_tyyp_kood)
VALUES (1, 'Pereauto', 1), (2, 'Sportauto', 1), (3, 'Väikeklass', 2), (4, 'Keskklass', 2), (5, 'Luksusauto', 2), (6, 'Maastur', 2), (7, 'Tarbesõiduk', 2);

CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER minu_testandmete_server_apex FOREIGN DATA WRAPPER
postgres_fdw OPTIONS (host 'apex.ttu.ee', dbname 'testandmed',
port '5432');

CREATE USER MAPPING FOR t154838 SERVER
minu_testandmete_server_apex OPTIONS (user 't154838', password
'piimaKruus07');

CREATE FOREIGN TABLE Riik_jsonb (
riik JSONB )
SERVER minu_testandmete_server_apex;

INSERT INTO Riik (riik_kood, nimetus)
SELECT riik->>'Alpha-3 code' AS riik_kood,
riik->>'English short name lower case' AS nimetus
FROM Riik_jsonb;

CREATE FOREIGN TABLE Isik_jsonb (
isik JSONB )
SERVER minu_testandmete_server_apex;
INSERT INTO isik (e_meil, isikukood, riik_kood, synni_kp, parool, eesnimi, perenimi, elukoht)
SELECT e_mail, isikukood, riik_kood, synni_kp::date, parool, eesnimi, perenimi, elukoht
FROM (SELECT isik->>'riik' AS riik_kood,
jsonb_array_elements(isik->'isikud')->>'isikukood' AS isikukood,
jsonb_array_elements(isik->'isikud')->>'eesnimi' AS eesnimi,
jsonb_array_elements(isik->'isikud')->>'perekonnanimi' AS
perenimi,
jsonb_array_elements(isik->'isikud')->>'email' AS e_mail,
jsonb_array_elements(isik->'isikud')->>'synni_aeg' AS synni_kp,
jsonb_array_elements(isik->'isikud')->>'seisund' AS
isiku_seisundi_liik_kood,
jsonb_array_elements(isik->'isikud')->>'parool' AS parool,
jsonb_array_elements(isik->'isikud')->>'aadress' AS elukoht
FROM isik_jsonb) AS lahteandmed
WHERE isiku_seisundi_liik_kood::smallint=1;

INSERT INTO klient (klient_id, kliendi_seisundi_liik_kood, on_nous_tylitamisega)
VALUES (2, 'A', False), (6, 'A', True), (7, 'O', False), (8, 'M', False), (9, 'A', True);

INSERT INTO tootaja (tootaja_id, amet_kood, tootaja_seisundi_liik_kood)
VALUES (1, 1, 'T'), (3, 3, 'T'), (4, 2, 'T'), (5, 3, 'P');

INSERT INTO auto (auto_kood, nimetus, vin_kood, auto_kytuse_liik_kood, auto_mark_kood, auto_seisundi_liik_kood, lisaja_id, mudel, valjalaske_aasta, reg_number, istekohtade_arv, mootori_maht)
VALUES 
(1234, 'Audi A6 2018', '2B4GP25R2XR275217', 1, 1, 'A', 3, 'A6', 2018, '123ABC', 5, 2.8), 
(1235, 'Peugeot Boxer 2018 kaubik', '1NPXD49X78D754410', 2, 2, 'A', 3, 'Boxer', 2018, '456DEF', 3, 2.0),
(1236, 'Peugeot 208 2018', '1GBJC34J4TE134215', 1, 2, 'O', 3, '208', 2018, '777XCD', 5, 1.6),
(1237, 'Jeep Grand Cherokee 2017', 'YS3CF48W0S1006270', 2, 4, 'M', 3, 'Grand Cherokee', 2017, '999FFF', 5, 3.0);

INSERT INTO auto_kategooria_omamine (auto_kood, auto_kategooria_kood) 
VALUES (1234, 1), (1234, 4), (1235, 7), (1236, 1), (1236, 3), (1237, 6);
