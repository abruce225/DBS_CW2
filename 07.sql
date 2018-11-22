SELECT title,
       artist,
       year
FROM   (SELECT *
        FROM   (SELECT year,
                       Avg(rating) avgrating
                FROM   albums
                GROUP  BY year
                ORDER  BY year)abc
               natural JOIN (SELECT year,
                                    artist,
                                    title,
                                    rating,
                                    country
                             FROM   artists
                                    JOIN albums
                                      ON NAME = artist
                             WHERE  country = 'GBR'
                             AND    albums.type = 'LIVE'
                             ORDER  BY year)xyz)yui
WHERE  rating > avgrating;  
