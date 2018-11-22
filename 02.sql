SELECT country,
       Sum(CASE
             WHEN type = 'STUDIO' THEN 1
             ELSE 0
           END)stud,
       Sum(CASE
             WHEN type = 'LIVE' THEN 1
             ELSE 0
           END)live,
       Sum(CASE
             WHEN type = 'COMPILATION' THEN 1
             ELSE 0
           END)comp
FROM   (SELECT artists.country,
               albums.type
        FROM albums
             JOIN artists
               ON artists.NAME = albums.artist)countrytype
GROUP BY country;  
