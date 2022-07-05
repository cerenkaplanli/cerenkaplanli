import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmbox/widgets/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Search_User extends StatefulWidget {
  const Search_User({Key? key}) : super(key: key);

  @override
  State<Search_User> createState() => _Search_UserState();

}

class _Search_UserState extends State<Search_User> {
  List users=[];
  bool issearching=false;


  void _FilterUSers(value){
    setState((){
  users=users.where((users) =>
      users.toLowerCase().toString()
          .contains(value)).toList();
    });
  }
  void deleteUSers(){
    setState((){
      users.removeWhere((user) => user.toString().contains(user.toString()));
    });
  }
  @override
  void initState(){
    super.initState();
load_Users();

    }

  void load_Users(){
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState((){
        users.add(doc["name"]);
        });
        print(users);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: issearching ?
        TextField(
          decoration: InputDecoration(hintText: "write something to search"),
          onChanged: (searchresult) {
            _FilterUSers(searchresult);
          },
        )
            : Text("search user"),

        actions: [
          issearching ?
          IconButton(
              onPressed: () {
                setState(() {
                  issearching = false;
                  deleteUSers();
                  load_Users();

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
      Users(user: users),

    ],
    ) ,






    );
  }
}
