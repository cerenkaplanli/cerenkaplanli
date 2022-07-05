import 'package:flutter/material.dart';
import '../widgets/SplitWidget.dart';
import 'Search_Movies.dart';
import 'Search_user.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Search_Screen(),
      theme: ThemeData(brightness: Brightness.dark,
          primaryColor: Colors.green),
    );
  }
}
class Search_Screen extends StatefulWidget {
  Search_Screen({Key? key}) : super(key: key);



  @override
  _Search_ScreenState createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: SplitWidget(
            childFirst: Search_Movies(),
            childSecond: Search_User(),
          ),
        ));
  }

}

