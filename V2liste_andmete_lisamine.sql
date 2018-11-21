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
SELECT * FROM Riik_jsonb;
INSERT INTO Riik (riik_kood, nimetus)
SELECT riik->>'Alpha-3 code' AS riik_kood,
riik->>'English short name lower case' AS nimetus
FROM Riik_jsonb;
/*Loen välisest tabelist JSON formaadis andmed, teisendan need
sobivale kujule ja laadin enda andmebaasi tabelisse Riik.
Koodinäiteid ja viiteid PostgreSQLis JSON formaadis andmetega
töötamise kohta vaadake slaidikomplektist "Andmebaasisüsteemide
Oracle ja PostgreSQL kasutamine" – otsige sealt sõna JSON.*/
SELECT * FROM Riik;
/*Veendun, et andmed on lisatud.*/

CREATE FOREIGN TABLE Isik_jsonb (
isik JSONB )
SERVER minu_testandmete_server_apex;
SELECT * FROM Isik_jsonb;
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
SELECT * FROM Isik; /*Veendun, et andmed on lisatud.*/