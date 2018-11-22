SELECT title,
       artist,
       firstyear AS year,
       firstrating AS rating
FROM   (SELECT firsttitle title,
               firstartist artist,
               firstyear,
               firstrating,
               Sum(CASE
                     WHEN firstrating < secondrating THEN 1
                     WHEN firstyear = secondyear AND firsttitle = secondtitle AND firstartist = secondartist THEN 1
                     ELSE 0
                   END)         ltSub,
               Count(*) allSub
        FROM   (SELECT albums.artist firstArtist,
                       albums.title   firstTitle,
                       albums.year    firstYear,
                       albums.rating  firstRating,
                       albums2.artist secondArtist,
                       albums2.title  secondTitle,
                       albums2.year   secondYear,
                       albums2.rating secondRating
                FROM   albums,
                       albums AS albums2
                WHERE  albums.artist = albums2.artist
                       AND ((albums2.year - albums.year > 0) OR (albums.title = albums2.title AND albums.artist = albums2.artist))
                ORDER  BY firstArtist,
                          firstyear,
                          secondyear)all_sub_albums
        GROUP  BY firsttitle,
                  firstrating,
                  firstartist,
                  firstyear
        ORDER  BY firsttitle)less_than_all_sub
WHERE  ltsub = allsub
       AND (allsub != 1 OR firstrating != 5 )
ORDER  BY artist,
          firstyear;  
