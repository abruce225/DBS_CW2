SELECT album,
       albumartist,
       tracks_in_albums,
       tracks_in_tracks,
       (100 - Cast(( Cast(tracks_in_tracks AS FLOAT) / tracks_in_albums ) * 100 AS NUMERIC(4, 1))) percentMissing,
       (CASE WHEN tracks_in_tracks > 0 THEN cast((avg * tracks_in_albums) AS INT) ELSE NULL END) albumsLength
FROM   (SELECT album,
               albumartist,
               Max(tracks)       tracks_in_albums,
               Count(tracktitle) tracks_in_tracks,
               AVG(tracklength)
        FROM   (SELECT albuminf.title album,
                       albumartist,
                       tracks,
                       trackinf.title tracktitle,
                       tracklength
                FROM   (SELECT title,
                               artist albumartist,
                               tracks
                        FROM   albums
                        WHERE  type = 'COMPILATION')albuminf
                       LEFT OUTER JOIN (SELECT album,
                                    title,
                                    artist trackartist,
                                    length tracklength
                             FROM   tracks)trackinf
                         ON albuminf.title = trackinf.album AND trackartist = albumartist)allinf
        GROUP  BY album,
                  albumartist
        ORDER  BY albumartist)finalinf;  
