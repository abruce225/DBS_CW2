SELECT name
FROM   artists
WHERE  NAME NOT IN (SELECT DISTINCT artist
                    FROM   (SELECT artist,
                                   firsttitle,
                                   Min(secondyear - firstyear)
                            FROM   (SELECT albums.artist,
                                           albums.title  firstTitle,
                                           albums.year   firstYear,
                                           albums2.title secondTitle,
                                           albums2.year  secondYear
                                    FROM   albums,
                                           albums AS albums2
                                    WHERE  albums.artist = albums2.artist
                                           AND albums.type = 'STUDIO'
                                           AND albums2.type = 'STUDIO'
                                           AND albums.title != albums2.title
                                           AND albums2.year - albums.year > 0
                                    ORDER  BY albums.artist,
                                              firstyear,
                                              secondyear)abc
                            GROUP  BY artist,
                                      firsttitle
                            ORDER  BY artist)xyz
                    WHERE  min > 4) 
ORDER BY name; 
