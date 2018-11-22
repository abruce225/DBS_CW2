SELECT artist,
       Max(min) longestgap
FROM   (SELECT artist,
               firsttitle,
               Min(secondyear - firstyear)
        FROM   (SELECT albums.artist,
                       albums.title  firsttitle,
                       albums.year   firstyear,
                       albums2.title secondtitle,
                       albums2.year  secondyear
                FROM   albums,
                       albums AS albums2
                WHERE  albums.artist = albums2.artist
                       AND albums.title != albums2.title
                       AND albums2.year - albums.year >= 0
                ORDER  BY albums.artist,
                          firstyear,
                          secondyear)abc
        GROUP  BY artist,
                  firsttitle)ghj
GROUP  BY artist
ORDER  BY artist;  
