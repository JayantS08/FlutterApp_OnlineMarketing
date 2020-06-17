import 'package:delilo/Screens/authenticate/Business_Details.dart';
import 'package:delilo/Screens/authenticate/Buyer_Login.dart';
import 'package:flutter/material.dart';
import 'package:delilo/Screens/authenticate/owner_form.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:delilo/services/auth.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DocumentPick extends StatelessWidget {
  String name;
  String phono;
  String mail;
  String add;
  String id;
  String idproof='';
  String accname='';
  String ifsc='';
  String driving ='';
  String pan='';
  String photo = '';
  String cheque = '';
  String title ='';
  DocumentPick(this.name,this.mail,this.phono,this.add,this.id,this.idproof,this.accname,this.pan,this.ifsc,this.driving,this.cheque,this.photo,this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.green,
          elevation: 0.0,
        ),
        body: DocumentInput(name,mail,phono,add,id,idproof,accname,pan,ifsc,driving,cheque,photo,title),
      ),
    );
  }
}

class DocumentInput extends StatefulWidget {
  String name;
  String phono;
  String mail;
  String add;
  String id;
  String idproof='';
  String accname='';
  String ifsc='';
  String driving ='';
  String pan='';
  String photo = '';
  String cheque = '';
  String title ='';
  DocumentInput(this.name,this.mail,this.phono,this.add,this.id,this.idproof,this.accname,this.pan,this.ifsc,this.driving,this.cheque,this.photo,this.title);
  @override
  State<StatefulWidget> createState() {
    return _DocumentInput(name,mail,phono,add,id,idproof,accname,pan,ifsc,driving,cheque,photo,title);
  }
}

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
final AuthService _auth1 = AuthService();

class _DocumentInput extends State<DocumentInput> {
  String name;
  String phono;
  String mail;
  String id;
  String add;
  String idproof='';
  String accname='';
  String ifsc='';
  String driving ='';
  String pan='';
  String photo = '';
  String cheque = '';
  String title ='';
  _DocumentInput(this.name,this.mail,this.phono,this.add,this.id,this.idproof,this.accname,this.pan,this.ifsc,this.driving,this.cheque,this.photo,this.title);
  // To store the file provided by the image_picker
  File _imageFile;
  bool _isUploading = false;
  String _uploadedFileURL;
  // To track the file uploading state
  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = image;
    });
    // Closes the bottom sheet

    Navigator.pop(context);
  }
  Future _uploadImage(File image) async {
    setState(() {
      _isUploading = true;
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Delivery_Boy_Docs/${Path.basename(_imageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_imageFile);
    await uploadTask.onComplete;
    success(context);
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });

  }

  void success (BuildContext context)
  {
    var alert = AlertDialog(
      title: Text("Success",textAlign: TextAlign.center,),
      content: Text("Your image is under process !!",textAlign: TextAlign.center,),
      actions: <Widget>[
        Container(child: RaisedButton(child: Text('Ok',style: TextStyle(fontSize: 15.0),),elevation: 5,
          splashColor: Colors.pinkAccent,
          color: Colors.black,
          onPressed:  () async{
          if(title=='ID proof')
            {
              if(_uploadedFileURL==null)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DocumentPick(name,mail,phono,add,id,idproof,accname,pan,ifsc,driving,cheque,photo,title)),
                  );
                }
              else
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DocumentPick(name,mail,phono,add,id,_uploadedFileURL,accname,pan,ifsc,driving,cheque,photo,'Driving License')),
                  );
                }
            }
          else if(title=='Driving License')
            {
              if(_uploadedFileURL==null)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DocumentPick(name,mail,phono,add,id,idproof,accname,pan,ifsc,driving,cheque,photo,title)),
                );
              }
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      DocumentPick(
                          name,
                          mail,
                          phono,
                          add,
                          id,
                          idproof,
                          accname,
                          pan,
                          ifsc,
                          _uploadedFileURL,
                          cheque,
                          photo,
                          'Pan Card')),
                );
              }
            }
          else if(title=='Pan Card')
            {
              if(_uploadedFileURL==null)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DocumentPick(name,mail,phono,add,id,idproof,accname,pan,ifsc,driving,cheque,photo,title)),
                );
              }
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      DocumentPick(
                          name,
                          mail,
                          phono,
                          add,
                          id,
                          idproof,
                          accname,
                          _uploadedFileURL,
                          ifsc,
                          driving,
                          cheque,
                          photo,
                          'Passport size Photo')),
                );
              }
            }
          else if(title=='Passport size Photo')
            {
              if(_uploadedFileURL==null)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DocumentPick(name,mail,phono,add,id,idproof,accname,pan,ifsc,driving,cheque,photo,title)),
                );
              }
              else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      DocumentPick(
                          name,
                          mail,
                          phono,
                          add,
                          id,
                          idproof,
                          accname,
                          pan,
                          ifsc,
                          driving,
                          cheque,
                          _uploadedFileURL,
                          'Cancelled Cheque')),
                );
              }
            }
          else if(title=='Cancelled Cheque')
            {
              if(_uploadedFileURL==null)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DocumentPick(name,mail,phono,add,id,idproof,accname,pan,ifsc,driving,cheque,photo,title)),
                );
              }
              else {
                try {
                  print('registered');
                  DocumentReference res = await _firestore.collection(
                      'Delivery Boy Details').add({
                    'Name': name,
                    'Mobile': phono,
                    'Email': mail,
                    'Address': add,
                    'ID proof': idproof,
                    'UID': id,
                    'Passport Size Photo': photo,
                    'Account name': accname,
                    'IFSC number': ifsc,
                    'Pan Card': pan,
                    'Driving License': driving,
                    'Cancelled Cheque': _uploadedFileURL,
                  });
                  print(res.documentID);
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
            }
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
  void failed (BuildContext context)
  {
    var alert = AlertDialog(
      title: Text("Failed",textAlign: TextAlign.center,),
      content: Text("We could not process your request. Please try again !",textAlign: TextAlign.center,),
      actions: <Widget>[
        Container(child: RaisedButton(child: Text('Ok',style: TextStyle(fontSize: 15.0),),elevation: 5,
          splashColor: Colors.pinkAccent,
          color: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DocumentPick(name,mail,phono,add,id,idproof,accname,pan,ifsc,driving,cheque,photo,title)),
            );
          },
        ),alignment: Alignment.center,
        )

      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }


  void _openImagePickerModal(BuildContext context) {
    final flatButtonColor = Theme.of(context).primaryColor;
    print('Image Picker Modal Called');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: flatButtonColor,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }
  Widget _buildUploadBtn() {
    Widget btnWidget = Container();
    if (_isUploading) {
      // File is being uploaded then show a progress indicator
      btnWidget = Container(
          margin: EdgeInsets.only(top: 10.0),
          child: CircularProgressIndicator());
    } else if (!_isUploading && _imageFile != null) {
      // If image is picked by the user then show a upload btn
      btnWidget = Container(
        margin: EdgeInsets.only(top: 10.0),
        child: RaisedButton(
          child: Text('Upload Document'),
          onPressed: () {
            _uploadImage(_imageFile);
          },
          color: Colors.pinkAccent,
          textColor: Colors.white,
        ),
      );
    }
    return btnWidget;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
            child: OutlineButton(
              onPressed: () => _openImagePickerModal(context),
              borderSide:
              BorderSide(color: Theme
                  .of(context)
                  .accentColor, width: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.camera_alt),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('Add Image'),
                ],
              ),
            ),
          ),
          _imageFile == null
              ? Text('Please pick an image')
              : Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 300.0,
            alignment: Alignment.topCenter,
            width: MediaQuery
                .of(context)
                .size
                .width,
          ),
          _buildUploadBtn(),
        ],
      ),
    );
  }}