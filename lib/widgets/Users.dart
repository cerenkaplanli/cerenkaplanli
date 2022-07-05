import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/User_Description.dart';
import '../utils/text.dart';

class Users extends StatelessWidget {
  final List user;
  const Users({Key? key, required this.user}) : super(key: key);


  Future getusers() async {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        user.add(doc['name']);

      }

    });

  }



  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 10),
          Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(


                  scrollDirection: Axis.vertical,
                  itemCount: user.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print(index);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => User_Description(username: user[index].toString(),),
                          ),
                        );

                      },
                      child:
                      user[index]!=null? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('photos/photo3.png'),
                              ),
                              ),

                              height: 50,
                              width: 50,

                            ),
                            SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: modified_text(
                                  size: 17,color: Colors.white,
                                  text: user[index] ?? 'Loading'),
                            )
                          ],
                        ),
                      ):Container(),

                    );
                  }))
        ],
      ),
    );
  }
}
