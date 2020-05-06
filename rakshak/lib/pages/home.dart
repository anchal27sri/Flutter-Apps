import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rakshak/models/user.dart';
import 'package:rakshak/models/loading.dart';
import 'package:rakshak/models/slidwindow.dart';
import 'package:rakshak/pages/cards_page.dart';
import 'package:rakshak/pages/crime_map.dart';
import 'package:rakshak/pages/report_crime.dart';
import 'package:rakshak/pages/send_sos.dart';

class Home extends StatefulWidget {
  final User user;
  final FirebaseAuth auth;
  const Home({Key key, @required this.user, @required this.auth})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  List<BottomNavigationBarItem> ls = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
        backgroundColor: Colors.blue),
    BottomNavigationBarItem(
        icon: Icon(Icons.map),
        title: Text('Map'),
        backgroundColor: Colors.blue),
    BottomNavigationBarItem(
        icon: Icon(Icons.record_voice_over),
        title: Text('Report'),
        backgroundColor: Colors.blue),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings_input_antenna),
        title: Text('Send SOS'),
        backgroundColor: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text('Welcome ${widget.user.name}!'),
                leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    }),
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await signOut(widget.auth);
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.person),
                    label: Text('Logout'),
                  ),
                ],
              ),
              drawer: Drawer(
                child: viewMenu(widget.user),
              ),
              backgroundColor: Colors.white,
              body: switchNavigation(_currentIndex),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: ls,
              ),
            ),
          );
  }

  Future signOut(FirebaseAuth auth) async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Widget switchNavigation(int currentIndex) {
    Widget w;
    switch (currentIndex) {
      case 0:
        w = CardsList(user: widget.user);
        break;
      case 1:
        w = CrimeMap();
        break;
      case 2:
        w = ReportCrime(user: widget.user);
        break;
      case 3:
        w = SendSOS(user: widget.user);
        break;
      default:
        w = CardsList(user: widget.user);
    }
    return w;
  }
}
