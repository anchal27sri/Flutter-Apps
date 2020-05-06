import 'package:flutter/material.dart';

class Sending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.blue[200],
        child: Center(
          child: Text('SENDING....\n please wait',style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),),
        )
      ),
    );
  }
}
