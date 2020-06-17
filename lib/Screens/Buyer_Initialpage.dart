import 'package:delilo/Screens/BuyBeauty&Health.dart';
import 'package:delilo/Screens/BuyDairy.dart';
import 'package:delilo/Screens/BuyHousehold.dart';
import 'package:delilo/Screens/BuyMobiles.dart';
import 'package:delilo/Screens/BuyNearby.dart';
import 'package:delilo/Screens/BuyParty.dart';
import 'package:delilo/Screens/BuySports.dart';
import 'package:delilo/Screens/BuyToys&Baby.dart';
import 'package:delilo/Screens/BuyTravel.dart';
import 'package:delilo/Screens/Buy_fashion.dart';
import 'package:delilo/Screens/Buyer_cart.dart';
import 'package:delilo/Screens/Buyer_homepage.dart';
import 'package:delilo/Screens/Buyer_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuyerInitPage extends StatefulWidget {
  @override
  _BuyerInitPageState createState() => _BuyerInitPageState();
}

class _BuyerInitPageState extends State<BuyerInitPage> {
  PageController pageController;
  int pageIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            DrawerTiles(
              image: AssetImage("images/Icon awesome-mobile-alt.png"),
              name: "Mobiles",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Mobiles())),
            ),
            DrawerTiles(
              image: AssetImage("images/Group 418.png"),
              name: "Fashion",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Fashion())),
            ),
            DrawerTiles(
              image: AssetImage("images/lamp.png"),
              name: "Household",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Household())),
            ),
            DrawerTiles(
              image: AssetImage("images/Group 419.png"),
              name: "Beauty & Health",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BeautyHealth())),
            ),
            DrawerTiles(
              image: AssetImage("images/Group 424.png"),
              name: "Toys & Baby products",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ToyBaby())),
            ),
            DrawerTiles(
              image: AssetImage("images/Group 420.png"),
              name: "Nearby Market",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Nearby())),
            ),
            DrawerTiles(
              image: AssetImage("images/Group 421.png"),
              name: "Dairy Products",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Dairy())),
            ),
            DrawerTiles(
              image: AssetImage("images/Group 422.png"),
              name: "Sports & more",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Sports())),
            ),
            DrawerTiles(
              image: AssetImage("images/Group 423.png"),
              name: "Party & gatherings",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Party())),
            ),
            DrawerTiles(
              image: AssetImage("images/Icon material-card-travel.png"),
              name: "Travel & Explore",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Travel())),
            ),
            DrawerTiles(
              image: AssetImage("images/Group 408.png"),
              name: "Orders",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Fashion())),
            ),
            DrawerTiles(
              image: AssetImage("images/Icon material-history.png"),
              name: "History",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Fashion())),
            ),
            DrawerTiles(
              image: AssetImage("images/%.png"),
              name: "Coupons",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Fashion())),
            ),
            DrawerTiles(
              image: AssetImage("images/Icon ionic-ios-person-add.png"),
              name: "Be a seller",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Fashion())),
            ),
            DrawerTiles(
              image: AssetImage("images/Shape.png"),
              name: "Customer Support",
              ontap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Fashion())),
            ),
          ],
        ),
      ),
      body: PageView(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Center(
                child: Image(
                  height: 60,
                  width: 200,
                  image: AssetImage("images/logo.png"),
                ),
              ),
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
                    )),
              ),
              actions: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: RawMaterialButton(
                      splashColor: Colors.transparent,
                      onPressed: () {},
                      child: Image(
                        image: AssetImage("images/2.png"),
                        fit: BoxFit.fill,
                      )),
                )
              ],
            ),
            body: BuyerHomePage(),
          ),
          BuyerCart(),
          BuyerProfile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          backgroundColor: Colors.green,
          activeColor: Colors.white,
          inactiveColor: Colors.lightGreen[400],
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart)),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
            ),
          ]),

      // return RaisedButton(
      //   child: Text('Logout'),
      //   onPressed: logout,
      // );
    );
  }
}

class DrawerTiles extends StatelessWidget {
  final ImageProvider image;
  final String name;
  final Function ontap;

  DrawerTiles({this.image, this.name, this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      title: Text(name),
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
        ontap();
      },
    );
  }
}
