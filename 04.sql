SELECT distinct fiverated.NAME,
       debutyear
FROM   (SELECT NAME,
               title,
               year fiveYear
        FROM   artists
               JOIN albums
                 ON artists.NAME = albums.artist
        WHERE  country = 'USA'
               AND rating = 5
               AND artists.type = 'BAND'
               AND albums.type = 'STUDIO')fiverated
       JOIN (SELECT NAME,
                    Min(year) debutYear
             FROM   artists
                    JOIN albums
                      ON artists.NAME = albums.artist
             WHERE  country = 'USA'
                    AND artists.type = 'BAND'
                    AND albums.type = 'STUDIO'
             GROUP  BY NAME)debuts
         ON debutyear = fiveyear
WHERE  fiverated.NAME = debuts.NAME;  
