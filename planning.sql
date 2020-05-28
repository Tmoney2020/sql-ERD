createdb MusicDataBase

pgcli MusicDataBase

CREATE TABLE "Album"
(
  "Id"            SERIAL PRIMARY KEY,
  "Title"         TEXT,
  "IsExplicit"    BOOLEAN,
  "ReleaseDate"   DATE
);


CREATE TABLE "Band"
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
ALTER TABLE "Album" ADD COLUMN "BandId" INTEGER NULL REFERENCES "Band" ("Id");

--  Add a new band
INSERT INTO "Band" ("Name", "CountryOfOrigin", "NumberOfMembers", "Website", "Style", "IsSigned", "ContactName", "ContactPhoneNumber")
VALUES ('The Band', 'Canada', 5, 'wwww.TheBand.com', 'Rock & Roll', 'True', 'Robbie Robertson', 5557777);

--  View all the bands
SELECT * FROM "Band"

--  Add an album for a band
INSERT INTO "Album" ("Title", "IsExplicit", "ReleaseDate")
VALUES ('Stage Fright', 'No', '1970-08-17');

--  Let a band go (update isSigned to false)
UPDATE "Band" SET "IsSigned" = False WHERE "Id" = 1;

--  Resign a band (update isSigned to true)
UPDATE "Band" SET "IsSigned" = True WHERE "Id" = 1;

--  Given a band name, view all their albums
UPDATE "Album" SET "BandId" = 1 WHERE "Id" in (1);

SELECT *
FROM "Album"
Join "Band" ON "Album"."BandId" = "Band"."Id";

--  View all albums ordered by ReleaseDate
INSERT INTO "Album" ("Title", "IsExplicit", "ReleaseDate")
VALUES ('Rage Against the Machine', 'True', '1992-11-03');


SELECT * FROM "Album" ORDER BY "ReleaseDate" DESC;



--  View all bands that are signed
INSERT INTO "Band" ("Name", "CountryOfOrigin", "NumberOfMembers", "Website", "Style", "IsSigned", "ContactName", "ContactPhoneNumber")
VALUES ('Rage Against the Machine', 'USA', 4, 'wwww.RageAginstTheMachine.com', 'Rock', False, 'Tom Moorello', 2983309);

UPDATE "Album" SET "BandId" = 2 WHERE "Id" in (2);


SELECT "Name" FROM "Band" WHERE "IsSigned" = True;

--  View all bands that are not signed
SELECT "Name" FROM "Band" WHERE "IsSigned" = False;


