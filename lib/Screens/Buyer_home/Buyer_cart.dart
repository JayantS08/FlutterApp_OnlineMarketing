import 'package:delilo/Screens/Buyer_home/Payment_gateway.dart';
import 'package:flutter/material.dart';

class BuyerCart extends StatefulWidget {
  @override
  _BuyerCartState createState() => _BuyerCartState();
}

class _BuyerCartState extends State<BuyerCart> {
  List<Widget> orders = [
    Ord(
      image: AssetImage("images/3.png"),
      price: 700,
      shop: "Shop Name",
      quantity: 2,
      item: "One piece dress for women office suit",
      onPress: (){},
    ),
    Ord(
      image: AssetImage("images/3.png"),
      price: 700,
      shop: "Shop Name",
      quantity: 2,
      item: "One piece dress for women office suit",
      onPress: (){},
    ),
    Ord(
      image: AssetImage("images/3.png"),
      price: 700,
      shop: "Shop Name",
      quantity: 2,
      item: "One piece dress for women office suit",
      onPress: (){},
    ),
    Ord(
      image: AssetImage("images/3.png"),
      price: 700,
      shop: "Shop Name",
      quantity: 2,
      item: "One piece dress for women office suit",
      onPress: (){},
    ),
  ];
  int total;
  int getTotal(){
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              ],
            ),
            Container(
              width: double.maxFinite,
              height: (MediaQuery. of(context). size. height)-270,
              child: ListView(
                children: orders,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
              child: Divider(color: Colors.red, thickness: 2),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Your Order"),
                  Text(
                    "Rs 1344",
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
                      MaterialPageRoute(builder: (context) => Payment()),
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
    );
  }
}

class Ord extends StatefulWidget {
  final String item;
  final int price;
  final String shop;
  final int quantity;
  final ImageProvider image;
  final Function onPress;
  Ord({this.item,this.price,this.shop,this.quantity,this.image,this.onPress});
  @override
  _OrdState createState() => _OrdState();
}

class _OrdState extends State<Ord> {
  int idq = 0;

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
                    image: widget.image,
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
                              "\$${widget.price * (widget.quantity+idq)}",
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      widget.shop,
                      style: TextStyle(fontSize: 15),
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
                              idq = idq+ 1;
                              setState(() {});
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text((widget.quantity+idq).toString()),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              (widget.quantity+idq)<1 ? idq=idq: idq=  idq - 1;
                              setState(() {});
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

/*class Order extends StatelessWidget {
  final String item;
  int price;
  final String shop;
  int quantity;
  final ImageProvider image;
  final Function onPress;
  Order({this.item,this.price,this.shop,this.quantity,this.image,this.onPress});

  @override
  Widget build(BuildContext context) {
    return
  }
}*/
