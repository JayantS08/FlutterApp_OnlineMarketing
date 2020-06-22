import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:delilo/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:uuid/uuid.dart';
class OwnerAddItem extends StatefulWidget {
/*  final User currentUser;

  OwnerAddItem({this.currentUser});*/
String id;
  OwnerAddItem(this.id);
  @override
  _OwnerAddItemState createState() => _OwnerAddItemState(id);
}

class _OwnerAddItemState extends State<OwnerAddItem> {
  var _categorySelected;

  List<Object> images = List<Object>();
  List<String> imagesURL = List<String>();
  Future<File> _imageFile;
  PageController _pageController;
  bool changing = true;
  double pageIndex;
  ColorSwatch _tempMainColor;
  List<Color> colors  = [];
  Color _tempShadeColor;
  ColorSwatch _mainColor;
  Color _shadeColor;
  final itemRef = Firestore.instance.collection('Mobile');
   //StorageReference storageRef = FirebaseStorage.instance.ref();
  String postId = Uuid().v4();

  String id;
  _OwnerAddItemState(this.id);

  Future<String> uploadImage(imageFile) async {
    FirebaseStorage storage = new FirebaseStorage();
    StorageReference storageRef = storage.ref();
    
    StorageUploadTask uploadTask =
    storageRef.child("${_categorySelected}_$postId.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }

  createAllUrls()async{
    for(int i=0;i<images.length;i++){
      String temp = await uploadImage(images[i]);
      imagesURL.add(temp);
    }
  }

  createPostInFirestore() async{

    List<String> colorvalue = [];
    for (var c=0; c < colors.length; c++){
      Color color = colors[c];
      String colorString = color.toString();
      String colorS = colorString.split('(')[1].split(')')[0];
      colorvalue.add(colorS);
    }

    var d = await Firestore.instance.collection(_categorySelected).document(id).get();
    print(d.exists);
    var data;
    if(!d.exists) {
      data = {
        'itemCount': 1
      };
      await Firestore.instance.collection(_categorySelected).document(id).setData(data);
    }
    else if(d.data['itemCount'] != null){
      data = {
        'itemCount': d.data['itemCount'] + 1
      };
      await Firestore.instance.collection(_categorySelected).document(id).updateData(data);
    }


    await Firestore.instance.collection(_categorySelected)
        .document(id)
        .collection(_categorySelected)
        .document(postId)
        .setData({
      "postId": postId,
      "ownerId": "widget.currentUser.id",
      "shopName": "widget.currentUser.username",
      "productName": productName,
      "mediaUrl": imagesURL,
      "price": price,
      "description": description,
      "colorsAvailable": colorvalue,
      "likes": {},
      "isAvailable": true
    });

    print('uploaded');
  }
  bool isUploading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
//    await createAllUrls();

_image.forEach((element) async{ 
  if(element!=null){
    await uploadImage(element);
  }
});


    try{await createPostInFirestore();}catch(e){}
    setState(() {
      file = null;
      isUploading = false;
      postId = Uuid().v4();
    });

  }

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _mainColor = _tempMainColor;
                });
                setState(() {
                  _shadeColor = _tempShadeColor;
                  colors.add(_shadeColor);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _openFullMaterialColorPicker() async {
    _openDialog(
      "Pick Color",
      MaterialColorPicker(
        onlyShadeSelection: true,
        colors: fullMaterialColors,
        selectedColor: _mainColor,
        onMainColorChange: (color) {
          setState(() {
            _tempMainColor = color;
          });
        },
        onColorChange: (color){
          setState(() {
            _tempShadeColor=color;
          });
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController()..addListener(() {
      setState(() {
        pageIndex=_pageController.page;
      });
    });
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }

  Widget buildGridView() {
    return PageView.builder(
        controller: _pageController,
        itemCount: 4,
        itemBuilder: (context, index) {
          if (images[index] is ImageUploadModel) {
            ImageUploadModel uploadModel = images[index];
            return Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Image.file(
                      uploadModel.imageFile,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: InkWell(
                      child: Icon(
                        Icons.remove_circle,
                        size: 20,
                        color: Colors.red,
                      ),
                      onTap: () {
                        setState(() {
                          images.replaceRange(index, index + 1, ['Add Image']);
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Card(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _onAddImageClick(index);
                },
              ),
            );
          }
        }
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }
List<File> _image =  List(4);
  void getFileImage(int index) async {
    _imageFile.then((file) async {
      setState(() {
        _image[index] = file;
        /*_image.forEach((element) {
          if(element!=null){
            uploadImage(element).then((value){
          print(value);
        });
          }
      
     });*/
        
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
  }
upload(){

}
  getCircles(){
    List<Widget> imageCircles = [];
    for (int i = 0; i < 4; i++) {
      imageCircles.add(
        CircleAvatar(
          radius: 5,
          backgroundColor: pageIndex==i?Colors.white:Colors.green,
        ),
      );
    }
    return imageCircles;
  }

  File file;

  clearImage() {
    setState(() {
      file = null;
    });
  }

  var _categories = [
    "Men's clothing",
    "Women's clothing",
    "Kid's wear",
    "Mobile",
    "Laptop",
    "Electronic",
    "Household",
    "Beauty",
    "Toy",
    "Sports",
    "Dairy",
    "Accessories"
  ];

  String productName;
  String description;
  var price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[300],
      body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 220,
                      child: buildGridView(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              //labelStyle: textStyle,
                              errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 16.0),
                              hintText: 'Category',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                            ),
                            isEmpty: _categorySelected == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _categorySelected,
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text("Category"),
                                ),
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _categorySelected = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _categories.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Text(value),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: TextField(
                        onChanged: (val) {
                          productName = val;
                        },
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Product Name',
                          contentPadding: const EdgeInsets.only(left: 40.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: TextField(
                        onChanged: (val) {
                          price = val;
                        },
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Price',
                          contentPadding: const EdgeInsets.only(left: 40.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: TextField(
                        onChanged: (val) {
                          description = val;
                        },
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Description',
                          contentPadding: const EdgeInsets.only(left: 40.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 40),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                            ),
                            isEmpty: _categorySelected == '',
                            child: RawMaterialButton(
                              onPressed: (){
                                _openFullMaterialColorPicker();
                              },
                              child: Row(
                                children: <Widget>[
                                  Text("Colors Available"),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 7),
                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor: colors.length>0?colors[0]:Colors.transparent,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 7),

                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor: colors.length>1?colors[1]:Colors.transparent,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 7),
                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor: colors.length>2?colors[2]:Colors.transparent,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 7),
                                    child: CircleAvatar(
                                      radius: 7,
                                      backgroundColor: colors.length>3?colors[3]:Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: RawMaterialButton(
                            onPressed: () {
                              print(_categorySelected);
                              print(productName);
                              print(price);
                              print(description);
                              print(colors);
                              handleSubmit();
                              Navigator.pop(context);
                            },
                            fillColor: Colors.green,
                            shape: StadiumBorder(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Save",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 170,
                    ),
                    Container(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: getCircles(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.green,
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 28,
                              ),
                              onPressed: () {
                                _onAddImageClick(pageIndex.floor());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ]
      ),
    );
  }
}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}
