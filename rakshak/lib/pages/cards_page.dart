import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:rakshak/models/user.dart';

class CardsList extends StatefulWidget {
  final User user;
  const CardsList({Key key, @required this.user}) : super(key: key);
  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  final Map<String, double> dataMap = Map();

  final List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.grey,
  ];

  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Theft", () => 5);
    dataMap.putIfAbsent("Robbery", () => 3);
    dataMap.putIfAbsent("Murder", () => 2);
    dataMap.putIfAbsent("Hit and Run", () => 2);
    dataMap.putIfAbsent("Others", () => 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10.0,
              child: Column(
                children: <Widget>[
                  Text(
                    'Crime in Your City',
                    style: TextStyle(fontSize: 20),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Your City\'s crime rate: 77%'),
                      PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 8.0,
                        chartRadius: MediaQuery.of(context).size.width / 6,
                        chartValueBackgroundColor: Colors.grey[200],
                        colorList: colorList,
                        legendPosition: LegendPosition.left,
                        decimalPlaces: 1,
                        initialAngle: 0,
                        chartValueStyle: defaultChartValueStyle.copyWith(
                          color: Colors.blueGrey[900].withOpacity(0.9),
                        ),
                        chartType: ChartType.ring,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Recent Crimes in Your Area',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/theft.jpg',
                            height: 80,
                            width: 80,
                          ),
                          Text('Theft'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('assets/robbery.jpg',
                              height: 80, width: 80),
                          Text('Robbery'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('assets/murder.jpg',
                              height: 80, width: 80),
                          Text('Murder'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Image.asset('assets/hitandrun.jpg',
                              height: 80, width: 80),
                          Text('Hit and Run'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Police Stations near you',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(
                        Icons.pin_drop,
                        size: 40,
                      ),
                      Text(
                        'Click to show on map',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Image.asset('assets/police.jpg', height: 100, width: 80),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'NGOs near you',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(
                        Icons.pin_drop,
                        size: 40,
                      ),
                      Text(
                        'Click to show on map',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Image.asset('assets/ngo.png', height: 100, width: 80),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Safety measures you should take if you feel you are in an unsafe area.',
                  style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
