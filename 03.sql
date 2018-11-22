SELECT country,
       (CAST(CAST(Sum(CASE
             WHEN albums.type = 'STUDIO' THEN 1
             ELSE 0
           END)AS FLOAT)/count(distinct artist) AS NUMERIC(2,1)))stud,
       (CAST(CAST(Sum(CASE
             WHEN albums.type = 'LIVE' THEN 1
             ELSE 0
           END)AS FLOAT)/count(distinct artist) AS NUMERIC(2,1)))live,
       (CAST(CAST(Sum(CASE
             WHEN albums.type = 'COMPILATION' THEN 1
             ELSE 0
           END)AS FLOAT)/count(distinct artist) AS NUMERIC(2,1)))comp
FROM   artists
       JOIN albums
         ON artists.NAME = albums.artist
GROUP  BY country;  
