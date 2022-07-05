import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/button.dart';
import '../utils/constants.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String name='';
  bool isloading = false;


  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      var user_uid=FirebaseAuth.instance.currentUser?.uid.toString();
      return users
          .add({
        'name': name,
        'user_uid':user_uid,
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,size: 30,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),


      body: isloading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Form(
        key: formkey,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("photos/photo2.jpg"),
                      fit: BoxFit.cover,
                    )
                ),
                child: SingleChildScrollView(
                  padding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: '1',
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          name = value.toString().trim();
                        },
                        validator: (value) => (value!.isEmpty)
                            ? ' Please enter name'
                            : null,
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                          fillColor: Colors.white,
                          hintText: 'Enter Your Name',
                          prefixIcon: Icon(
                            Icons.person_off_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value.toString().trim();
                        },
                        validator: (value) => (value!.isEmpty)
                            ? ' Please enter email'
                            : null,
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                          fillColor: Colors.white,
                          hintText: 'Enter Your Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Password";
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                            fillColor: Colors.white,
                            hintText: 'Choose a Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            )),
                      ),
                      SizedBox(height: 80),
                      LoginSignupButton(
                        title: 'Register',
                        ontapp: () async {

                          if (formkey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                              FirebaseAuth.instance.currentUser?.updateDisplayName(name);
                              addUser();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.blueGrey,
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Sucessfully Register.You Can Login Now'),
                                  ),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                              Navigator.of(context).pop();

                              setState(() {
                                isloading = false;
                              });
                            } on FirebaseAuthException catch (e) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title:
                                  Text(' Ops! Registration Failed'),
                                  content: Text('${e.message}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Text('Okay'),
                                    )
                                  ],
                                ),
                              );
                            }
                            setState(() {
                              isloading = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}