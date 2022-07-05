import 'package:flutter/material.dart';
import 'pages/Home_Screen.dart';
import 'pages/Search_Movies.dart';
import 'pages/Profile.dart';
import 'pages/Search_Screen.dart';

class Main2 extends StatefulWidget {
  const Main2({Key? key}) : super(key: key);

  @override
  State<Main2> createState() => _Main2State();
}

class _Main2State extends State<Main2> {
  List screen=[HomeScreen(),Search_Screen()];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3 ,
      child: Scaffold(
        appBar: AppBar(
          title: Text("FILMBOX"),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: "Home",icon: Icon(Icons.add_home_work_outlined),),
              Tab(text: "Search",icon: Icon(Icons.search_off_outlined),),
              Tab(text: "Profile",icon: Icon(Icons.account_circle_outlined),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            Search_Screen(),
            Profile(),
          ],
        ),
      ),

    );
  }
}

