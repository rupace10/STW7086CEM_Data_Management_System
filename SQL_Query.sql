Part B

 

1. Use appropriate data types and write the SQL statements to create the tables defined in the

schema above.

 

 

CREATE TABLE PUBLIC.USER(

    UserId VARCHAR(10) PRIMARY KEY,

    Name VARCHAR(50),

    EmailAddress VARCHAR(100)

);

 

-- Insert sample data

INSERT INTO PUBLIC.USER (UserId, Name, EmailAddress) VALUES

    ('simon3', 'Simon, S', 'simon3@hotmail.co.uk'),

    ('talia11', 'Talia, J', 'talia11@ntl.co.uk'),

    ('toby05', 'Toby, T', 'toby05@freeserve.co.uk'),

    ('margot9', 'Margot, C', 'margot9@msn.co.uk'),

    ('ethan77', 'Ethan, R', 'ethan77@hotmail.co.uk'),

    ('harry704', 'Harry, S', 'harry704@hotmail.co.uk');

   

  

  

 ---------------------

 -- Create the Movie table

CREATE TABLE PUBLIC.MOVIE (

    movieId VARCHAR(5) PRIMARY KEY,

    title VARCHAR(100),

    categoryCode VARCHAR(5),

    costPerDownload DECIMAL(5, 2)

);

 

-- Insert sample data

INSERT INTO PUBLIC.MOVIE (movieId, title, categoryCode, costPerDownload) VALUES

    ('M001', 'The Imitation Game', 'MO13', 0.99),

    ('M002', 'The Duchess', 'MO13', 1.99),

    ('M003', 'Trainspotting', 'MO11', 1.49),

    ('M004', 'The Dig', 'MO11', 1.79),

    ('M005', 'Elizabeth', 'MO13', 1.50),

    ('M006', 'Sherlock Holmes', 'MO12', 1.10),

    ('M007', 'Moon', 'MO12', 0.89),

    ('M008', 'Interstellar', 'MO14', 0.5),

    ('M009', 'Django', 'MO14', 0.6),

    ('M0010', 'Zodiac', 'MO14', 0.7);

   

   

  ------create DownloadMovie table

 

  CREATE TABLE public.DownloadMovie (

    userId VARCHAR(10),

    movieId VARCHAR(5),

    downloadDate DATE,

    PRIMARY KEY (userId, movieId),

    FOREIGN KEY (userId) REFERENCES public.User(UserId),

    FOREIGN KEY (movieId) REFERENCES PUBLIC.Movie(movieId)

);

   

   INSERT INTO DownloadMovie (userId, movieId, downloadDate) VALUES

    ('simon3', 'M001', '2023-01-01'),

    ('talia11', 'M003', '2023-01-02'),

    ('toby05', 'M005', '2023-01-03'),

    ('margot9', 'M002', '2023-01-04'),

    ('ethan77', 'M004', '2023-01-05'),

    ('simon3', 'M006', '2023-01-06'),

    ('talia11', 'M007', '2023-01-07'),

    ('toby05', 'M008', '2023-01-08'),

    ('ethan77', 'M009', '2023-01-08'),

    ('toby05', 'M0010', '2023-01-08');

   

   

   ----

  

   -- Create the Category table

CREATE TABLE public.Category (

    title VARCHAR(100) PRIMARY KEY,

    categoryCode VARCHAR(5) UNIQUE

);

 

-- Insert sample data

INSERT INTO public.Category (title, categoryCode) VALUES

    ('Sci-Fi', 'MO13'),

    ('Drama', 'MO11'),

    ('Action', 'MO12'),

    ('Pop-Rock', 'MO14');

 

 

 

 

q.2 Write SQL Statements to return the following data from the online movie database:

 

--a

--The movie id, the title and the categoryCode of all the movie in the database, ordered by title.

 

SELECT movieid,title,categoryCode from public.movie

ORDER BY title;

 

--b

-- The number of users who downloaded ‘Pop-Rock’ category of movie.

 

SELECT COUNT(DISTINCT dm.userId) AS Users_count

FROM PUBLIC.DownloadMovie dm

JOIN public.Movie m ON dm.movieId = m.movieId

JOIN public.Category c ON m.categoryCode = c.categoryCode

WHERE c.title = 'Pop-Rock';

 

 

--c
-- The number of movie downloads for each of the categories. The result listing should

--include the titles of the categories and the number of movie downloads for each category

--title.

 

SELECT c.title as title,COUNT(dm.movieId) AS Movie_downloads

FROM PUBLIC.DownloadMovie dm

JOIN public.Movie m ON dm.movieId = m.movieId

JOIN public.Category c ON m.categoryCode = c.categoryCode

group by c.title

 

--d

--The titles of the categories for which movie was downloaded more than once.

 

SELECT c.title AS title

FROM public.DownloadMovie dm

JOIN PUBLIC.Movie m ON dm.movieId = m.movieId

JOIN public.Category c ON m.categoryCode = c.categoryCode

group by c.title

having COUNT(dm.movieId)>1

 

 

 

 

 

 

Part C

 

1.

Assuming that the data is stored in a relational database produce, with justification, the SQL code to determine, for each product, the number of products which were sold in each month of each year.

 

 

CREATE TABLE public.SalesData (

    OrderNo INT,

    ProductNo INT,

    Price FLOAT,

    Quantity INT,

    Sales FLOAT,

    QtrId INT,

    MonthId INT,

    YearId INT

);

 

INSERT INTO public.SalesData VALUES (10107, 2, 85.7, 30, 2587, 1, 2, 2003);

INSERT INTO public.SalesData VALUES (10107, 5, 95.8, 39, 3879.49, 1, 2, 2003);

INSERT INTO public.SalesData VALUES (10121, 5, 71.5, 34, 2700, 1, 2, 2003);

INSERT INTO public.SalesData VALUES (10134, 2, 94.74, 41, 3884.34, 3, 7, 2004);

INSERT INTO public.SalesData VALUES (10134, 5, 100, 27, 3307.77, 3, 7, 2004);

INSERT INTO public.SalesData VALUES (10159, 14, 100, 49, 5205.27, 4, 10, 2005);

INSERT INTO public.SalesData VALUES (10168, 1, 96.66, 36, 3479.66, 4, 10, 2006);

INSERT INTO public.SalesData VALUES (10180, 12, 100, 42, 4695.6, 4, 11, 2006);

 

 

select * FROM public.SalesData

 

select productno,monthid,yearid,count(*) from public.SalesData

group by 1,2,3

order by 1,2,3 desc