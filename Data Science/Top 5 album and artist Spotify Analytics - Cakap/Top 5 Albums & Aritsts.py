# -*- coding: utf-8 -*-
"""
Created on Fri Nov 11 06:13:45 2022

@author: avifa
"""

import numpy as np
import pandas as pd

track = pd.read_csv('songs.csv')
album = pd.read_csv('albums.csv')
artis = pd.read_csv('artists.csv')

analytics_album = pd.merge(track,album,on='album_id')
analytics_album = analytics_album.iloc[:,[8,11,12,13,14]]
analytics_album = analytics_album.groupby(analytics_album.columns.tolist(),as_index=False).size()
analytics_artist = pd.merge(track,artis,on='artist_id')
analytics_artist = analytics_artist.iloc[:,[9,11,12]]
analytics_artist = analytics_artist.groupby(analytics_artist.columns.tolist(),as_index=False).size()

top_5_artists = analytics_artist.sort_values('size',ascending=False,kind='stable').head(5)
top_5_albums = analytics_album.sort_values('size',ascending=False,kind='stable').head(5)

top_5_albums = top_5_albums.rename(columns={'url_y':'url','size':'time of played'})
top_5_artists = top_5_artists.rename(columns={'url_y':'url','size':'time of played'})

top_5_albums.to_csv('top_5_albums.csv')
top_5_artists.to_csv('top_5_artist.csv')
