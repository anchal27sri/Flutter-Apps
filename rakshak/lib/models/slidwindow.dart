import 'package:flutter/material.dart';
import 'user.dart';

Widget viewMenu(User user) {
  return ListView(
    children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
            color: Colors.green,
            gradient: LinearGradient(colors: [Colors.green, Colors.blue])),
        child: Center(
            child: Column(
          children: <Widget>[
            Icon(
              Icons.person,
              size: 100.0,
            ),
            Text(user.name),
          ],
        )),
      ),
      ListTile(
        leading: Icon(Icons.person_outline),
        title: Text('Your Profile'),
      ),
      ListTile(
        leading: Icon(Icons.people_outline),
        title: Text('People Who You Know'),
      ),
      Divider(height: 10.0,thickness: 2.0,indent: 10.0,endIndent: 10.0,),
      ListTile(
        leading: Icon(Icons.history),
        title: Text('Report History'),
      ),
      ListTile(
        leading: Icon(Icons.history),
        title: Text('SOS History'),
      ),
      Divider(height: 10.0,thickness: 2.0,indent: 10.0,endIndent: 10.0,),
      ListTile(
        leading: Icon(Icons.help_outline),
        title: Text('Help'),
      ),
      ListTile(
        leading: Icon(Icons.info_outline),
        title: Text('About This App'),
      ),
      ListTile(
        leading: Icon(Icons.info_outline),
        title: Text('About Us'),
      ),
      ListTile(
        leading: Icon(Icons.contacts),
        title: Text('Contact Us'),
      ),
    ],
  );
}
