import 'package:flutter/material.dart';
import 'package:mycoffeeapp/screens/home/home.dart';
import 'package:mycoffeeapp/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:mycoffeeapp/models/user.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    // print('bingo');
    // print(user);
    if(user == null)
      return Authenticate();
    else
      return Home();
  }
}