
-- Find all sponsors and amount of euros they use for sponsoring a certain player
-- Hae kaikki tiedot sponsori ja pelaaja -tauluista. 

SELECT * FROM Sponsor
INNER JOIN PlayerSponsor ON Sponsor.sponsor = PlayerSponsor.sponsor
INNER JOIN Player ON Player.player = PlayerSponsor.player
ORDER BY sponsorname DESC;

-- Find player number, first name and last name and player position from a player called Michelle Jones
-- Hae pelaajanumero, etunimi, sukunimi, ja pelipaikka pelaajalta Michelle Jones


SELECT player, firstname, lastname, name AS playerposition FROM Player
INNER JOIN PlayerPosition ON Player.playerposition = PlayerPosition.playerposition
WHERE firstname = 'Michelle' AND lastname = 'Jones';

-- Find player number, first name, last name and amount of euros players are sponsored when the sponsorship contract is active and amount of euros is 2000 or more
-- Hae pelaajanumero, etunimi, sukunimi ja euromäärä pelaajilta, joiden sponsorisopimus on aktiivinen, ja summa on 2000e tai enemmän

SELECT p.player, p.firstname, p.lastname, ps.euros FROM Player p
INNER JOIN PlayerSponsor ps ON p.player = ps.player
WHERE ps.rating = 'A' AND ps.euros >= 2000;

-- Show first name, last name and date of birth of players who have born 1980 or before
-- Hae etunimi, sukunimi ja syntymäaika pelaajilta, jotka ovat syntyneet vuonna 1980 tai aiemmin

SELECT firstname, lastname, birthdate FROM Player
WHERE YEAR (birthdate) <= 1980;

-- Show first name and date of birth of players who are playing positions "Center" or "Small forward"
-- Hae etunimi ja syntymäaika pelaajilta, jotka pelaavat pelipaikoilla "Center" tai "Small forward"

SELECT firstname, birthdate FROM Player
INNER JOIN PlayerPosition ON Player.playerposition = PlayerPosition.playerposition
WHERE name = 'Center' or name = 'Small Forward';

-- Show all sponsors, amount of euros they use for sponsoring, and current status of sponsorship contract
-- Hae kaikki sponsorit, summat, ja tämänhetkinen sopimuksen tila

SELECT sponsorname, euros, rating FROM PlayerSponsor
RIGHT OUTER JOIN Sponsor ON PlayerSponsor.sponsor = Sponsor.sponsor;


-- Subqueries
-- Alikyselyitä

-- Find all players who are playing in the same player position as Christa Mattson.
-- Show players first name, last name and name of the position
-- Etsi kaikki pelaajat jotka pelaavat samalla pelipaikalla kuin Christa Mattson.
-- Näytä tuloksessa pelaajan etunimi, sukunimi, ja pelipaikan nimi

SELECT p.firstname, p.lastname, pp.name AS playerposition FROM Player p
INNER JOIN PlayerPosition pp ON p.playerposition = pp.playerposition
WHERE p.playerposition IN
(SELECT playerposition FROM Player
WHERE firstname = 'Christa' AND lastname = 'Mattson');

-- Find all players who have had a sponsor contract before, but not anymore. 
-- Etsi kaikki pelaajat joilla on ollut sponsorisopimus, mutta ei ole enää

SELECT p.player, firstname, lastname FROM Player p
INNER JOIN PlayerSponsor ps ON ps.player = p.player
WHERE ps.rating = 'V' AND p.player NOT IN
(SELECT player FROM PlayerSponsor ps2 WHERE ps2.ranking='A');

-- Aggregate Functions
-- Koostefunktioita

-- Find how many players are playing in positions as Center, Small Forward and Point Guard? 
-- Kuinka monta pelaajaa pelaa pelipaikoilla Center, Small Forward ja Point Guard?

SELECT COUNT(*) AS lkm FROM Player p
INNER JOIN PlayerPosition pp ON p.playerposition = pp.playerposition
WHERE name IN ('Center', 'Small Forward', 'Point Guard');

-- Find the amount of euros Adidas is using for active sponsorships
-- Kuinka suurella summalla Adidas sponsoroi tällä hetkellä? Tulokseksi tulee yksi numero.

SELECT SUM(summa) FROM Sponsor s
INNER JOIN PlayerSponsor ps ON ps.sponsor = s.sponsor
WHERE s.sponsorname = 'Adidas'  AND ps.tila= 'A';

-- Count the number of players who are playing in positions Center, Small Forward and Point Guard. 
-- Hae pelipaikoilla Center, Small Forward ja Point Guard pelaavien pelaajien määrät pelipaikoittain. Tulosjoukossa on siis pelipaikan nimi ja kyseisellä pelipaikalla pelaavien pelaajien lukumäärä.

SELECT pp.name, COUNT(*) AS lkm FROM Player p
INNER JOIN PlayerPosition pp ON p.playerposition = pp.playerposition
WHERE pp.name IN ('Center', 'Small Forward', 'Point Guard')
GROUP BY pp.name;


-- Find all players, and min and max amount of euros they are receiving from sponsors. Sort results in descending order
-- Hae kaikkien pelaajien nimet ja heidän sponsorisopimusten minimit ja maksimit. Lajittele tulokset nimen mukaan laskevaan järjestykseen.

SELECT p.firstname, p.lastname, MIN(ps.euros) AS min_amount, MAX(ps.euros) AS max_amount FROM Player p
LEFT OUTER JOIN PlayerSponsor ps ON ps.player = p.player
GROUP BY p.firstname, p.lastname -- group by ei voi olla desc tai asc
ORDER BY p.firstname DESC, p.lastname DESC;



-- Find all players who have had a sponsor contract before, but not anymore. Use EXISTS-subquery
-- Hae kaikki sellaiset pelaajat, joilla on ollut sponsorisopimus, mutta ei enää. Käytä EXISTS-alikyselyä.
SELECT p.player, p.firstname, p.lastname FROM Player p
INNER JOIN PlayerSponsor ps ON ps.player = p.player
WHERE ps.ranking = 'V'
AND NOT EXISTS
(SELECT 1 FROM PlayerSponsor ps2
WHERE ps2.ranking = 'A' AND p.player = ps2.player);









