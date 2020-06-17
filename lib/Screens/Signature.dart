import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:delilo/Screens/Signature_Picker.dart';
import 'package:delilo/Screens/Signature_draw.dart';
import 'package:delilo/Screens/authenticate/Buyer_Login.dart';
import 'package:delilo/utils/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:delilo/services/auth.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  String id;
  MyHomePage({Key key,this.id}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(id);
}

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
final AuthService _auth1 = AuthService();

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _WatermarkPaint && runtimeType == other.runtimeType && price == other.price && watermark == other.watermark;
  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}
enum SingingCharacter { draw, upload }

class _MyHomePageState extends State<MyHomePage> {
  String id;
  _MyHomePageState(this.id);
  ByteData _img = ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;

  SingingCharacter _character = SingingCharacter.upload;
  @override
  Widget build(BuildContext context) {

    void inputData() async {
      final FirebaseUser user = await _auth.currentUser();
      print(user);
      final us = user.uid;
      print(us);
      // here you write the codes to input the data into firestore
    }


    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/back.png"),
              fit: BoxFit.cover,
              //colorFilter: ColorFilter.mode(Color.fromRGBO(192, 234, 218,1).withOpacity(0.6), BlendMode.softLight),
            ),
          ),
        ),
        Form(
          child: SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height),
                  child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            image:DecorationImage(
                                image: AssetImage('images/logo.png')),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "SIGNATURE",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title:Text("I want to upload my Signature"),
                          leading: Radio(
                            value: SingingCharacter.upload,
                            activeColor: Colors.green,
                            groupValue: _character,
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          title:Text("I want to draw my Signature"),
                          leading: Radio(
                            value: SingingCharacter.draw,
                            activeColor: Colors.green,
                            groupValue: _character,
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FlatButton(
                          onPressed: null,
                          child: Text("Skip"),
                        ),
                        Container(
                          width: 180,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          child: RoundButoon(
                            name:"Continue",
                            f: () async{
                              inputData();
                              if(_character == SingingCharacter.draw)
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage1(id:id)),
                                  );
                                }
                              else
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignaturePick(id)),
                                  );
                                }
                            },
                            color: Colors.green,
                          ),
                        ),
                      ]
                  )
              )
          ),
        ),
      ]
      )
    );
  }
}