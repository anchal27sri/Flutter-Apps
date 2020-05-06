import 'package:flutter/material.dart';
import 'package:rakshak/models/user.dart';
import 'package:rakshak/models/sending.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'dart:async';
import 'dart:io';

class ReportCrime extends StatefulWidget {
  final User user;
  const ReportCrime({Key key, @required this.user}) : super(key: key);

  @override
  _ReportCrimeState createState() => _ReportCrimeState();
}

class _ReportCrimeState extends State<ReportCrime> {
  String _location;
  String _landmark;
  String _description;
  String _typeOfCrime;
  int _count = 0;
  bool sending = false;
  final databaseReference = Firestore.instance;
  File _image;
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    sending = false;
    _count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return sending
        ? Sending()
        : SafeArea(
            child: Form(
              key: _formkey,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 15,),
                  Center(
                    child: Text(
                      'Report Crime',
                      style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Type of Crime: '),
                        DropdownButton<String>(
                          hint: Text('Select from here'),
                          items: [
                            DropdownMenuItem(
                              value: "theft",
                              child: Text(
                                "Theft",
                              ),
                            ),
                            DropdownMenuItem(
                              value: "robbery",
                              child: Text(
                                "Robbery",
                              ),
                            ),
                            DropdownMenuItem(
                              value: "murder",
                              child: Text(
                                "Murder",
                              ),
                            ),
                            DropdownMenuItem(
                              value: "hit_and_run",
                              child: Text(
                                "Hit and Run",
                              ),
                            ),
                            DropdownMenuItem(
                              value: "stampede",
                              child: Text(
                                "Stampede",
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _typeOfCrime = value;
                            });
                          },
                          value: _typeOfCrime,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 8.0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'please enter location of crime';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Location', border: OutlineInputBorder()),
                      onSaved: (input) => (_location = input),
                      controller: _controller1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 8.0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'please enter landmark (if any)';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Landmark', border: OutlineInputBorder()),
                      onSaved: (input) => (_landmark = input),
                      controller: _controller2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 8.0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'please enter the discription(at least 5 words)';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder()),
                      onSaved: (input) => (_description = input),
                      controller: _controller3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 8.0),
                    child: _image != null
                        ? Image.file(
                            _image,
                            width: 50,
                            height: 50,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text('Capture an image:'),
                              FloatingActionButton(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                ),
                                onPressed: getImage,
                              ),
                            ],
                          ),
                  ),
                  Center(
                    child: RaisedButton(
                      onPressed: () {
                        _count++;
                        setState(() {
                          sending = false;
                        });
                        sendCrimeReport();
                      },
                      child: Text(
                        'Report Crime',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.help),
                        SizedBox(width: 10,),
                        Text(
                            'By clicking the red button,the report will \nbe sent to the nearest police stations'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> sendCrimeReport() async {
    final formstate = _formkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      setState(() {
        sending = true;
      });
    }
    // databaseReference.collection("report").
    await databaseReference
        .collection("report")
        .document("report" + _count.toString() + widget.user.uid)
        .setData({
      'typeOfCrime': _typeOfCrime,
      'location': _location,
      'landmark': _landmark,
      'description': _description,
      'nameOfReporter': widget.user.name,
      'aadhaarNo': widget.user.aadhaar,
      'phoneNo': widget.user.phoneNo,
    });
    if(_image!=null)
      await uploadFile();
    setState(() {
      _controller1.clear();
      _controller2.clear();
      _controller3.clear();
      _image = null;
      sending = false;
    });
    final snackBar = SnackBar(
      content: Text('Report sent to the nearest police station!'),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 640, maxWidth: 480);
    setState(() {
      _image = image;
    });
  }

  Future uploadFile() async {    
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('Images/${Path.basename(_image.path)}}');    
   StorageUploadTask uploadTask = storageReference.putFile(_image);    
   await uploadTask.onComplete;    
   print('File Uploaded');    
 }
}
