class Songs {
  var id = "";
  var title = "";
  var category_id = "";
  Songs(
    this.id,
    this.title,
    this.category_id,
  );
}

class SongsData {
  var id = "";
  var display_index = "";
  var song_index_id = "";

  var title = "";
  var lyrics = "";

  var youtube_link = "";
  SongsData(this.id, this.song_index_id, this.title, this.lyrics,
      this.youtube_link, this.display_index);
}

List<SongsData> songsData = [];
List<SongsData> songsData2 = songsData;
List<Songs> songs = [];
List<Songs> songs2 = songs;
