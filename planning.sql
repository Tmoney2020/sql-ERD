createdb MusicDataBase

pgcli MusicDataBase

-- need to drop the original tables and add these
CREATE TABLE "Albums"
(
  "Id"            SERIAL PRIMARY KEY,
  "Title"         TEXT,
  "IsExplicit"    BOOLEAN,
  "ReleaseDate"   DATE
);


CREATE TABLE "Bands"
(
"Id"                      SERIAL PRIMARY KEY,
"Name"                    TEXT,
"CountryOfOrigin"         TEXT,
"NumberOfMembers"         INT,
"Website"                 TEXT,
"Style"                   TEXT,
"IsSigned"                BOOLEAN,
"ContactName"             TEXT,
"ContactPhoneNumber"      INT
);


-- Add ERD relationships that show:
--  One Band has many Albums
ALTER TABLE "Albums" ADD COLUMN "BandId" INTEGER NULL REFERENCES "Bands" ("Id");

--  Add a new band
INSERT INTO "Bands" ("Name", "CountryOfOrigin", "NumberOfMembers", "Website", "Style", "IsSigned", "ContactName", "ContactPhoneNumber")
VALUES ('The Band', 'Canada', 5, 'wwww.TheBand.com', 'Rock & Roll', 'True', 'Robbie Robertson', 5557777);

--  View all the bands
SELECT * FROM "Bands"

--  Add an album for a band
INSERT INTO "Albums" ("Title", "IsExplicit", "ReleaseDate")
VALUES ('Stage Fright', 'No', '1970-08-17');

--  Let a band go (update isSigned to false)
UPDATE "Bands" SET "IsSigned" = False WHERE "Id" = 1;

--  Resign a band (update isSigned to true)
UPDATE "Bands" SET "IsSigned" = True WHERE "Id" = 1;

--  Given a band name, view all their albums
UPDATE "Albums" SET "BandId" = 1 WHERE "Id" in (1);

SELECT *
FROM "Albums"
Join "Bands" ON "Albums"."BandId" = "Bands"."Id";

--  View all albums ordered by ReleaseDate
INSERT INTO "Albums" ("Title", "IsExplicit", "ReleaseDate")
VALUES ('Rage Against the Machine', 'True', '1992-11-03');


SELECT * FROM "Albums" ORDER BY "ReleaseDate" DESC;


--  View all bands that are signed
INSERT INTO "Bands" ("Name", "CountryOfOrigin", "NumberOfMembers", "Website", "Style", "IsSigned", "ContactName", "ContactPhoneNumber")
VALUES ('Rage Against the Machine', 'USA', 4, 'wwww.RageAginstTheMachine.com', 'Rock', False, 'Tom Moorello', 2983309);

UPDATE "Albums" SET "BandId" = 2 WHERE "Id" in (2);


SELECT "Name" FROM "Bands" WHERE "IsSigned" = True;

--  View all bands that are not signed
SELECT "Name" FROM "Bands" WHERE "IsSigned" = False;



-- Creating the Band table 
INSERT INTO "Bands" ("Name", "CountryOfOrigin", "NumberOfMembers", "Website", "Style", "IsSigned", "ContactName", "ContactPhoneNumber")
VALUES ('The Band', 'Canada', 5, 'wwww.TheBand.com', 'Rock & Roll', True, 'Robbie Robertson', 5557777);

INSERT INTO "Bands" ("Name", "CountryOfOrigin", "NumberOfMembers", "Website", "Style", "IsSigned", "ContactName", "ContactPhoneNumber")
VALUES ('Rage Against the Machine', 'USA', 4, 'wwww.RageAginstTheMachine.com', 'Rock', False, 'Tom Moorello', 2983309);

INSERT INTO "Bands" ("Name", "CountryOfOrigin", "NumberOfMembers", "Website", "Style", "IsSigned", "ContactName", "ContactPhoneNumber")
VALUES ('Pink Floyd', 'USA', 5, 'www.PinkFloyd.com', 'Psychedelic Rock', False, 'David Gilmore', 9845490); 

INSERT INTO "Bands" ("Name", "CountryOfOrigin", "NumberOfMembers", "Website", "Style", "IsSigned", "ContactName", "ContactPhoneNumber")
VALUES ('Metallica', 'USA', 4, 'wwww.Metallica.com', 'Metal', False, 'Lars Ulrich', 8469347);


INSERT INTO "Bands" ("Name", "CountryOfOrigin", "NumberOfMembers", "Website", "Style", "IsSigned", "ContactName", "ContactPhoneNumber")
VALUES ('Foo Fighters', 'USA', 6, 'wwww.FooFighters.com', 'Rock', True, 'Dave Grohl', 3453763);


-- creating the album table
INSERT INTO "Albums" ("Title", "IsExplicit", "ReleaseDate")
VALUES ('Stage Fright', False, '1970-08-17');

INSERT INTO "Albums" ("Title", "IsExplicit", "ReleaseDate")
VALUES ('Rage Against the Machine', True, '1992-11-03');

INSERT INTO "Albums" ("Title", "IsExplicit", "ReleaseDate")
VALUES ('Dark Side of the Moon', False, '1973-03-01');

INSERT INTO "Albums" ("Title", "IsExplicit", "ReleaseDate")
VALUES ('The Wall', True, '1979-11-30');

INSERT INTO "Albums" ("Title", "IsExplicit", "ReleaseDate")
VALUES ('Ride the Lightning', True, '1984-07-27');

INSERT INTO "Albums" ("Title", "IsExplicit", "ReleaseDate")
VALUES ('The Black Album', False, '1990-10-06');

INSERT INTO "Albums" ("Title", "IsExplicit", "ReleaseDate")
VALUES ('The Colour and the Shape', False, '1997-05-20');


UPDATE "Albums" SET "BandId" = 1 WHERE "Id" in (1);

UPDATE "Albums" SET "BandId" = 2 WHERE "Id" in (2);

UPDATE "Albums" SET "BandId" = 3 WHERE "Id" in (3, 4);

UPDATE "Albums" SET "BandId" = 4 WHERE "Id" in (5, 6);

UPDATE "Albums" SET "BandId" = 5 WHERE "Id" in (7);




