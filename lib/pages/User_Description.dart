import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmbox/utils/text.dart';
import 'package:filmbox/widgets/watched.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import '../DBmovies.dart';

class User_Description extends StatefulWidget {
 final String username;

  const User_Description({Key? key, required this.username}) : super(key: key);
  @override
  _User_DescriptionState createState() => _User_DescriptionState();

}

class _User_DescriptionState extends State<User_Description> {

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
 // var uid;

  var userDisplayName=FirebaseAuth.instance.currentUser?.displayName.toString();
  final String apikey = '6889568f454ae3a5733fa054841bc65d';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ODg5NTY4ZjQ1NGFlM2E1NzMzZmEwNTQ4NDFiYzY1ZCIsInN1YiI6IjYyOTI0ODQ0MjA5ZjE4MTJjNGIwZDM0NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.gJFojnljeAWkVtZ-kbnDEssWPZD0s0zCfw3wH-tdtTE';
  List watchedmovies=[];
  List movieList=[];
  List filteredmovielist=[];
  List newm=[];





  DatabaseReference ref = FirebaseDatabase.instance.ref();

  var refmovie=FirebaseDatabase.instance.ref().child("movies/");
  var a=FirebaseDatabase.instance.app.options.androidClientId;

  @override
  void initState() {
    super.initState();
    loadmovies();
    getUserId();
    FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: widget.username)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final uid=doc["user_uid"];
        var userid=refmovie.orderByChild("user_uid").equalTo(uid);
        userid.onValue.listen((event) {
          Map<dynamic, dynamic> comingmovies  = event.snapshot.value as Map;
          if(comingmovies!=null){
            comingmovies.forEach((key, value) {
              var comingmovie=DBmovies.fromJson(value);
              movieList.add(comingmovie.movie_name.toString());
              filteredmovielist=movieList.toSet().toList();
            });
          }
          else{
            print("there is no movie");
          }
        });


      });

    });

   // print(uid);

  }


  void getUserId(){


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
      watchedmovies = topratedresult['results']+upcomingresult['results']+popularresult['results'];

      print(movieList.length);
      for (var i = 0; i<filteredmovielist.length ; i++) {
        try {
          newm.addAll(watchedmovies.where((watchedmovies) =>
              watchedmovies['title'].toLowerCase().contains(
                  filteredmovielist[i].toLowerCase())).toList());
          newm = newm.toSet().toList();
        }catch(Exception){
          print("no movie watched");

        }
      }
    });

  }

  Future<void>AllMovies()async{
    refmovie.onValue.listen((event) {
      Map<dynamic, dynamic> comingmovies  = event.snapshot.value as Map;
      if(comingmovies!=null){

        comingmovies.forEach((key,value){
          var comingmovie=DBmovies.fromJson(value);
          print("user_key: $key");
          print("user uid: ${comingmovie.user_uid}");
          print("watched movie: ${comingmovie.movie_name}");


        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body:SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:60,bottom: 20),
              child: Center(
                child: new Image.asset('photos/photo3.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child:
              modified_text(text: widget.username+"'s profile", color: Colors.white, size: 25),

            ),

            Container(
              height: 400,
              width: MediaQuery. of(context). size. width ,
              child: ListView(

                children: [
                  WatchedMovies(watched:newm),
                ],

              ),
            ),
          ],),
      ),
    );



  }

}

