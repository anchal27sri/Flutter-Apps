import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rakshak/pages/home.dart';
import 'signup.dart';
import 'package:rakshak/models/loading.dart';
import 'package:rakshak/models/user.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  String error;
  String _email, _password;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final databaseReference = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    loading = false;
    error = "";
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Form(
                key: _formkey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 40,),
                    Image.asset(
                      'assets/safety.jpg',
                      height: 200,
                    ),
                    SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 8.0),
                      child: TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'please type your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            )),
                        onSaved: (input) => (_email = input),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 8.0),
                      child: TextFormField(
                        validator: (input) {
                          if (input.length < 6) {
                            return 'length of password should be greater than 5';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            )),
                        obscureText: true,
                        onSaved: (input) => (_password = input),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140, vertical: 8),
                      child: RaisedButton(
                        onPressed: () {
                          signIn();
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                      child: Container(child: Text('Do not have an account?')),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 250, 0),
                      child: GestureDetector(
                        child: Text(
                          'Sign up',
                          style: TextStyle(fontSize: 20.0, color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                          child: Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> signIn() async {
    final formstate = _formkey.currentState;
    print('hello');
    if (formstate.validate()) {
      formstate.save();
      setState(() {
        loading = true;
      });
      try {
        FirebaseUser fuser = (await _auth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .user;
        print('1:' + fuser.toString());
        dynamic user = await fetchUserData(fuser).then((value) {
          return value;
        }, onError: (er) {
          print(er);
        });
        print(user.email);
        error = "";
        setState(() {
          loading = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      user: user,
                      auth: _auth,
                    )));
        print(user.email);
      } catch (e) {
        error = e.toString();
        print("here");
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<User> fetchUserData(FirebaseUser fuser) async {
    User user;
    await databaseReference
        .collection("users")
        .document(fuser.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      Map<String, dynamic> mp = snapshot.data;
      // print(mp);
      user = User(
        name: mp['name'],
        aadhaar: mp['aadhaar'],
        age: mp['age'],
        phoneNo: mp['phone_no'],
        email: _email,
        uid: fuser.uid,
      );
    });
    print(user.name);
    return user;
  }
}
