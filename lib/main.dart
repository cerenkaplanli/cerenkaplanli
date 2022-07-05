import 'package:filmbox/pages/Login_Screen.dart';
import 'package:filmbox/pages/Register_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'FilmBox'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {

    var screenInfo=MediaQuery.of(context);
    final screenHeight=screenInfo.size.height;
    final screenWidht=screenInfo.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("photos/photo1.jpg"),
              fit: BoxFit.cover,
            )
        ),

        //You can use any widget
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100,right: 30,left:30 ,bottom:100),
                  child: Text("FILMBOX",style: TextStyle(color: Colors.white,fontSize:80,fontWeight: FontWeight.w900,),),
                ),


                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: screenHeight/15 ,
                    width: screenWidht/3,
                    child: ElevatedButton(
                      child: Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown,fontSize: 22),),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.white,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0,left: 8,right: 8),
                  child: SizedBox(
                    height: screenHeight/15 ,
                    width: screenWidht/3,
                    child: ElevatedButton(
                      child: Text('Sing up',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown,fontSize: 22),),
                      onPressed: () {

                         Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.white,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}



