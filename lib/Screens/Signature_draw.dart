import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:delilo/Screens/authenticate/Buyer_Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:image_picker/image_picker.dart';
import 'package:delilo/services/auth.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyHomePage1 extends StatefulWidget {
  String id;
  MyHomePage1({Key key,this.id}) : super(key: key);

  @override
  _MyHomePage1State createState() => _MyHomePage1State(id);
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

class _MyHomePage1State extends State<MyHomePage1> {
  String id;
  _MyHomePage1State(this.id);
  ByteData _img = ByteData(0);
  var color = Colors.red;
  var strokeWidth = 5.0;
  bool _isUploading = false;
  String _uploadedFileURL;
  final _sign = GlobalKey<SignatureState>();

  Future _uploadImage(final encod) async {
    setState(() {
      _isUploading = true;
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Signature/${Path.basename(encod.path)}}');
    StorageUploadTask uploadTask = storageReference.putData(encod);
    await uploadTask.onComplete;
    success(context,encod);
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  void success (BuildContext context,final encoded)
  {
    var alert = AlertDialog(
      title: Text("Success",textAlign: TextAlign.center,),
      content: Text("Your image is under process !!",textAlign: TextAlign.center,),
      actions: <Widget>[
        Container(child: RaisedButton(child: Text('Ok',style: TextStyle(fontSize: 15.0),),elevation: 5,
          splashColor: Colors.pinkAccent,
          color: Colors.black,
          onPressed:  () async{
            if(_uploadedFileURL!=null)
            {
              try {
                print('registered');
                DocumentReference res = await _firestore.collection('Signature Details').add({
                  'UID': "anonymous",
                  'Signature URL': encoded,
                });
                print(res.documentID);
                _auth.signOut();
                Fluttertoast.showToast(
                    msg: "Registration Successful",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
//                                      backgroundColor: Colors.whi,
//                                      textColor: Colors.white,
                    fontSize: 10.0);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              } catch (e) {
                print(e);
              }
            }
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn(),
                ));
          },
        ),alignment: Alignment.center,
        )

      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Signature(
                  color: color,
                  key: _sign,
                  onSign: () {
                    final sign = _sign.currentState;
                    debugPrint('${sign.points.length} points in the signature');
                  },
                  backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                  strokeWidth: strokeWidth,
                ),
              ),
              color: Colors.black12,
            ),
          ),
          _img.buffer.lengthInBytes == 0 ? Container() : LimitedBox(maxHeight: 200.0, child: Image.memory(_img.buffer.asUint8List())),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: Colors.green,
                      onPressed: () async {
                        final sign = _sign.currentState;
                        //retrieve image data, do whatever you want with it (send to server, save locally...)
                        final image = await sign.getData();
                        var data = await image.toByteData(format: ui.ImageByteFormat.png);
                        sign.clear();
                        final encoded = base64.encode(data.buffer.asUint8List());
                        setState(() {
                          _img = data;
                        });
                        try {
                          print('registered');
                          DocumentReference res = await _firestore.collection('Signature Details').add({
                            'UID': id,
                            'Encoded Signature': encoded,
                          });
                          print(res.documentID);
                          _auth.signOut();
                          Fluttertoast.showToast(
                              msg: "Registration Successful",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1,
//                                      backgroundColor: Colors.whi,
//                                      textColor: Colors.white,
                              fontSize: 10.0);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        } catch (e) {
                          print(e);
                        }
                        debugPrint("onPressed " + encoded);
                      },
                      child: Text("Save")),
                  MaterialButton(
                      color: Colors.grey,
                      onPressed: () {
                        final sign = _sign.currentState;
                        sign.clear();
                        setState(() {
                          _img = ByteData(0);
                        });
                        debugPrint("cleared");
                      },
                      child: Text("Clear")),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}