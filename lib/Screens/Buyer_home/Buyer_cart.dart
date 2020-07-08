import 'package:delilo/Screens/Buyer_home/Payment_gateway.dart';
import 'package:delilo/Screens/owner_home/Menu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyerCart extends StatefulWidget {
  @override
  _BuyerCartState createState() => _BuyerCartState();
}

final auth = FirebaseAuth.instance;
int total=0;
List <int> t = [];

class _BuyerCartState extends State<BuyerCart> {

  String uri;
  String uid;
  bool check = false;
  bool check1 = false;
  bool isFetched = false;
  var clr = Firestore.instance;
  List <DocumentSnapshot> cart = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  List ownerId = [];


  fatchCart() {

    return FutureBuilder<QuerySnapshot>(
        future: clr.collection('Cart').document(uid).collection('Items').getDocuments(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snpshot){
          if(snpshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snpshot.hasData){
            cart.clear();
            cart  = snpshot.data.documents;
            return ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(),
              itemCount: snpshot.data.documents.length==0?1:snpshot.data.documents.length,
              itemBuilder: (BuildContext context, int index){
                return showItems(cart);
              },
            );
          }
          return Center(
            child: Text("No Items Available"),
          );
        }
    );

  }

  showItems(List<DocumentSnapshot> data) {

    return ListView.builder(
        shrinkWrap: true,
        controller: ScrollController(),
        itemCount: data.length,
        itemBuilder: (BuildContext context, index) {
          ownerId.add(data.elementAt(index).data['ownerID']);
          uri = data.elementAt(index).data['mediaUrl'];
          if(!check1)
            {
              total+=int.parse('${data.elementAt(index)['price']}');
              check1=true;
            }
          return Ord(
            uid:uid,
            index: index,
            items: cart,
            onPress: (){

            },
            image: Image.network(uri),
            quantity: 1,
            item: '${data.elementAt(index)['productName']}',
            price: int.parse('${data.elementAt(index)['price']}'),
          );
        }
    );
  }


  /*int getTotal(){
    int total;
    for(int i=0;i<orders.length;i++){
      total = total + findqn(orders[i]);
    }
    return total;
  }
  int findqn(Ord or){
    int res;
    String q = or.toString();
    for(int i =0;i<q.length;i++){
      if(q[i]=='q' && q[i+1]=='u' && q[i+2]=='a' && q[i+3]=='n' && q[i+4]=='t' && q[i+5]=='i'){
        res=int.fromEnvironment(q[i+10],defaultValue: 0);
        break;
      }
    }
    return res;
  }*/

  @override
  void initState() {
    _fetchUses();
    // TODO: implement initState
    super.initState();
  }

  _fetchUses() async{
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {},
                    child: Container(
                      height: 60,
                      width: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/o.png"), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Text(
                    "My Cart",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      setState(() {

                      });
                    },
                    child: Icon(Icons.refresh,),
                  )

                ],
              ),
              fatchCart(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                child: Divider(color: Colors.red, thickness: 2),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total order"),
                    Text(
                      total.toString(),
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Payment(ownerId, cart)),
                      );
                    },
                    minWidth: 320.0,
                    height: 42.0,
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
Widget builds({BuildContext context,Function onPress,Image image,int idq,int price,item,quantity,itemsPassed,index}) {
    
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      child: GestureDetector(
        onTap: onPress,
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Container(
                  height: 120,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(10))),
                  child: Image(
                    image: image.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 210,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              item,
                              maxLines: 2,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              "\₹${price * (quantity + idq)}",
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              idq = idq + 1;
                              print(price);
                              total += price;
                              setState(() {

                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text((quantity + idq).toString()),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              
                              
                              (quantity + idq) < 1
                                  ? idq = idq
                                  : idq = idq - 1;
                                if((quantity + idq) >= 1)
                                  total -= price;
                                  if(quantity+idq==0)
                                  {
                                    itemsPassed.removeAt(index);
                                  }
                                setState(() {

                                });
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class Ord extends StatefulWidget {
  String uid;
  final String item;
  final int price;
  final int quantity;
  final Image image;
  final Function onPress;
  int index;
  List<DocumentSnapshot> items;
  Ord({this.item, this.price, this.quantity, this.image, this.onPress,this.index,this.items,this.uid});

  @override
  _OrdState createState() => _OrdState(index,items);
}

class _OrdState extends State<Ord> {
  int idq = 0;
  int index;
  List<DocumentSnapshot> itemsPassed;
  _OrdState(this.index,this.itemsPassed);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      child: GestureDetector(
        onTap: widget.onPress,
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Container(
                  height: 120,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(10))),
                  child: Image(
                    image: widget.image.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 210,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.item,
                              maxLines: 2,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              "\₹${widget.price * (widget.quantity + idq)}",
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              idq = idq + 1;
                              print(widget.price);
                              total += widget.price;
                              setState(() {

                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text((widget.quantity + idq).toString()),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              
                              
                              (widget.quantity + idq) < 1
                                  ? idq = idq
                                  : idq = idq - 1;
                                if((widget.quantity + idq) >= 1)
                                  total -= widget.price;
                                  if(widget.quantity+idq==0)
                                  {
                                    itemsPassed.removeAt(index);
                                    update();
                                  }
                                setState(() {

                                });
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
update(){
  var ref = Firestore.instance;
  itemsPassed.forEach((element) { 
ref.collection('Cart').document(widget.uid).collection('Items').document(element.documentID).delete();
  });
  print('updated');
  
}
}
