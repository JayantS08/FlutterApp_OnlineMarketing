import 'package:delilo/Screens/Buyer_home/BuyNearby.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuyerHomePage extends StatefulWidget {
  @override
  _BuyerHomePageState createState() => _BuyerHomePageState();
}

class _BuyerHomePageState extends State<BuyerHomePage> {
  List offers = [Offers(image: AssetImage("images/sale.png"),),
    Offers(image: AssetImage("images/sale.png"),),];



  getOffers(){
    List<Widget> off = [];
    for(int i = 0;i<offers.length;i++){
      off.add(offers[i]);
    }
      return off;
  }

 String search;

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.green,
                    primaryColorDark: Colors.green,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      hintText: 'Search for products, shops',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Icon(
                          Icons.search,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() => search = val);
                    },
                  ),
                ),
              ),
              Container(
                height:  (MediaQuery. of(context). size. height)-200,
                width: double.maxFinite,
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: getOffers(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: RawMaterialButton(
                            shape: StadiumBorder(),
                            fillColor: Colors.green,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Nearby()));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Nearby Shops",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    ShopNear(
                      ontap: (){},
                      shopName: "Shop Name",
                      productSelling: "Mobiles",
                      image: AssetImage("images/Union 1.png"),
                      rating: 4.5,
                      distance: 1.5,
                    ),
                    ShopNear(
                      ontap: (){},
                      shopName: "Shop Name",
                      productSelling: "Mobiles",
                      image: AssetImage("images/Union 1.png"),
                      rating: 4.5,
                      distance: 1.5,
                    ),
                    ShopNear(
                      ontap: (){},
                      shopName: "Shop Name",
                      productSelling: "Mobiles",
                      image: AssetImage("images/Union 1.png"),
                      rating: 4.5,
                      distance: 1.5,
                    ),
                  ],
                ),
              ),

            ],

      ),
    );
  }
}

class ShopNear extends StatelessWidget {
  final Function ontap;
  final ImageProvider image;
  final String shopName;
  final double rating;
  final String productSelling;
  final double distance;
  ShopNear({this.shopName,this.rating,this.image,this.productSelling,this.distance,this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: GestureDetector(
        onTap: ontap,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Row(
            children: <Widget>[
              Container(
                  height: 120,
                  width: 150,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
                  ) ,
                  child: Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: Image(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  )),
              Container(
                height: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            shopName,
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  rating.toString(),
                                  style: TextStyle(color: Colors.green),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.yellow[500],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      productSelling,
                      style: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                    Text(
                      "$distance km away from your location",
                      style:
                      TextStyle(fontSize: 12, color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 10,
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

class Offers extends StatelessWidget {
  final ImageProvider image;
  Offers({this.image});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed:(){},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
