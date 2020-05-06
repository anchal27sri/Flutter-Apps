import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.blue[200],
        child: SpinKitFadingCube(
          size: 50,
          color: Colors.blue,
        ),
      ),
    );
  }
}
