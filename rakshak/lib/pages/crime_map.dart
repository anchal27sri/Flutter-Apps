import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CrimeMap extends StatefulWidget {
  @override
  _CrimeMapState createState() => _CrimeMapState();
}

class _CrimeMapState extends State<CrimeMap> {
  Matrix4 matrix = Matrix4.identity();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: AssetImage('assets/crime_map.jpg'),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: 4.0,
    ));
  }
}
// Image.asset('assets/crime_map.jpg',)
// PhotoView(
//       imageProvider: Image.asset('assets/crime_map.jpg'),
//       minScale: PhotoViewComputedScale.contained * 0.8,
//       maxScale: 4.0,
//     );
