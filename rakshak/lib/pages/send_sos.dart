import 'package:flutter/material.dart';
import 'package:rakshak/models/user.dart';
class SendSOS extends StatefulWidget {

  final User user;
  const SendSOS({Key key, @required this.user})
      : super(key: key);

  @override
  _SendSOSState createState() => _SendSOSState();
}

class _SendSOSState extends State<SendSOS> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialButton(
      onPressed: () {},
      color: Colors.red,
      child: Container(
        height: 200,
        width: 200,
        child: Center(
          child: Text(
            'Send SOS',
            style: TextStyle(color: Colors.white,fontSize: 30),
          ),
        ),
      ),
      elevation: 20,
      splashColor: Colors.red[900],
      // padding: EdgeInsets.all(16),
      shape: CircleBorder(),
    ));
  }
}
