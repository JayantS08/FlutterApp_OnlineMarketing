import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailedItem extends StatefulWidget {
  var itemInfo;
  DetailedItem(this.itemInfo);

  @override
  _DetailedItemState createState() => _DetailedItemState();
}
final auth = FirebaseAuth.instance;
class _DetailedItemState extends State<DetailedItem> {
  PageController _pageController;
  double pageIndex;
  bool check1=false;
  String postId = Uuid().v4();
  String colorvalue;

  @override
  void initState() {
    print(widget.itemInfo['mediaUrl'].length);

    super.initState();
    _pageController = PageController()..addListener(() {
      setState(() {
        pageIndex=_pageController.page;
      });
    });
  }

  createPostInFirestore() async{

    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    int imageCount;
    List urls = [];
    if(widget.itemInfo['mediaUrl'].length > 0) {
      imageCount = widget.itemInfo['mediaUrl'].length;
      urls = widget.itemInfo['mediaUrl'];
    }
    else {
      var uri ="https://firebasestorage.googleapis.com/v0/b/delilo.appspot.com/o/no_image.jpg?alt=media&token=6d3528a5-96e4-4871-b3e5-a327616a9bcc";
      urls.add(uri);
    }
    String uri = urls[0].toString();
    await Firestore.instance.collection("Cart")
        .document(uid)
        .collection("Items")
        .document(postId)
        .setData({
      "postId": postId,
      "ownerId": "widget.currentUser.id",
      "shopName": "widget.currentUser.username",
      "productName": '${widget.itemInfo['productName']}',
      "price": '${widget.itemInfo['price']}',
      "mediaUrl": uri,
      "description": '${widget.itemInfo['description']}',
      "colorsAvailable": colorvalue,
      "likes": {},
      "isAvailable": true
    });
    check1 = true;
    Navigator.pop(context);
    print('uploaded');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title:  Text('${widget.itemInfo['productName']}'),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(30,10,0,10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              shape: StadiumBorder(),
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.fromLTRB(18, 13, 18, 13),
                child: Text('Add to cart',
                  style: TextStyle(color: Colors.green,fontSize: 20)),
              ),
              onPressed: () async{
                try{await createPostInFirestore();}catch(e){}
              },
            ),
            RaisedButton(
              shape: StadiumBorder(),
              color: Colors.green,
              child: Container(
                padding: EdgeInsets.fromLTRB(18, 13, 18, 13),
                child: Text('Buy Now',
                  style: TextStyle(color: Colors.white,fontSize: 20)),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/back.png"),
            fit: BoxFit.cover,
            //colorFilter: ColorFilter.mode(Color.fromRGBO(192, 234, 218,1).withOpacity(0.6), BlendMode.softLight),
          ),
        ),
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: PageView(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
          },
          children: <Widget>[
            Buildpage()
          ],
        ),
      ),
    );

  }

  Buildpage() {

    return SafeArea(
      child:ListView(
        children: <Widget>[
          Container(
            height: 220,
            child: buildGridView(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text('${widget.itemInfo['productName']}',
              style: TextStyle(color: Colors.green, fontSize: 30),),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Text("₹ ${widget.itemInfo['price']}",
                  style: TextStyle(fontSize: 20)
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text("Rating : 4.5") /// rating need to be calculated
              ],
            ),
          ),
          _availableColor(),
          Container(
            padding: EdgeInsets.only(left: 10,top: 15),
            child: Text('Description :',
              style: TextStyle(color: Colors.green,fontSize: 22)),
          ),
          Container(
            padding: EdgeInsets.only(left: 10,top: 4),
            child: Text('${widget.itemInfo['description']}',
              style: TextStyle(fontSize: 17)),
          ),
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Text('Reviews',
              style: TextStyle(fontSize: 20, color: Colors.green)),
          ),
          Container(
            padding: EdgeInsets.only(left: 10,top: 4),
            child: Text('No reviews yet !!',
                style: TextStyle(fontSize: 17)),
          ),
        ],
      ),
    );
  }

  Widget buildGridView() {
    var imageCount = 1;
    List urls = [];
    if(widget.itemInfo['mediaUrl'].length > 0) {
      imageCount = widget.itemInfo['mediaUrl'].length;
      urls = widget.itemInfo['mediaUrl'];
    }
    else {
      var uri ="https://firebasestorage.googleapis.com/v0/b/delilo.appspot.com/o/no_image.jpg?alt=media&token=6d3528a5-96e4-4871-b3e5-a327616a9bcc";
      urls.add(uri);
    }

    return PageView.builder(
        controller: _pageController,
        itemCount: imageCount,
        itemBuilder: (context, index) {
          return Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: <Widget>[
                  Image.network(urls[index]),
                ],
              ),
            );
        }
    );
  }

  _availableColor() {
    List c = widget.itemInfo['colorsAvailable'];
    List <Color> colors = [];
    for(var i = 0; i < c.length; i++)
      colors.add(Color(int.parse(c[i])));

    return Container(
      height: 70,
      child: GridView.count(
        crossAxisCount: 1,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: List<Widget>.generate(colors.length, (int index){
          return InkWell(
            child: Card(
              elevation: 1,
              color: colors[index],
            ),
            onTap: (){
              setState(() {
                Color color = colors[index];
                String colorString = color.toString();
                String colorS = colorString.split('(')[1].split(')')[0];
                colorvalue = colorS;
                Fluttertoast.showToast(
                    msg: "Color Selected !",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
//                                      backgroundColor: Colors.whi,
//                                      textColor: Colors.white,
                    fontSize: 10.0);
              });
            },
          );
        }).toList(),
      ),
    );
  }


}
