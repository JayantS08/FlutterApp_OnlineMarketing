import 'package:delilo/Screens/owner_home/owner_items/fashion.dart';
import 'package:delilo/Screens/owner_home/owner_items/kids.dart';
import 'package:delilo/Screens/owner_home/owner_items/men.dart';
import 'package:delilo/Screens/owner_home/owner_items/women.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../services/auth.dart';
import '../owner_additems.dart';
import 'categorised_items.dart';


class OwnerMenu extends StatefulWidget {
  String id;
  OwnerMenu(this.id);
  @override
  _OwnerMenuState createState() => _OwnerMenuState(id);
}

class _OwnerMenuState extends State<OwnerMenu> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isFatched = false;
  String id;

  _OwnerMenuState (this.id);

  List<String> drawerSelection = ['Order', 'Menu', 'Payin', 'Profile'];

//  List <Widget>
  List <String> filteritem = ['All items', 'Out of stock'];
  List <String> categories = [];
  List <int> categoriesCount = [];
  List <int> itemCategory = [122, 65, 100, 213];


  int drawerIndex = 1;

  List <Widget> categoryPage = [
    OwnerFashion(), OwnerMen(), OwnerWomen(), OwnerKids()];

////  final _item = TextEditingController();
////  final _name = TextEditingController();
////
////  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
////  bool _autoValidate = false;
////  String _value;
////  final _firestore = Firestore.instance;
////  final _auth = FirebaseAuth.instance;
////  var newname = '';
////  var newitem = 0;
////  var name = new List(100);
////  var items = new List(100);
////  var date = new List(100);
////  int n = 1;
////  final AuthService _auth1 = AuthService();
////  var otp = new List(6);
////  bool check = false;

  int _filterValue = 1;


  @override
  Widget build (BuildContext context) {    print(_filterValue);

  return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context)),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Name",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  "Gold Member",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Rate Us",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      )),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('Order'),
              trailing: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/Icon ionic-ios-arrow-back.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() => drawerIndex = 0);
              },
            ),
            ListTile(
              title: Text('Menu'),
              trailing: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/Icon ionic-ios-arrow-back.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() => drawerIndex = 1);
              },
            ),
            ListTile(
              title: Text('Payin'),
              trailing: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/Icon ionic-ios-arrow-back.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() => drawerIndex = 2);
              },
            ),
            ListTile(
              title: Text('Profile'),
              trailing: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/Icon ionic-ios-arrow-back.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() => drawerIndex = 3);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('${drawerSelection[drawerIndex]}',
            style: TextStyle(color: Colors.black)),
        elevation: 0,
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: RawMaterialButton(
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
              child: Image(
                image: AssetImage("images/u.png"),
                fit: BoxFit.cover,
              )
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                isFatched = false;
                categories.clear();
              });
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
//            color: Colors.blue,
              child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: List<Widget>.generate(
                      2,
                          (int filterindex) {
                        return ChoiceChip(
                          label: Text(filteritem[filterindex]),
                          selected: _filterValue == filterindex,
                          onSelected: (bool isSelected) {
                            setState(() {
                              _filterValue = isSelected ? filterindex : _filterValue;
                            });
                          },
                        );
                      }
                  ).toList()
              ),
            ),
            _getCategories(),
            Center(
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(45, 15, 45, 15),
                shape: StadiumBorder(),
                color: Colors.greenAccent,
                child: Container(
                  color: Colors.greenAccent,
                  child: Text('Add New'),
                ),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(
                        builder: ((BuildContext context) => OwnerAddItem(id)))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCategories () {
    if (isFatched) {
      print('Fetched Successfully');
      return Container(
        padding: EdgeInsets.all(20),
        height: 500,
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              color: Colors.white,
              child: ListTile(
                title: Text(categories[index]),
                trailing: FlatButton(
                  onPressed: () {

                  },
                  child: Text('Edit'),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Text('${categoriesCount[index]} items'),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
                onTap: () {
                  print(index);
                  Navigator.push(context, MaterialPageRoute(builder: ((BuildContext context) => CategorisedItems(categories[index], id)) ));
                },
              ),
            );
          },
        ),
      );
    }

    print('fetching');

    fetchCategory();
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Future fetchCategory () async {
    categories.clear();
    categoriesCount.clear();
    List _categories = [
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

    var count = 0;

    for (var i = 0; i < _categories.length; i++) {
      QuerySnapshot qs = await Firestore.instance.collection(_categories[i])
          .getDocuments();
      if (qs.documents.length > 0) {
        count = count + 1;
        categories.add(_categories[i]);
        categoriesCount.add(await _getItemsLength(_categories[i]));
      }
    }
    setState(() => isFatched = true );

    print('categoryCount = $count');
    print(categories);
    print(categoriesCount);
  }

  Future <int> _getItemsLength (String collectionPath) async {
    print('getting length');
    QuerySnapshot qs = await Firestore.instance.collection(collectionPath)
        .document(id)
        .collection(collectionPath)
        .getDocuments();
    print("item count = ${qs.documents.length}");

    return qs.documents.length;
  }

//end of class
}




//void _dialog(BuildContext context)
//{
//  showDialog(
//      context: context,
//      barrierDismissible: false,
//      builder: (context) {
//        return AlertDialog(
//          title: Text("Select the category name or create new one."),
//          content: Column(
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
//              TextField(
//                controller: _name,
//              ),
//              SizedBox(height: 10,)
//            ],
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: Text("Confirm"),
//              textColor: Colors.white,
//              color: Colors.green,
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((50))),
//              onPressed: (){
//                name[n+1]=_name.text.trim().toString();
//                items[n+1]=_item.text.trim().toString();
//                n++;
//                Navigator.of(context);
//              },
//            )
//          ],
//        );
//      });
//}