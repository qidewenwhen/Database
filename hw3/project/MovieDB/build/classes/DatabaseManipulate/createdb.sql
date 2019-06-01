CREATE TABLE Movies (
	movieID                 VARCHAR(20)	PRIMARY KEY,
	title                   VARCHAR(250)	NOT NULL,
	year                    INTEGER		NOT NULL,
        rtAllCriticsRating      FLOAT,
        rtTopCriticsRating      FLOAT,
        rtAudienceRating        FLOAT,
        rtAllCriticsNumReviews  INTEGER,
        rtTopCriticsNumReviews  INTEGER,
        rtAudienceNumRatings    INTEGER
);

CREATE TABLE Genres (
	movieID		VARCHAR(20),
	genres		VARCHAR(20),
	PRIMARY KEY (movieID, genres),
	FOREIGN KEY (movieID) REFERENCES Movies (movieID) ON DELETE CASCADE	
);

CREATE TABLE MovieCountry (
	movieID		VARCHAR(20)	PRIMARY KEY,
	country		VARCHAR(50),
	FOREIGN KEY (movieID) REFERENCES Movies (movieID) ON DELETE CASCADE
);

CREATE TABLE MovieLocation (
	movieID		VARCHAR(20),
	country		VARCHAR(50),
	PRIMARY KEY (movieID, country),
	FOREIGN KEY (movieID) REFERENCES Movies (movieID) ON DELETE CASCADE
);

CREATE TABLE Tags (
	tagID		VARCHAR(20)	PRIMARY KEY,
	tagText		VARCHAR(50)
);

CREATE TABLE MovieTag (
	movieID		VARCHAR(20),
	tagID		VARCHAR(20),
	tagWeight	INTEGER,
	PRIMARY KEY (movieID, tagID),
	FOREIGN KEY (movieID) REFERENCES Movies (movieID) ON DELETE CASCADE,
	FOREIGN KEY (tagID) REFERENCES Tags (tagID) ON DELETE CASCADE
);

CREATE INDEX Index_Movies_title ON Movies(title);
CREATE INDEX Index_Movies_year ON Movies(year);
CREATE INDEX Index_Movies_rtAllCriticsRating ON Movies(rtAllCriticsRating);
CREATE INDEX Index_Movies_rtTopCriticsRating ON Movies(rtTopCriticsRating);
CREATE INDEX Index_Movies_rtAudienceRating ON Movies(rtAudienceRating);
CREATE INDEX Index_Movies_rtAllCriticsNumReviews ON Movies(rtAllCriticsNumReviews);
CREATE INDEX Index_Movies_rtTopCriticsNumReviews ON Movies(rtTopCriticsNumReviews);
CREATE INDEX Index_Movies_rtAudienceNumRatings ON Movies(rtAudienceNumRatings);
CREATE INDEX Index_Genres_genres ON Genres(genres);
CREATE INDEX Index_MovieCountry_country ON MovieCountry(country);
CREATE INDEX Index_MovieLocation_country ON MovieLocation(country);
CREATE INDEX Index_Tags_tagText ON Tags(tagText);
CREATE INDEX Index_MovieTag_tagWeight on MovieTag(tagWeight);
