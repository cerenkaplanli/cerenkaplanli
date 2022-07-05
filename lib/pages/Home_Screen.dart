import 'package:filmbox/widgets/upcoming.dart';
import 'package:filmbox/widgets/popular.dart';
import 'package:filmbox/widgets/toprated.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'Search_Screen.dart';
import 'Profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


_signOut() async {
  await _firebaseAuth.signOut();
}

class _HomeScreenState extends State<HomeScreen> {


  final String apikey = '6889568f454ae3a5733fa054841bc65d';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ODg5NTY4ZjQ1NGFlM2E1NzMzZmEwNTQ4NDFiYzY1ZCIsInN1YiI6IjYyOTI0ODQ0MjA5ZjE4MTJjNGIwZDM0NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gJFojnljeAWkVtZ-kbnDEssWPZD0s0zCfw3wH-tdtTE';
  List popularmovies = [];
  List topratedmovies = [];
  List upcoming = [];
  var drawerList=[HomeScreen(),Search_Screen(),Profile()];
  int chosenindex=0;


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
      popularmovies = popularresult['results'];
      topratedmovies = topratedresult['results'];
      upcoming = upcomingresult['results'];
      print(upcoming.length);
    });
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            TopRatedMovies(toprated: topratedmovies,),
            PopularMovies(popular: popularmovies,),
            UpcomingMovies(upcoming: upcoming,),
          ],
        ),
    );

  }
}