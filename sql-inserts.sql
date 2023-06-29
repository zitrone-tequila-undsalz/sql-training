USE basketball;
DELETE FROM PlayerSponsor;
DELETE FROM Sponsor;
DELETE FROM Player;
DELETE FROM PlayerPosition;

INSERT INTO PlayerPosition(playerposition, name) VALUES
(1, 'Point Guard'),
(2, 'Shoot Guard'),
(3, 'Small Forward'),
(4, 'Power Forward'),
(5, 'Center');

INSERT INTO Player(player, firstname, lastname, birthdate, playernum, height, weight, playerposition) VALUES
(1, 'Susan', 'Berg', '1984-04-11', 1, 180, 76, 1),
(2, 'Christa', 'Mattson', '1970-09-18', 10, 210, 113, 3),
(3, 'Michelle', 'Jones', '1987-01-26', 3, 188, 90, 1),
(4, 'Ann-Marie', 'Nellson', '1968-02-26', NULL, 166, 70, 5),
(5, 'Sofia', 'Taylor', '1990-02-13', NULL, NULL, NULL, 2),
(6, 'Iris', 'Brown', '1977-09-10', 99, 205, 100, 5),
(7, 'Kelly', 'Bosworth', '1982-04-04', NULL, NULL, NULL, 5);

INSERT INTO Sponsor(sponsor, sponsorname) VALUES
(1, 'British business group'),
(2, 'Wilson'),
(3, 'Adidas'),
(4, 'Basketball and clothes');

INSERT INTO PlayerSponsor(playersponsor, player, sponsor, euros, rating) VALUES
(1, 4, 2, 1000, 'A'),
(2, 5, 1, 2000, 'A'),
(3, 2, 2, 3000, 'A'),
(4, 2, 2, 2500, 'V'),
(5, 7, 4, 100, 'V');