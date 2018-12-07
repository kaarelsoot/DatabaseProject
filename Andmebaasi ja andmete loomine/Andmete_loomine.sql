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
VALUES (1, 'Audi'), (2, 'Peugeot'), (3, 'Volvo'), (4, 'Tesla'), (5, 'Renault');

INSERT INTO auto_kategooria_tyyp (auto_kategooria_tyyp_kood, nimetus)
VALUES (1, 'Sihtgrupp'), (2, 'Keretüüp');

INSERT INTO auto_kategooria (auto_kategooria_kood, nimetus, auto_kategooria_tyyp_kood)
VALUES (1, 'Pereauto', 1), (2, 'Väikeauto', 1), (3, 'Väikeklass', 2), (4, 'Keskklass', 2), (5, 'Luksusauto', 2), (6, 'Maastur', 2), (7, 'Tarbesõiduk', 2);

CREATE EXTENSION IF NOT EXISTS postgres_fdw;
/*Lisan andmebaasi väliste andmete pakendamise laienduse, mis
võimaldab PostgreSQL andmebaasis lugeda andmeid teisest
PostgreSQL andmebaasist (võib olla samas serveris või teises
serveris) ja neid seal ka muuta (seda viimast pole antud
ülesandes vaja teha).
https://robots.thoughtbot.com/postgres-foreign-data-wrapper
PostgreSQL väliste tabelite mehhanism võimaldab juurdepääsu
erinevat tüüpi failide sisule, aga ka juurdepääsu andmetele, mis
on teistes andmebaasides (võimalik, et teine
andmebaasisüsteem/andmemudel), veebis, infokataloogides jne.
Vaadake PostgreSQL erinevaid väliste andmete pakendajaid:
https://wiki.postgresql.org/wiki/Foreign_data_wrappers */
CREATE SERVER minu_testandmete_server_apex FOREIGN DATA WRAPPER
postgres_fdw OPTIONS (host 'apex.ttu.ee', dbname 'testandmed',
port '5432');
/*Testandmed on apex.ttu.ee serveris andmebaasis testandmed.
Viite loomine väliste andmete asukohale. Seda lauset pole vaja
muuta!*/
CREATE USER MAPPING FOR t154838 SERVER
minu_testandmete_server_apex OPTIONS (user 't154838', password
'piimaKruus07');
/*Vastavuse defineerimine kohaliku andmebaasi kasutaja ning
selles käskude käivitaja ja välise andmebaasi kasutaja vahel.
Kui teete rühmatööd, siis võite luua ühe sellise vastavuse iga
rühma liikme kohta. Kohaliku ja välise kasutaja nimi langevad
praegu kokku, sest andmebaasid on samas serveris. Siin lauses
kasutage oma apex.ttu.ee kasutajanime ja parooli!*/
CREATE FOREIGN TABLE Riik_jsonb (
riik JSONB )
SERVER minu_testandmete_server_apex;
/*Loon välise tabeli, mis viitab teises andmebaasis olevale
tabelile, kus riikide andmed on JSON formaadis. Lähteandmed
pärinevad: https://gist.github.com/jeremybuis/4997305
psqlis on väliste tabelite nimekirja nägemiseks käsk \det */
INSERT INTO Riik (riik_kood, nimetus)
SELECT riik->>'Alpha-3 code' AS riik_kood,
riik->>'English short name lower case' AS nimetus
FROM Riik_jsonb;
/*Loen välisest tabelist JSON formaadis andmed, teisendan need
sobivale kujule ja laadin enda andmebaasi tabelisse Riik.
Koodinäiteid ja viiteid PostgreSQLis JSON formaadis andmetega
töötamise kohta vaadake slaidikomplektist "Andmebaasisüsteemide
Oracle ja PostgreSQL kasutamine" – otsige sealt sõna JSON.*/
/*Veendun, et andmed on lisatud.*/

CREATE FOREIGN TABLE Isik_jsonb (
isik JSONB )
SERVER minu_testandmete_server_apex;
/*Sellesse tabelisse andmete genereerimiseks kasutasin:
https://www.json-generator.com/ */
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
/*Loen välisest tabelist JSON formaadis andmed, teisendan need
sobivale kujule ja laadin enda andmebaasi tabelisse Isik. Loen
andmeid ainult isikute kohta, kes on seisundis koodiga 1 e
elus.*/

INSERT INTO klient (klient_id, kliendi_seisundi_liik_kood, on_nous_tylitamisega)
VALUES (2, 'A', False);

INSERT INTO tootaja (tootaja_id, amet_kood, tootaja_seisundi_liik_kood)
VALUES (1, 3, 'T');

INSERT INTO auto (auto_kood, nimetus, vin_kood, auto_kytuse_liik_kood, auto_mark_kood, auto_seisundi_liik_kood, lisaja_id, mudel, valjalaske_aasta, reg_number, istekohtade_arv, mootori_maht)
VALUES (1234, 'Audi A6 2018', 'ABC123123123123', 1, 1, 'A', 1, 'A6', 2018, '123ABC', 5, 2.8), (1235, 'Peugeot Boxer 2018 kaubik', 'ABC123123123555', 2, 2, 'A', 1, 'Boxer', 2018, '456DEF', 3, 2.0);

INSERT INTO auto_kategooria_omamine (auto_kood, auto_kategooria_kood) 
VALUES (1234, 1), (1235, 2);
