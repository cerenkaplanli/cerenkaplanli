import 'dart:collection';
import 'package:filmbox/DBmovies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:filmbox/utils/text.dart';

class Description extends StatefulWidget {


  final String name, description, bannerurl, posterurl, vote, launch_on;
  const Description(
      {Key? key,
        required this.name,
        required this.description,
        required this.bannerurl,
        required this.posterurl,
        required this.vote,
        required this.launch_on,
      })
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  var refmovie=FirebaseDatabase.instance.ref().child("movies/");
  var useruid=FirebaseAuth.instance.currentUser?.uid.toString();

  @override
  void initState(){
    super.initState();
  }
  Future<void>AddMovie()async{
    var movie=HashMap<String,dynamic>();
    movie["user_uid"]=useruid;
    movie["movie_name"]=widget.name;
    refmovie.push().set(movie);

  }
  Future<void>AllMovies()async{
    refmovie.onValue.listen((event) {
      Map<dynamic, dynamic> comingmovies  = event.snapshot.value as Map;
      if(comingmovies!=null){

        comingmovies.forEach((key,object){
          var comingmovie=DBmovies.fromJson(object);
          print("--------------------------");
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
      body: Container(
        child: ListView(children: [
          Container(
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    child: modified_text(text: '⭐ Average Rating - ' + widget.vote,size:14,color: Colors.white,)),
              ])),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(10),
              child: modified_text(
                  text: widget.name != null ? widget.name : 'Not Loaded', size: 24,color: Colors.white,)),
          Container(
              padding: EdgeInsets.only(left: 10),
              child:
                  modified_text(text: 'Releasing On - ' + widget.launch_on, size: 14,color: Colors.white,)),
          Row(
            children: [
              Container(
                height: 200,
                width: 100,
                child: Image.network(widget.posterurl),
              ),
              Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: modified_text(text: widget.description, size: 18,color: Colors.white,)),
              ),
            ],
          ),
          Column(
            children:[
              SizedBox(
                height:40.0,
                width: 110.0,
                child: ElevatedButton(
                  onPressed: (){
                    print(widget.name+" has watched");
                    AddMovie();

                  },

                  child: Text(
                    "watched",
                    style: TextStyle(fontSize: 20,color: Colors.black),
                  ),

                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amberAccent ),
                  ),

                ),
              ),],
          ),
        ]),
      ),
    );
  }
}
