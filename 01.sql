SELECT country countrycode,
       countband,
       countperson,
       ( countband + countperson ) totalMusicians,
       ( Cast(( Cast(countband AS FLOAT) / ( countband + countperson ) * 100)AS NUMERIC(3, 0))) percentBand,
       ( Cast(( Cast(countperson AS FLOAT) / ( countband + countperson ) * 100) AS NUMERIC(3,0))) percentPerson
FROM   ((SELECT country,
               Count(type) AS countBand
        FROM   artists
        WHERE  type = 'BAND'
        GROUP  BY country)bandTable
        NATURAL JOIN (SELECT country,
                              Count(type) AS countPerson
                       FROM   artists
                       WHERE  type = 'PERSON'
                       GROUP  BY country) personTable );  


