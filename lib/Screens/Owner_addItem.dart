import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
class OwnerAddItem extends StatefulWidget {
  @override
  _OwnerAddItemState createState() => _OwnerAddItemState();
}

class _OwnerAddItemState extends State<OwnerAddItem> {
  List<Object> images = List<Object>();
  Future<File> _imageFile;
  PageController _pageController;
  bool changing = true;
  double pageIndex;
  ColorSwatch _tempMainColor;
  List<Color> colors  = [];
  Color _tempShadeColor;
  ColorSwatch _mainColor;
  Color _shadeColor;

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

  void getFileImage(int index) async {
    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
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



  var _categorySelected;
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
                        onPressed: () {},
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
        ),]
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
