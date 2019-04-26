Author name: Dewen Qi


Tables and Types created:
Comment_table;
Review_table;
Review_TV_table;
Person_Category_Nominate_table;
Person_Category_Win_table;
Movie_Category_Nominate_table;
Movie_Category_Win_table;
Scene_table;
Movie_Genre_table;
Movie_Cast_table;
Movie_table;
TV_Episode_Cast_table;
Episode_table;
TV_table;
Profile_Picture_table;
Personal_Photo_table;
User_table;
Director_table;
Actor_table;
Adult_table;
Minor_table;
Personal_Photo_type;
Profile_Picture_type;
Photo_type;
User_type;
Director_type;
Actor_type;
Adult_type;
Minor_type;
Person_type;
Individual_type; 
Vote_type;
Content_type;
Category_type;


Assumptions:
1.Since users rate a movie by clicking the Stars in a review, so I integrate the data of RATING tag in excel data file into the Review_table and use the table's Stars attribute to represent the rating.
2.The Review ID is not provided in the RATING tag of the excel data file but it is required by the Review entity in assignment 1, so I insert this attribute value to the Review_table.
3.There's a data conflict between ROLLS and MOVIE tags in the excel data files: 
    In the ROLLS table, P5 and P6 act in M31 but in MOVIE table, P8 and P9 act in M31. 
    I take the ROLLS table as the correct one.


Execution results:
1.
SQL> @q1.sql

FIRST_NAME	     LAST_NAME
-------------------- --------------------
Natalie 	     Portman
Liam		     Neeson
Daisy		     Ridley
Hayden		     Christensen
John		     Boyega
Ewan		     McGregor
Oscar		     Isaac


2.
SQL> @q2.sql

FIRST_NAME	    LAST_NAME	    MCOUNT
--------------- --------------- ----------
Steven		    Spielberg		11
Luc		        Besson			10
Brian		    de forma		 9

3.
SQL> @q3.sql

FULL_NAME                   TITLE                           YEAR
---------------------------- ------------------------------- ------------
Luc Besson                  My big fat greek wedding        2000
Barry Jenkins               Moonlight                       2016
Brian de forma              Get To Know Your Rabbit         1972
Brian de forma              Lights Out                      2016
Luc Besson                  The Big Blue                    1988
Steven Spielberg            Lincoln                         2012


4.
SQL> @q4.sql

Table created.


ID		             FIRST_NAME      LAST_NAME	     BIRTHDAY  G
-------------------- --------------- --------------- --------- -
BIRTHPLACE
--------------------
P34		             Harrison	     Ford	         13-JUL-42 M
Chicago

P9		             Tom	         Hanks	         19-MAY-64 M
Perth


Table dropped.


5.
Assumption:
- The 'actors' in this question refer to both male and female actors.

SQL> @q5.sql

ID		             FIRST_NAME      LAST_NAME	     BIRTHDAY  G
-------------------- --------------- --------------- --------- -
BIRTHPLACE
--------------------
P9		             Tom	         Hanks	         19-MAY-64 M
Perth

6.
SQL> @q6.sql

TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
Angels and Daemons
	4.5

Moonlight
	4.5

Lincoln
	  4


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
Mr. and Mrs Smith
	3.5

Schindler's List
	3.5

Arthur and the Invisibles
	  3


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
Indiana Jones and the Kingdom of the Crystal Skull
	  3

Scarface
	  3

Her
	2.5


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
Mission: Impossible
	2.5

Star Wars: Episode II - Attack of the Clones
	2.5

Star Wars: Episode III - Revenge of the Sith
	2.5


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
Star Wars: The Force Awakens
	2.5

Arthur and the Revenge of Maltazard
	  2

Barely Lethal
	  2


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
Catch me if you can
	  2

Indiana Jones and the Last Crusade
	  2

Saving Private Ryan
	  2


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
Scent of a women
	  2

Star Wars: Episode I - The Phantom Menace
	  2

The Da Vinci Code
	  2


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
The God Father part II
	  2

Arthur 3: The War of the Two Worlds
	1.5

Indiana Jones and the Temple of Doom
	1.5


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
Lights Out
	1.5

The Terminal
	1.5

The adventures of Tintin
	1.5


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
Arthur and the Invisibles: The Making of the Year's Greatest Adventure
	  1

Minority Report
	  1

The Island
	  1


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
The Man with one red shoe
	  1

Wise Guys
	  1

Lucy
	 .5


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
My big fat greek wedding
	 .5

The Polar Express
	 .5

War Horse
	 .5


TITLE
--------------------------------------------------------------------------------
RATING_SPAN
-----------
Get To Know Your Rabbit
	  0

The Big Blue
	  0

The Black Dahlia
	  0


39 rows selected.

7.
SQL> @q7.sql

ACTRESS_FULLNAME		            ACTOR_FULLNAME			    MOVIE_COUNT
------------------------------- ------------------------------- ----------
Natalie Portman 		            Ewan McGregor				 3
Mia Farrow			                Freddie Highmore			 2
Natalie Portman 		            Hayden Christensen			 2
Scarlett Johanson		            Morgan Freeman				 2
Jessica Alba			            Tom Hanks				     2


8.
Assumption:
- "Actors" in this question refer to both female and male actors.
- Those actors, who act in less than or equal to one movie, will not be taken into account here.

SQL> @q8.sql

ID		             FIRST_NAME      LAST_NAME	     BIRTHDAY  G
-------------------- --------------- --------------- --------- -
BIRTHPLACE
--------------------
P52		             Freddie	     Highmore	     14-FEB-92 M
London


9.
SQL> @q9.sql

Table created.


AVERAGE_BEFORE2005 AVERAGE_AFTER2005 DIFFERENCE
------------------ ----------------- ----------
	    3.92807018	       3.67416667 .253903509


Table dropped.


10.
TO NOTE:
- There's a conflict between ROLLS and MOVIE tags in the excel data files: 
-- In the ROLLS table, P5 and P6 act in M31 but in MOVIE table, P8 and P9 act in M31. 
-- I take the ROLLS table as the correct one so P8 is not in the result list of this question.

SQL> @q10.sql

Table created.


ID		             FIRST_NAME      LAST_NAME	     BIRTHDAY  G
-------------------- --------------- --------------- --------- -
BIRTHPLACE
--------------------
P13		             Leonardo	     DiCaprio	     11-NOV-74 M
Los Angeles

P18		             Jennifer	     Lawrence	     02-FEB-62 F
London

P7		             Angelina	     Jolie	         03-MAR-70 F
Seattle


ID		             FIRST_NAME      LAST_NAME	     BIRTHDAY  G
-------------------- --------------- --------------- --------- -
BIRTHPLACE
--------------------
P12		             Alex	         Parish	          09-JUL-77 F
San Jose

P11		             Catherine	     Jones	          29-SEP-69 F
Swansea

P3		             Scarlett	     Johanson	      22-NOV-84 F
Austin


ID		             FIRST_NAME      LAST_NAME	     BIRTHDAY  G
-------------------- --------------- --------------- --------- -
BIRTHPLACE
--------------------
P10		             Jessica	     Alba	         07-AUG-83 F
Seoul


7 rows selected.


Table dropped.

