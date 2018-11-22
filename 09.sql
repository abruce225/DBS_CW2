SELECT album,
       artist,
       ( totallength - ( totallength%3600 ) ) / 3600          hours,
       ( ( ( totallength%3600 ) - ( totallength%60 ) ) / 60 ) minutes,
       ( totallength%60 )                                     seconds
FROM   ((SELECT album,
               artist,
               Count(*),
               Sum(length) totalLength
        FROM   tracks
        GROUP  BY album,
                  artist)abc
        natural JOIN (SELECT title album,
                             artist,
                             tracks
                      FROM   albums)xyz)fgh
WHERE  count = tracks
ORDER  BY artist;  
