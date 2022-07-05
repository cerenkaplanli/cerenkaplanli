import 'package:filmbox/widgets/searched.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Search_Movies(),
      theme: ThemeData(brightness: Brightness.dark,
          primaryColor: Colors.green),
    );
  }
}

class Search_Movies extends StatefulWidget {
  @override
  _Search_MoviesState createState() => _Search_MoviesState();
}

class _Search_MoviesState extends State<Search_Movies> {
  bool issearching=false;

  final String apikey = '6889568f454ae3a5733fa054841bc65d';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ODg5NTY4ZjQ1NGFlM2E1NzMzZmEwNTQ4NDFiYzY1ZCIsInN1YiI6IjYyOTI0ODQ0MjA5ZjE4MTJjNGIwZDM0NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gJFojnljeAWkVtZ-kbnDEssWPZD0s0zCfw3wH-tdtTE';

  List movies = [];

  @override
  void initState() {
    super.initState();
    loadmovies();


  }
  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map popularresult = await tmdbWithCustomLogs.v3.movies.getPopular();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map upcomingresult = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    setState(() {
      movies = topratedresult['results']+popularresult['results']+upcomingresult['results'];
    });

  }

  void deleteMovie(){
    setState((){
      movies.removeWhere((movie) => movie.toString().contains(movie.toString()));
    });
  }
  void _FilterMovies(value){
    setState((){
      movies=movies.where((movies) =>
          movies["title"].toLowerCase()
              .contains(value.toLowerCase())).toList();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: issearching ?
          TextField(
            decoration: InputDecoration(hintText: "write movie name to search"),
            onChanged: (searchresult) {
              _FilterMovies(searchresult);
            },
          )
              : Text("search movie"),

          actions: [
            issearching ?
            IconButton(
                onPressed: () {
                  setState(() {
                    issearching = false;
                    loadmovies();
                  }
                  );
                },
                icon: Icon(Icons.cancel))

                : IconButton(
                onPressed: () {
                  setState(() {
                    issearching = true;
                  }
                  );
                },
                icon: Icon(Icons.search)
            ),
          ],
        ),
        backgroundColor: Colors.black,
    body: ListView(
          children:[
            Searched(searched: movies,),
          ],
        ) ,

    );
  }
}
