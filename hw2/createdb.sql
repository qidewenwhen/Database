CREATE TYPE Individual_type AS OBJECT (
    ID              VARCHAR(20),
    First_name      VARCHAR(15),
    Last_name       VARCHAR(15),
    DOB             DATE,
    Birth_N         VARCHAR(20),
    Birth_SP        VARCHAR(20),
    Birth_T         VARCHAR(20),
    Gender          VARCHAR(1),
    MEMBER FUNCTION get_age RETURN NUMBER
) NOT FINAL; 
/

CREATE TYPE BODY Individual_type AS 
    MEMBER FUNCTION get_age RETURN NUMBER IS
    BEGIN
        RETURN EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DOB); 
    END get_age;
END;
/

CREATE TYPE User_type UNDER Individual_type (
    Email           VARCHAR(50)
); 
/

CREATE TYPE Person_type UNDER Individual_type (

) NOT FINAL; 
/

CREATE TYPE Director_type UNDER Person_type (

); 
/

CREATE TYPE Actor_type UNDER Person_type (

); 
/
CREATE TYPE Adult_type UNDER Person_type (
    Spouse_First_name     VARCHAR(15),
    Spouse_Last_name      VARCHAR(15),
    Marry_year            NUMBER
);
/
CREATE TYPE Minor_type UNDER Person_type (
    Guardian_First_name     VARCHAR(15),
    Guardian_Last_name      VARCHAR(15)
);
/
------------------------------- User -----------------------------
CREATE TABLE User_table OF User_type (
    PRIMARY KEY (ID)
);
INSERT INTO User_table VALUES(User_type('ID1',  'John', 'Smith',        TO_DATE('10/5/1995','MM/DD/YYYY'),  NULL, 'FL', NULL, 'M', 'john@yahoo.com'));
INSERT INTO User_table VALUES(User_type('ID2',  'Juan', 'Carlos',       TO_DATE('4/12/1994','MM/DD/YYYY'),  NULL, 'AK', NULL, 'M', 'juan@gmail.com'));
INSERT INTO User_table VALUES(User_type('ID3',  'Jane', 'Chapel',       TO_DATE('11/2/1993','MM/DD/YYYY'),  NULL, 'IL', NULL, 'F', 'Jane@gmail.com'));
INSERT INTO User_table VALUES(User_type('ID4',  'Aditya', 'Awasthi',    TO_DATE('12/12/1992','MM/DD/YYYY'), NULL, 'CA', NULL, 'M', 'adi@yahoo.com'));
INSERT INTO User_table VALUES(User_type('ID5',  'James', 'Williams',    TO_DATE('5/5/1991','MM/DD/YYYY'),   NULL, 'NY', NULL, 'M', 'james@hotmail.com'));
INSERT INTO User_table VALUES(User_type('ID6',  'Mike', 'Brown',        TO_DATE('3/1/1988','MM/DD/YYYY'),   NULL, 'NC', NULL, 'M', 'mike@yahoo.com'));
INSERT INTO User_table VALUES(User_type('ID7',  'Bob', 'Jones',         TO_DATE('2/7/1988','MM/DD/YYYY'),   NULL, 'NY', NULL, 'M', 'bob@yahoo.com'));
INSERT INTO User_table VALUES(User_type('ID8',  'Wei', 'Zhang',         TO_DATE('8/12/1985','MM/DD/YYYY'),  NULL, 'NV', NULL, 'F', 'wei@gmail.com'));
INSERT INTO User_table VALUES(User_type('ID9',  'Mark', 'Davis',        TO_DATE('5/10/1984','MM/DD/YYYY'),  NULL, 'CA', NULL, 'M', 'mark@gmail.com'));
INSERT INTO User_table VALUES(User_type('ID10', 'Daniel', 'Garcia',     TO_DATE('6/1/1980','MM/DD/YYYY'),   NULL, 'NJ', NULL, 'M', 'daniel@yahoo.com'));
INSERT INTO User_table VALUES(User_type('ID11', 'Maria', 'Rodriguez',   TO_DATE('3/18/1975','MM/DD/YYYY'),  NULL, 'CA', NULL, 'F', 'maria@hotmail.com'));
INSERT INTO User_table VALUES(User_type('ID12', 'Freya', 'Wilson',      TO_DATE('2/19/1970','MM/DD/YYYY'),  NULL, 'NJ', NULL, 'F', 'freya@yahoo.com'));

------------------------------- Director -----------------------------
CREATE TABLE Director_table OF Director_type (
    PRIMARY KEY (ID)
);
INSERT INTO Director_table VALUES(Director_type('P1',   'Brian', 'de forma',    TO_DATE('9/11/1940','MM/DD/YYYY'),  NULL, NULL, 'New York', 'M'));
INSERT INTO Director_table VALUES(Director_type('P2',   'Martin', 'Brest',      TO_DATE('8/8/1951','MM/DD/YYYY'),   NULL, NULL, 'San Jose', 'M'));
INSERT INTO Director_table VALUES(Director_type('P4',   'Luc', 'Besson',        TO_DATE('5/30/1975','MM/DD/YYYY'),  NULL, NULL, 'Paris', 'F'));
INSERT INTO Director_table VALUES(Director_type('P21',  'George', 'Lucas',      TO_DATE('5/14/1968','MM/DD/YYYY'),  NULL, NULL, 'Modesto', 'M'));
INSERT INTO Director_table VALUES(Director_type('P26',  'J.J.', 'Abrams',       TO_DATE('6/27/1966','MM/DD/YYYY'),  NULL, NULL, 'New York', 'M'));
INSERT INTO Director_table VALUES(Director_type('P30',  'Barry', 'Jenkins',     TO_DATE('11/19/1979','MM/DD/YYYY'), NULL, NULL, 'Miami', 'M'));
INSERT INTO Director_table VALUES(Director_type('P32',  'Steven', 'Spielberg',  TO_DATE('12/18/1946','MM/DD/YYYY'), NULL, NULL, 'Cincinnati', 'M'));
																			
------------------------------- Actor -----------------------------
CREATE TABLE Actor_table OF Actor_type (
    PRIMARY KEY (ID)
);
INSERT INTO Actor_table VALUES(Actor_type('P3',    'Scarlett',      'Johanson',	    TO_DATE('11/22/1984',	'MM/DD/YYYY'),  NULL, NULL, 'Austin',	        'F'));   
INSERT INTO Actor_table VALUES(Actor_type('P5',    'Morgan',        'Freeman',	    TO_DATE('6/5/1953', 	'MM/DD/YYYY'),  NULL, NULL, 'Canberra',		'M'));
INSERT INTO Actor_table VALUES(Actor_type('P6',    'Al', 	        'Pacino',	    TO_DATE('11/12/1956',	'MM/DD/YYYY'),  NULL, NULL, 'Portland',		    'M'));
INSERT INTO Actor_table VALUES(Actor_type('P7',    'Angelina',      'Jolie',	    TO_DATE('3/3/1970',	    'MM/DD/YYYY'),  NULL, NULL, 'Seattle',	    'F'));
INSERT INTO Actor_table VALUES(Actor_type('P8',    'Brad', 	        'Pitt',	        TO_DATE('4/4/1975',	    'MM/DD/YYYY'),  NULL, NULL, 'London',	    'M'));
INSERT INTO Actor_table VALUES(Actor_type('P9',    'Tom', 	        'Hanks',	    TO_DATE('5/19/1964',	'MM/DD/YYYY'),  NULL, NULL, 'Perth',	    'M'));
INSERT INTO Actor_table VALUES(Actor_type('P10',   'Jessica',       'Alba',	        TO_DATE('8/7/1983',	    'MM/DD/YYYY'),  NULL, NULL, 'Seoul',	        'F'));
INSERT INTO Actor_table VALUES(Actor_type('P11',   'Catherine',     'Jones',	    TO_DATE('9/29/1969',	'MM/DD/YYYY'),  NULL, NULL, 'Swansea',	    'F'));
INSERT INTO Actor_table VALUES(Actor_type('P12',   'Alex', 	        'Parish',	    TO_DATE('7/9/1977',	    'MM/DD/YYYY'),  NULL, NULL, 'San Jose',		'F'));
INSERT INTO Actor_table VALUES(Actor_type('P13',   'Leonardo',      'DiCaprio',	    TO_DATE('11/11/1974',	'MM/DD/YYYY'),  NULL, NULL, 'Los Angeles',      'M'));
INSERT INTO Actor_table VALUES(Actor_type('P14',   'Tom', 	        'Cruise',	    TO_DATE('7/3/1962',	    'MM/DD/YYYY'),  NULL, NULL, 'New York',		'M'));
INSERT INTO Actor_table VALUES(Actor_type('P15',   'Harrison',      'Ford',	        TO_DATE('9/11/1957',	'MM/DD/YYYY'),  NULL, NULL, 'Canberra',		    'M'));
INSERT INTO Actor_table VALUES(Actor_type('P16',   'Julia', 	    'Roberts',	    TO_DATE('1/1/1967',	    'MM/DD/YYYY'),  NULL, NULL, 'Portland',		'F'));
INSERT INTO Actor_table VALUES(Actor_type('P17',   'Matt',	        'Damon',	    TO_DATE('1/7/1971',	    'MM/DD/YYYY'),  NULL, NULL, 'Seattle',		'M'));
INSERT INTO Actor_table VALUES(Actor_type('P18',   'Jennifer',      'Lawrence',	    TO_DATE('2/2/1962',	    'MM/DD/YYYY'),  NULL, NULL, 'London',		    'F'));
INSERT INTO Actor_table VALUES(Actor_type('P19',   'George',	    'clooney',	    TO_DATE('3/3/1965',	    'MM/DD/YYYY'),  NULL, NULL, 'Perth',		'M'));
INSERT INTO Actor_table VALUES(Actor_type('P20',   'Samantha',      'Morton',	    TO_DATE('5/3/1977',	    'MM/DD/YYYY'),  NULL, NULL, 'Notingham',	'F'));   
INSERT INTO Actor_table VALUES(Actor_type('P22',   'Ewan',	        'McGregor',	    TO_DATE('3/31/1968',	'MM/DD/YYYY'),  NULL, NULL, 'Perth',	    'M'));
INSERT INTO Actor_table VALUES(Actor_type('P23',   'Hayden',	    'Christensen',	TO_DATE('4/19/1981',	'MM/DD/YYYY'),  NULL, NULL, 'Vancouver',	'M'));
INSERT INTO Actor_table VALUES(Actor_type('P24',   'Liam',	        'Neeson',	    TO_DATE('6/7/1968',	    'MM/DD/YYYY'),  NULL, NULL, 'Antrim',	    'M'));
INSERT INTO Actor_table VALUES(Actor_type('P25',   'Natalie',       'Portman',	    TO_DATE('5/14/1968',	'MM/DD/YYYY'),  NULL, NULL, 'Jerusalem',	'F'));   
INSERT INTO Actor_table VALUES(Actor_type('P27',   'Daisy',	        'Ridley',	    TO_DATE('4/10/1992',	'MM/DD/YYYY'),  NULL, NULL, 'London',		'F'));
INSERT INTO Actor_table VALUES(Actor_type('P28',   'John',	        'Boyega',	    TO_DATE('3/17/1992',	'MM/DD/YYYY'),  NULL, NULL, 'London',		'M'));
INSERT INTO Actor_table VALUES(Actor_type('P29',   'Oscar',	        'Isaac',	    TO_DATE('3/9/1979',	    'MM/DD/YYYY'),  NULL, NULL, 'Guatemala',	'M'));   
INSERT INTO Actor_table VALUES(Actor_type('P31',   'Mahershala',    'Ali',	        TO_DATE('2/16/1974',	'MM/DD/YYYY'),  NULL, NULL, 'Oakland',	    'M'));
INSERT INTO Actor_table VALUES(Actor_type('P33',   'Cate',	        'Blanchett',	TO_DATE('5/14/1969',	'MM/DD/YYYY'),  NULL, NULL, 'Victoria',	    'F'));
INSERT INTO Actor_table VALUES(Actor_type('P34',   'Harrison',      'Ford',	        TO_DATE('7/13/1942',	'MM/DD/YYYY'),  NULL, NULL, 'Chicago',	        'M'));
INSERT INTO Actor_table VALUES(Actor_type('P35',   'Sean',	        'Connery',	    TO_DATE('8/25/1930',	'MM/DD/YYYY'),  NULL, NULL, 'Edinburg',		'M'));
INSERT INTO Actor_table VALUES(Actor_type('P36',   'Kate',	        'Capshaw',	    TO_DATE('11/3/1953',	'MM/DD/YYYY'),  NULL, NULL, 'Fort Worth',	'F'));
INSERT INTO Actor_table VALUES(Actor_type('P37',   'Ralph',	        'Fiennes',	    TO_DATE('12/22/1962',	'MM/DD/YYYY'),  NULL, NULL, 'Ipswich',		'M'));
INSERT INTO Actor_table VALUES(Actor_type('P38',   'Teresa',	    'Palmer',	    TO_DATE('2/26/1986',	'MM/DD/YYYY'),  NULL, NULL, 'Adlaide',		'F'));
INSERT INTO Actor_table VALUES(Actor_type('P39',   'Gabriel',       'Bateman',	    TO_DATE('9/10/2004',	'MM/DD/YYYY'),  NULL, NULL, 'Turlock',		'F'));
INSERT INTO Actor_table VALUES(Actor_type('P40',   'Daniel',	    'Day-Lewis',	TO_DATE('4/19/1957',	'MM/DD/YYYY'),  NULL, NULL, 'London',		'M'));
INSERT INTO Actor_table VALUES(Actor_type('P41',   'Jeremy',	    'Irvine',	    TO_DATE('4/19/1990',	'MM/DD/YYYY'),  NULL, NULL, 'Cambridge',	'M'));
INSERT INTO Actor_table VALUES(Actor_type('P42',   'Emily',	        'Watson',	    TO_DATE('1/14/1967',	'MM/DD/YYYY'),  NULL, NULL, 'London',	    'F'));
INSERT INTO Actor_table VALUES(Actor_type('P43',   'Jamie',	        'Bell',	        TO_DATE('3/14/1986',	'MM/DD/YYYY'),  NULL, NULL, 'Billingam',	'M'));
INSERT INTO Actor_table VALUES(Actor_type('P44',   'Andy',	        'Serkis',	    TO_DATE('4/20/1964',	'MM/DD/YYYY'),  NULL, NULL, 'London',	    'M'));
INSERT INTO Actor_table VALUES(Actor_type('P45',   'Roy',           'Scheider',	    TO_DATE('11/10/1932',	'MM/DD/YYYY'),  NULL, NULL, 'Little Rock',	    'M'));
INSERT INTO Actor_table VALUES(Actor_type('P46',   'Robert',	    'Shaw',	        TO_DATE('7/9/1927',	    'MM/DD/YYYY'),  NULL, NULL, 'Mayo',	    	'M'));
INSERT INTO Actor_table VALUES(Actor_type('P47',   'Tom',	        'Smothers',	    TO_DATE('2/2/1937',	    'MM/DD/YYYY'),  NULL, NULL, 'New York',		    'M'));
INSERT INTO Actor_table VALUES(Actor_type('P48',   'John',	        'Astin',	    TO_DATE('3/30/1930',	'MM/DD/YYYY'),  NULL, NULL, 'Baltimore',	'M'));
INSERT INTO Actor_table VALUES(Actor_type('P49',   'Danny',	        'DeVito',	    TO_DATE('11/17/1944',	'MM/DD/YYYY'),  NULL, NULL, 'New Jersey',	'M'));
INSERT INTO Actor_table VALUES(Actor_type('P50',   'Joe',	        'Piscopo',	    TO_DATE('6/17/1951',	'MM/DD/YYYY'),  NULL, NULL, 'New Jersey',	'M'));
INSERT INTO Actor_table VALUES(Actor_type('P51',   'Mia',           'Farrow',       TO_DATE('02/09/1942',   'MM/DD/YYYY'),  NULL, NULL, 'Los Angeles',  'F'));		
INSERT INTO Actor_table VALUES(Actor_type('P52',   'Freddie',       'Highmore',	    TO_DATE('2/14/1992',	'MM/DD/YYYY'),  NULL, NULL, 'London',	    'M'));

CREATE TABLE Adult_table OF Adult_type (
    PRIMARY KEY (ID)
);

CREATE TABLE Minor_table OF Minor_type (
    PRIMARY KEY (ID)
);

------------------------------- Movie -----------------------------				
CREATE TABLE Movie_table (
    Serial_No   VARCHAR(20)      NOT NULL,
    Title       VARCHAR(100)     NOT NULL,
    Rlease_year NUMBER,
    Director_ID VARCHAR(20),
    Cost        NUMBER,
    Company     VARCHAR(20),
    Contract_No VARCHAR(20),
    PRIMARY KEY (Serial_No),
    FOREIGN KEY (Director_ID) REFERENCES Director_table (ID) ON DELETE CASCADE
);	
INSERT INTO Movie_table VALUES('M1',	'Scarface',	                                                                1988,	'P1',   NULL,   NULL,   NULL);	
INSERT INTO Movie_table VALUES('M2',	'Scent of a women',	                                                    	1995,	'P2',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M3',	'My big fat greek wedding',	                                            	2000,	'P4',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M4',	'Star Wars: The Force Awakens',	                                        	2015,	'P21',  NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M5',	'Mr. and Mrs Smith',	                                                    1965,	'P1',   NULL,   NULL,   NULL);	
INSERT INTO Movie_table VALUES('M6',	'Star Wars: Episode III - Revenge of the Sith', 	                        2013,	'P21',  NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M7',	'Barely Lethal',	                                                        2014,	'P4',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M8',	'The Man with one red shoe',	                                            1984,	'P1',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M9',	'The Polar Express',	                                                    2010,	'P2',   NULL,   NULL,   NULL);	
INSERT INTO Movie_table VALUES('M10',	'Her',	                                                                   	2013,	'P2',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M11',	'Star Wars: Episode I - The Phantom Menace',	                            1999,	'P21',  NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M12',	'The Da Vinci Code',	                                                    2005,	'P4',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M13',	'The God Father part II',	                                                1975,	'P1',   NULL,   NULL,   NULL);	
INSERT INTO Movie_table VALUES('M15',	'Angels and Daemons',	                                                    2009,	'P2',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M16',	'The Island',	                                                            2010,	'P4',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M17',	'Moonlight',	                                                            2016,	'P30',  NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M18',	'Indiana Jones and the Kingdom of the Crystal Skull',	                    2008,	'P32',  NULL,   NULL,   NULL);	
INSERT INTO Movie_table VALUES('M19',	'Indiana Jones and the Last Crusade',	                                    1989,	'P32',  NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M20',	'Indiana Jones and the Temple of Doom',	                                	1984,	'P32',  NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M21',	'Star Wars: Episode II - Attack of the Clones',	                        	2002,	'P21',  NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M22',	'The Terminal', 	                                                        2004,	'P32',  NULL,   NULL,   NULL);	
INSERT INTO Movie_table VALUES('M23',	'Catch me if you can', 	                                                	2002,	'P32',  NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M24',	'Minority Report', 	                                                    	2002,	'P32',  NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M25',	'Saving Private Ryan',	                                                   	1998,	'P32',  NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M26',	'Schindler''s List',	                                                    1993,	'P32',  NULL,   NULL,   NULL);	
INSERT INTO Movie_table VALUES('M27',	'Get To Know Your Rabbit',	                                               	1972,	'P1',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M28',	'Lights Out', 	                                                           	2016,	'P1',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M29',	'Lucy',	                                                                	2014,	'P4',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M30',	'Arthur and the Invisibles', 	                                            2006,	'P4',   NULL,   NULL,   NULL);	
INSERT INTO Movie_table VALUES('M31',	'The Big Blue',	                                                        	1988,	'P4',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M32',	'Wise Guys',	                                                            1986,	'P1',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M33',	'The Black Dahlia',	                                                    	2006,	'P1',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M34',	'Mission: Impossible',	                                                   	1996,	'P1',   NULL,   NULL,   NULL);	
INSERT INTO Movie_table VALUES('M35',	'Arthur and the Invisibles: The Making of the Year''s Greatest Adventure',	2007,	'P4',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M36',	'Arthur 3: The War of the Two Worlds',	                                   	2010,	'P4',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M37',	'Arthur and the Revenge of Maltazard', 	                                	2009,	'P4',   NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M38',	'The adventures of Tintin',	                                            	2011,	'P32',  NULL,   NULL,   NULL);	
INSERT INTO Movie_table VALUES('M39',	'War Horse',	                                                            2011,	'P32',  NULL,   NULL,   NULL);
INSERT INTO Movie_table VALUES('M40',	'Lincoln',	                                                               	2012,	'P32',  NULL,   NULL,   NULL);

CREATE TABLE Movie_Genre_table (
    Movie_ID    VARCHAR(20)     NOT NULL,
    Genre       VARCHAR(20)     NOT NULL,
    PRIMARY KEY (Movie_ID, Genre),
    FOREIGN KEY (Movie_ID) REFERENCES Movie_table (Serial_No) ON DELETE CASCADE
);
INSERT INTO Movie_Genre_table VALUES('M1',  'Action');
INSERT INTO Movie_Genre_table VALUES('M2',  'Action');
INSERT INTO Movie_Genre_table VALUES('M2',  'Comedy');
INSERT INTO Movie_Genre_table VALUES('M3',  'Comedy');
INSERT INTO Movie_Genre_table VALUES('M3',  'Drama');
INSERT INTO Movie_Genre_table VALUES('M4',  'Action');
INSERT INTO Movie_Genre_table VALUES('M5',  'Comedy');
INSERT INTO Movie_Genre_table VALUES('M5',  'Action');
INSERT INTO Movie_Genre_table VALUES('M6',  'Action');
INSERT INTO Movie_Genre_table VALUES('M7',  'Action');
INSERT INTO Movie_Genre_table VALUES('M8',  'comedy');
INSERT INTO Movie_Genre_table VALUES('M9',  'comedy');
INSERT INTO Movie_Genre_table VALUES('M10', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M11', 'Action');
INSERT INTO Movie_Genre_table VALUES('M12', 'Action');
INSERT INTO Movie_Genre_table VALUES('M12', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M13', 'Action');
INSERT INTO Movie_Genre_table VALUES('M13', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M15', 'Action');
INSERT INTO Movie_Genre_table VALUES('M15', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M16', 'Action');
INSERT INTO Movie_Genre_table VALUES('M16', 'Comedy');
INSERT INTO Movie_Genre_table VALUES('M17', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M18', 'Action');
INSERT INTO Movie_Genre_table VALUES('M19', 'Action');
INSERT INTO Movie_Genre_table VALUES('M20', 'Action');
INSERT INTO Movie_Genre_table VALUES('M21', 'Action');
INSERT INTO Movie_Genre_table VALUES('M22', 'Comedy');
INSERT INTO Movie_Genre_table VALUES('M23', 'Action');
INSERT INTO Movie_Genre_table VALUES('M24', 'Action');
INSERT INTO Movie_Genre_table VALUES('M25', 'Action');
INSERT INTO Movie_Genre_table VALUES('M26', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M26', 'Action');
INSERT INTO Movie_Genre_table VALUES('M27', 'Comedy');
INSERT INTO Movie_Genre_table VALUES('M27', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M28', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M29', 'Action');
INSERT INTO Movie_Genre_table VALUES('M30', 'Comedy');
INSERT INTO Movie_Genre_table VALUES('M31', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M32', 'Comedy');
INSERT INTO Movie_Genre_table VALUES('M33', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M34', 'Action');
INSERT INTO Movie_Genre_table VALUES('M35', 'Comedy');
INSERT INTO Movie_Genre_table VALUES('M36', 'Comedy');
INSERT INTO Movie_Genre_table VALUES('M37', 'Comedy');
INSERT INTO Movie_Genre_table VALUES('M38', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M38', 'Comedy');
INSERT INTO Movie_Genre_table VALUES('M39', 'Drama');
INSERT INTO Movie_Genre_table VALUES('M39', 'Comedy');
INSERT INTO Movie_Genre_table VALUES('M40', 'Drama');

CREATE TABLE Movie_Cast_table (
    Movie_ID        VARCHAR(20)     NOT NULL,
    Person_ID       VARCHAR(20)     NOT NULL,
    Character_name  VARCHAR(30),
    PRIMARY KEY (Movie_ID, Person_ID, Character_name),
    FOREIGN KEY (Movie_ID) REFERENCES Movie_table (Serial_No) ON DELETE CASCADE,
    FOREIGN KEY (Person_ID) REFERENCES Actor_table (ID) ON DELETE CASCADE
);
INSERT INTO Movie_Cast_table VALUES('M1',   'P5',   'Jessica');
INSERT INTO Movie_Cast_table VALUES('M1',   'P6',   'robert');
INSERT INTO Movie_Cast_table VALUES('M2',   'P5',   'John');
INSERT INTO Movie_Cast_table VALUES('M2',   'P6',   'Mark');
INSERT INTO Movie_Cast_table VALUES('M3',   'P9',   'Alex');
INSERT INTO Movie_Cast_table VALUES('M3',   'P7',   'Julie');
INSERT INTO Movie_Cast_table VALUES('M4',   'P27',  'Rey');
INSERT INTO Movie_Cast_table VALUES('M4',   'P28',  'Finn ');
INSERT INTO Movie_Cast_table VALUES('M4',   'P29',  'Poe');
INSERT INTO Movie_Cast_table VALUES('M5',   'P7',   'Jennifer');
INSERT INTO Movie_Cast_table VALUES('M5',   'P8',   'Tom');
INSERT INTO Movie_Cast_table VALUES('M5',   'P5',   'Milo');
INSERT INTO Movie_Cast_table VALUES('M6',   'P23',  'Anakin Skywalker');
INSERT INTO Movie_Cast_table VALUES('M6',   'P25',  'Padme');
INSERT INTO Movie_Cast_table VALUES('M6',   'P22',  'Obi-Wan Kenobi');
INSERT INTO Movie_Cast_table VALUES('M7',   'P10',  'Jane');
INSERT INTO Movie_Cast_table VALUES('M7',   'P5',   'Brad');
INSERT INTO Movie_Cast_table VALUES('M8',   'P9',   'Lucas');
INSERT INTO Movie_Cast_table VALUES('M8',   'P10',  'Juanita');
INSERT INTO Movie_Cast_table VALUES('M9',   'P9',   'Clayne');
INSERT INTO Movie_Cast_table VALUES('M9',   'P9',   'Jane');
INSERT INTO Movie_Cast_table VALUES('M9',   'P9',   'Brad');
INSERT INTO Movie_Cast_table VALUES('M9',   'P9',   'Lucas');
INSERT INTO Movie_Cast_table VALUES('M9',   'P9',   'Bradley');
INSERT INTO Movie_Cast_table VALUES('M9',   'P9',   'Justin');
INSERT INTO Movie_Cast_table VALUES('M9',   'P17',  'Martin');
INSERT INTO Movie_Cast_table VALUES('M9',   'P19',  'Mike');
INSERT INTO Movie_Cast_table VALUES('M10',  'P3',   'Travis');
INSERT INTO Movie_Cast_table VALUES('M10',  'P5',   'Alexander');
INSERT INTO Movie_Cast_table VALUES('M10',  'P6',   'Justin');
INSERT INTO Movie_Cast_table VALUES('M11',  'P22',  'Obi-Wan Kenobi');
INSERT INTO Movie_Cast_table VALUES('M11',  'P24',  'Qui-Gon Jinn');
INSERT INTO Movie_Cast_table VALUES('M11',  'P25',  'Padme');
INSERT INTO Movie_Cast_table VALUES('M12',  'P9',   'Gatek');
INSERT INTO Movie_Cast_table VALUES('M12',  'P10',  'Rose');
INSERT INTO Movie_Cast_table VALUES('M12',  'P3',   'maria');
INSERT INTO Movie_Cast_table VALUES('M13',  'P5',   'Travis');
INSERT INTO Movie_Cast_table VALUES('M13',  'P6',   'Alexander');
INSERT INTO Movie_Cast_table VALUES('M13',  'P16',  'Pearl');
INSERT INTO Movie_Cast_table VALUES('M15',  'P12',  'Sofia');
INSERT INTO Movie_Cast_table VALUES('M15',  'P18',  'chrissy');
INSERT INTO Movie_Cast_table VALUES('M15',  'P9',   'Mike');
INSERT INTO Movie_Cast_table VALUES('M16',  'P10',  'Martin');
INSERT INTO Movie_Cast_table VALUES('M16',  'P15',  'Bill');
INSERT INTO Movie_Cast_table VALUES('M16',  'P16',  'Emilia');
INSERT INTO Movie_Cast_table VALUES('M17',  'P31',  'Juan');
INSERT INTO Movie_Cast_table VALUES('M18',  'P33',  'Irina');
INSERT INTO Movie_Cast_table VALUES('M18',  'P34',  'Indiana Jones ');
INSERT INTO Movie_Cast_table VALUES('M19',  'P34',  'Indiana Jones ');
INSERT INTO Movie_Cast_table VALUES('M19',  'P35',  'Henry');
INSERT INTO Movie_Cast_table VALUES('M20',  'P34',  'Indiana Jones ');
INSERT INTO Movie_Cast_table VALUES('M20',  'P36',  'Willie');
INSERT INTO Movie_Cast_table VALUES('M21',  'P23',  'Anakin Skywalker');
INSERT INTO Movie_Cast_table VALUES('M21',  'P25',  'Padme');
INSERT INTO Movie_Cast_table VALUES('M21',  'P22',  'Obi-Wan Kenobi');
INSERT INTO Movie_Cast_table VALUES('M22',  'P9',   'Viktor ');
INSERT INTO Movie_Cast_table VALUES('M22',  'P11',  'Amelia');
INSERT INTO Movie_Cast_table VALUES('M23',  'P9',   'Carl');
INSERT INTO Movie_Cast_table VALUES('M23',  'P13',  'Frank');
INSERT INTO Movie_Cast_table VALUES('M24',  'P14',  'John');
INSERT INTO Movie_Cast_table VALUES('M24',  'P20',  'Agatha');
INSERT INTO Movie_Cast_table VALUES('M25',  'P9',   'Captain Miller');
INSERT INTO Movie_Cast_table VALUES('M25',  'P17',  'Private Ryan');
INSERT INTO Movie_Cast_table VALUES('M26',  'P24',  'Oskar');
INSERT INTO Movie_Cast_table VALUES('M26',  'P37',  'Amon');
INSERT INTO Movie_Cast_table VALUES('M27',  'P47',  'Donald Beeman');
INSERT INTO Movie_Cast_table VALUES('M27',  'P48',  'Mr. Turnbull');
INSERT INTO Movie_Cast_table VALUES('M28',  'P38',  'Rebecca');
INSERT INTO Movie_Cast_table VALUES('M28',  'P39',  'Martin');
INSERT INTO Movie_Cast_table VALUES('M29',  'P3',   'Lucy');
INSERT INTO Movie_Cast_table VALUES('M29',  'P5',   'Professor Norman');
INSERT INTO Movie_Cast_table VALUES('M30',  'P51',  'Granny');
INSERT INTO Movie_Cast_table VALUES('M30',  'P52',  'Arthur');
INSERT INTO Movie_Cast_table VALUES('M31',  'P5',   'Broddy');
INSERT INTO Movie_Cast_table VALUES('M31',  'P6',   'Quint');
INSERT INTO Movie_Cast_table VALUES('M32',  'P49',  'Harry');
INSERT INTO Movie_Cast_table VALUES('M32',  'P50',  'Moe');
INSERT INTO Movie_Cast_table VALUES('M33',  'P3',   'Kay');
INSERT INTO Movie_Cast_table VALUES('M34',  'P14',  'Ethan Hunt');
INSERT INTO Movie_Cast_table VALUES('M35',  'P51',  'Granny');
INSERT INTO Movie_Cast_table VALUES('M35',  'P52',  'Arthur');
INSERT INTO Movie_Cast_table VALUES('M36',  'P51',  'Granny');
INSERT INTO Movie_Cast_table VALUES('M37',  'P52',  'Arthur');
INSERT INTO Movie_Cast_table VALUES('M38',  'P44',  'Captain haddock');
INSERT INTO Movie_Cast_table VALUES('M38',  'P43',  'Tintin');
INSERT INTO Movie_Cast_table VALUES('M39',  'P42',  'Rose');
INSERT INTO Movie_Cast_table VALUES('M39',  'P41',  'Albert');
INSERT INTO Movie_Cast_table VALUES('M40',  'P40',  'Abraham Lincoln');

CREATE TABLE Scene_table (
    Scene_number    VARCHAR(20)     NOT NULL,
    Movie_ID        VARCHAR(20)     NOT NULL,
    PRIMARY KEY (Scene_number, Movie_ID),
    FOREIGN KEY (Movie_ID) REFERENCES Movie_table (Serial_No) ON DELETE CASCADE
);


-------------------------------------------- TV Series ------------------------------
CREATE TABLE TV_table (
    TV_network      VARCHAR(50),
    TV_name         VARCHAR(20),
    Company         VARCHAR(20),
    Contract_No     VARCHAR(20),
    PRIMARY KEY (TV_network, TV_name)
);

CREATE TABLE Episode_table (
    Episode_Number      VARCHAR(20),
    TV_network          VARCHAR(20),
    TV_name             VARCHAR(20),   
    Title               VARCHAR(20),
    Episode_Length      NUMBER,
    PRIMARY KEY (Episode_Number, TV_network, TV_name),
    FOREIGN KEY (TV_network, TV_name) REFERENCES TV_table (TV_network, TV_name) ON DELETE CASCADE
);

CREATE TABLE TV_Episode_Cast_table (
    TV_network          VARCHAR(20)     NOT NULL,
    TV_name             VARCHAR(20)     NOT NULL,
    Episode_Number      VARCHAR(20)     NOT NULL,
    Person_ID           VARCHAR(20)     NOT NULL,
    Character_name      VARCHAR(30)     NOT NULL,     
    Cast_Type           VARCHAR(15),
    PRIMARY KEY (TV_network, TV_name, Episode_Number, Person_ID, Character_name),
    FOREIGN KEY (Episode_Number, TV_network, TV_name) REFERENCES Episode_table (Episode_Number, TV_network, TV_name) ON DELETE CASCADE,
    FOREIGN KEY (Person_ID) REFERENCES Actor_table (ID) ON DELETE CASCADE
);

------------------------------ Review ---------------------------------
CREATE TYPE Vote_type AS OBJECT (
    Helpful_Votes   FLOAT,
    UnHelpful_Votes FLOAT,
    MEMBER FUNCTION get_totalVotes RETURN FLOAT
); 
/

CREATE TYPE BODY Vote_type AS
    MEMBER FUNCTION get_totalVotes RETURN FLOAT IS
    BEGIN
        RETURN Helpful_Votes + UnHelpful_Votes;
    END get_totalVotes;
END;
/

CREATE TYPE Content_type AS OBJECT (
    Txt            CHAR,
    Picture        CHAR,
    Video          CHAR
);
/

CREATE TABLE Review_table (
    ID              VARCHAR(20),
    User_ID         VARCHAR(20) NOT NULL,
    Movie_ID        VARCHAR(20) NOT NULL,
    Stars           FLOAT       NOT NULL,
    Review_DATE     DATE        NOT NULL,
    Votes           Vote_type,
    Content         Content_type,
    PRIMARY KEY (ID),
    FOREIGN KEY (User_ID) REFERENCES User_table (ID) ON DELETE CASCADE,
    FOREIGN KEY (Movie_ID) REFERENCES Movie_table (Serial_No) ON DELETE CASCADE,
    CONSTRAINT Rating_Movie_Range
        CHECK (Stars > 0 AND Stars <= 5)
);

INSERT INTO Review_table VALUES('R1',   'ID1' , 'M1',   1,      TO_DATE('10-29-2006 23:17:16',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R2',   'ID1' , 'M2',   4.5,    TO_DATE('10-29-2006 23:23:44',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R3',   'ID1' , 'M3',   4,      TO_DATE('10-29-2006 23:30:8',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R4',   'ID1' , 'M4',   2,      TO_DATE('10-29-2006 23:16:52',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R5',   'ID1' , 'M5',   4,      TO_DATE('10-29-2006 23:29:30',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R6',   'ID1' , 'M6',   4.5,    TO_DATE('10-29-2006 23:25:15',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R7',   'ID1' , 'M7',   3.5,    TO_DATE('10-29-2006 23:17:37',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R8',   'ID1' , 'M8',   5,      TO_DATE('10-29-2006 23:24:49',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R9',   'ID1' , 'M9',   3.5,    TO_DATE('10-29-2006 23:17:0',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R10',  'ID1' , 'M10',  2,      TO_DATE('10-29-2006 23:16:42',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R11',  'ID1' , 'M11',  4,      TO_DATE('10-29-2006 23:28:21',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R12',  'ID1' , 'M12',  3,      TO_DATE('10-29-2006 23:17:5',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R13',  'ID1' , 'M13',  4.5,    TO_DATE('10-29-2006 23:17:49',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R14',  'ID1' , 'M15',  0.5,    TO_DATE('10-29-2006 23:17:8',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R15',  'ID1' , 'M16',  4.5,    TO_DATE('10-29-2006 23:26:17',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R16',  'ID1' , 'M17',  4,      TO_DATE('10-29-2006 23:24:45',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R17',  'ID1' , 'M18',  3.5,    TO_DATE('10-29-2006 23:28:52',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R18',  'ID1' , 'M19',  4.5,    TO_DATE('10-29-2006 23:28:56',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R19',  'ID1' , 'M20',  4,      TO_DATE('10-29-2006 23:30:5',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R20',  'ID1' , 'M21',  2.5,    TO_DATE('10-29-2006 23:16:56',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R21',  'ID2' , 'M1',   4,      TO_DATE('10-29-2006 23:25:11',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R22',  'ID2' , 'M2',   4,      TO_DATE('10-29-2006 23:17:20',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R23',  'ID2' , 'M3',   4,      TO_DATE('10-29-2006 23:17:46',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R24',  'ID2' , 'M4',   4.5,    TO_DATE('10-29-2006 23:24:1',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R25',  'ID2' , 'M5',   2.5,    TO_DATE('10-29-2006 23:26:3',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R26',  'ID2' , 'M6',   2,      TO_DATE('10-29-2006 23:16:39',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R27',  'ID2' , 'M7',   1.5,    TO_DATE('10-29-2006 23:17:33',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R28',  'ID2' , 'M8',   4,      TO_DATE('10-29-2006 23:29:25',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R29',  'ID2' , 'M9',   4,      TO_DATE('10-29-2006 23:29:35',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R30',  'ID2' , 'M10',  4.5,    TO_DATE('10-29-2006 23:30:50',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R31',  'ID2' , 'M11',  3,      TO_DATE('10-29-2006 23:17:56',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R32',  'ID2' , 'M12',  3,      TO_DATE('10-29-2006 23:22:26',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R33',  'ID2' , 'M13',  4.5,    TO_DATE('10-29-2006 23:17:52',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R34',  'ID3' , 'M15',  3.5,    TO_DATE('10-29-2006 23:24:54',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R35',  'ID3' , 'M16',  4.5,    TO_DATE('10-29-2006 23:30:12',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R36',  'ID3' , 'M17',  1.5,    TO_DATE('10-29-2006 23:26:8',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R37',  'ID3' , 'M18',  3,      TO_DATE('10-29-2006 23:29:16',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R38',  'ID3' , 'M19',  3,      TO_DATE('10-29-2006 23:22:43',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R39',  'ID3' , 'M20',  3.5,    TO_DATE('10-29-2006 23:25:24',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R40',  'ID3' , 'M21',  3.5,    TO_DATE('10-29-2006 23:30:34',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R41',  'ID3' , 'M1',   3,      TO_DATE('10-29-2006 23:26:11',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R42',  'ID3' , 'M2',   2.5,    TO_DATE('10-29-2006 23:29:51',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R43',  'ID3' , 'M3',   3.5,    TO_DATE('10-29-2006 23:30:40',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R44',  'ID3' , 'M4',   4,      TO_DATE('10-29-2006 23:26:21',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R45',  'ID3' , 'M5',   0.5,    TO_DATE('10-29-2006 23:21:25',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R46',  'ID3' , 'M6',   4,      TO_DATE('10-29-2006 23:28:12',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R47',  'ID3' , 'M7',   3.5,    TO_DATE('10-29-2006 23:25:8',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R48',  'ID3' , 'M8',   4.5,    TO_DATE('10-29-2006 23:24:15',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R49',  'ID4' , 'M9',   3.5,    TO_DATE('10-29-2006 23:30:36',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R50',  'ID4' , 'M10',  4.5,    TO_DATE('10-29-2006 23:25:18',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R51',  'ID4' , 'M11',  5,      TO_DATE('10-29-2006 23:24:51',  'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R52',  'ID5' , 'M12',  3,      TO_DATE('12-4-2005 6:23:16',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R53',  'ID5' , 'M13',  4,      TO_DATE('12-4-2005 6:22:4',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R54',  'ID5' , 'M15',  5,      TO_DATE('12-4-2005 6:24:43',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R55',  'ID5' , 'M16',  4,      TO_DATE('12-4-2005 6:21:8',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R56',  'ID5' , 'M17',  3,      TO_DATE('8-19-2007 19:7:25',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R57',  'ID6' , 'M18',  3.5,    TO_DATE('12-4-2005 6:41:48',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R58',  'ID6' , 'M19',  3.5,    TO_DATE('12-4-2005 6:41:1',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R59',  'ID6' , 'M20',  5,      TO_DATE('12-4-2005 6:31:48',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R60',  'ID6' , 'M21',  5,      TO_DATE('8-19-2007 19:10:52',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R61',  'ID6' , 'M22',  3.5,    TO_DATE('12-4-2005 6:41:22',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R62',  'ID6' , 'M23',  3,      TO_DATE('7-9-2006 9:6:16',      'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R63',  'ID7' , 'M24',  4,      TO_DATE('12-4-2005 6:39:34',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R64',  'ID7' , 'M25',  3,      TO_DATE('12-4-2005 6:42:31',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R65',  'ID7' , 'M26',  4,      TO_DATE('7-9-2006 9:6:12',      'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R66',  'ID7' , 'M27',  5,      TO_DATE('12-4-2005 6:41:44',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R67',  'ID7' , 'M28',  5,      TO_DATE('12-4-2005 6:17:15',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R68',  'ID7' , 'M29',  4,      TO_DATE('12-4-2005 6:6:20',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R69',  'ID7' , 'M30',  1,      TO_DATE('8-19-2007 19:7:18',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R70',  'ID7' , 'M31',  5,      TO_DATE('12-4-2005 6:39:39',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R71',  'ID7' , 'M32',  5,      TO_DATE('12-4-2005 6:5:43',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R72',  'ID8' , 'M33',  5,      TO_DATE('8-30-2007 4:28:31',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R73',  'ID8' , 'M34',  5,      TO_DATE('8-19-2007 19:10:32',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R74',  'ID8' , 'M35',  5,      TO_DATE('8-19-2007 19:10:18',   'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R75',  'ID8' , 'M36',  3.5,    TO_DATE('12-4-2005 6:41:32',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R76',  'ID8' , 'M37',  5,      TO_DATE('12-4-2005 6:23:8',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R77',  'ID8' , 'M38',  5,      TO_DATE('12-4-2005 6:40:56',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R78',  'ID8' , 'M39',  4,      TO_DATE('12-4-2005 6:42:23',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R79',  'ID8' , 'M40',  5,      TO_DATE('12-4-2005 6:18:13',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R80',  'ID8' , 'M12',  5,      TO_DATE('12-4-2005 6:38:34',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R81',  'ID9' , 'M13',  3,      TO_DATE('12-4-2005 6:6:51',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R82',  'ID9' , 'M15',  3.5,    TO_DATE('12-4-2005 6:31:31',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R83',  'ID9' , 'M16',  5,      TO_DATE('7-9-2006 9:5:53',      'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R84',  'ID9' , 'M17',  0.5,    TO_DATE('12-4-2005 6:6:37',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R85',  'ID9' , 'M18',  4,      TO_DATE('12-4-2005 6:27:19',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R86',  'ID9' , 'M19',  4,      TO_DATE('12-4-2005 6:17:48',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R87',  'ID9' , 'M20',  4,      TO_DATE('12-4-2005 6:40:36',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R88',  'ID9' , 'M21',  3,      TO_DATE('12-4-2005 6:6:9',      'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R89',  'ID9' , 'M22',  5,      TO_DATE('7-9-2006 9:5:50',      'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R90',  'ID9' , 'M23',  5,      TO_DATE('12-4-2005 6:5:49',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R91',  'ID9' , 'M24',  4,      TO_DATE('12-4-2005 6:28:30',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R92',  'ID10', 'M25',  5,      TO_DATE('12-4-2005 6:25:10',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R93',  'ID10', 'M26',  0.5,    TO_DATE('12-4-2005 6:40:5',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R94',  'ID10', 'M27',  5,      TO_DATE('12-4-2005 6:19:2',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R95',  'ID10', 'M28',  3.5,    TO_DATE('12-4-2005 6:42:58',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R96',  'ID10', 'M29',  3.5,    TO_DATE('12-4-2005 6:40:38',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R97',  'ID10', 'M30',  4,      TO_DATE('12-4-2005 6:22:20',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R98',  'ID10', 'M31',  5,      TO_DATE('8-19-2007 19:2:15',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R99',  'ID10', 'M32',  4,      TO_DATE('12-4-2005 6:39:11',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R100', 'ID10', 'M33',  5,      TO_DATE('8-19-2007 19:4:30',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R101', 'ID10', 'M34',  2.5,    TO_DATE('12-4-2005 6:17:27',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R102', 'ID10', 'M35',  4,      TO_DATE('12-4-2005 6:31:25',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R103', 'ID10', 'M36',  5,      TO_DATE('12-4-2005 6:25:58',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R104', 'ID10', 'M37',  3,      TO_DATE('12-4-2005 6:43:4',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R105', 'ID10', 'M38',  3.5,    TO_DATE('12-4-2005 6:31:50',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R106', 'ID10', 'M39',  3.5,    TO_DATE('12-4-2005 6:27:4',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R107', 'ID10', 'M40',  2,      TO_DATE('7-9-2006 9:5:47',      'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R108', 'ID10', 'M12',  5,      TO_DATE('12-4-2005 6:26:53',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R109', 'ID10', 'M13',  5,      TO_DATE('12-4-2005 6:23:40',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R110', 'ID10', 'M15',  3.5,    TO_DATE('12-4-2005 6:41:53',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R111', 'ID10', 'M16',  5,      TO_DATE('12-4-2005 6:25:15',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R112', 'ID10', 'M17',  5,      TO_DATE('12-4-2005 6:19:18',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R113', 'ID10', 'M18',  1,      TO_DATE('7-9-2006 9:5:41',      'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R114', 'ID10', 'M19',  5,      TO_DATE('12-4-2005 6:29:8',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R115', 'ID10', 'M20',  5,      TO_DATE('8-19-2007 19:6:20',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R116', 'ID11', 'M21',  5,      TO_DATE('7-9-2006 9:9:38',      'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R117', 'ID11', 'M22',  5,      TO_DATE('12-4-2005 6:24:34',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R118', 'ID11', 'M23',  4,      TO_DATE('12-4-2005 6:22:2',     'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R119', 'ID11', 'M24',  5,      TO_DATE('7-9-2006 9:5:34',      'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R120', 'ID11', 'M25',  4,      TO_DATE('12-4-2005 6:16:25',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));
INSERT INTO Review_table VALUES('R121', 'ID12', 'M40',  1,      TO_DATE('12-4-2005 6:20:21',    'MM-DD-YY HH24:MI:SS'), Vote_type(NULL, NULL), Content_type(NULL, NULL, NULL));

CREATE TABLE Review_TV_table (
    ID              VARCHAR(20) NOT NULL,
    User_ID         VARCHAR(20) NOT NULL,
    TV_network      VARCHAR(20) NOT NULL,
    TV_name         VARCHAR(20) NOT NULL,
    Stars           FLOAT       NOT NULL,
    Review_DATE     DATE        NOT NULL,
    Votes           Vote_type,
    Content         Content_type,
    PRIMARY KEY (ID),
    FOREIGN KEY (User_ID) REFERENCES User_table (ID) ON DELETE CASCADE,
    FOREIGN KEY (TV_network, TV_name) REFERENCES TV_table (TV_network, TV_name) ON DELETE CASCADE,
    CONSTRAINT Rating_TV_Range
        CHECK (Stars > 0 AND Stars <= 5)
);

CREATE TABLE Comment_table (
    User_ID         VARCHAR(20),
    Review_ID       VARCHAR(20),
    Comment_date    DATE,
    Content         CHAR,
    PRIMARY KEY (User_ID, Comment_date),
    FOREIGN KEY (User_ID) REFERENCES User_table (ID) ON DELETE CASCADE
);
------------------------------------------ Photo ---------------------------------------
CREATE TYPE Photo_type AS OBJECT (
    Photo_name          VARCHAR(50),
    Author              VARCHAR(20),
    Photo_Description   VARCHAR(200)
) NOT FINAL;
/
CREATE TYPE Profile_Picture_type UNDER Photo_type (
    User_ID             VARCHAR(20)
);
/
CREATE TYPE Personal_Photo_type UNDER Photo_type (
    Person_ID           VARCHAR(20)
);
/
CREATE TABLE Profile_Picture_table OF Profile_Picture_type (
    PRIMARY KEY (User_ID),
    FOREIGN KEY (User_ID) REFERENCES User_table (ID) ON DELETE CASCADE
);
CREATE TABLE Personal_Photo_table OF Personal_Photo_type (
    PRIMARY KEY (Person_ID)
);

---------------------------------------------- Category ------------------------------------------
CREATE TYPE Category_type AS OBJECT (
    Category_Name       VARCHAR(50),
    Category_Event      VARCHAR(50)   
);
/

CREATE TABLE Person_Category_Nominate_table (
    Person_ID           VARCHAR(20),
    Category            Category_type,
    PRIMARY KEY (Person_ID, Category.Category_Name, Category.Category_Event)
);

CREATE TABLE Person_Category_Win_table (
    Person_ID           VARCHAR(20),
    Category            Category_type,
    PRIMARY KEY (Category.Category_Name, Category.Category_Event)
);

CREATE TABLE Movie_Category_Nominate_table (
    Movie_ID            VARCHAR(20),
    Category            Category_type,
    PRIMARY KEY (Movie_ID, Category.Category_Name, Category.Category_Event),
    FOREIGN KEY (Movie_ID) REFERENCES Movie_table (Serial_No) ON DELETE CASCADE
);

CREATE TABLE Movie_Category_Win_table (
    Movie_ID            VARCHAR(20),
    Category            Category_type,
    PRIMARY KEY (Category.Category_Name, Category.Category_Event),
    FOREIGN KEY (Movie_ID) REFERENCES Movie_table (Serial_No) ON DELETE CASCADE
);