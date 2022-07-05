class DBmovies{
  String user_uid;
  String movie_name;

  DBmovies(this.user_uid, this.movie_name);
  factory DBmovies.fromJson(Map<dynamic,dynamic>json){
    return DBmovies(json["user_uid"] as String, json["movie_name"]as String);
  }
}