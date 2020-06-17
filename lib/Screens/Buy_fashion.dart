import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Fashion extends StatefulWidget {
  @override
  _FashionState createState() => _FashionState();
}

class _FashionState extends State<Fashion> {
  List items=[ClothIcon(
    ontap: (){},
    image: AssetImage("images/NoPath - Copy (9).png"),
    name: "Women Ethnic Dress",
    shopName: "Shop Name",
    price: 1000,
  ),ClothIcon(
    ontap: (){},
    image: AssetImage("images/NoPath - Copy (9).png"),
    name: "Women Ethnic Dress",
    shopName: "Shop Name",
    price: 1000,
  ),ClothIcon(
    ontap: (){},
    image: AssetImage("images/NoPath - Copy (9).png"),
    name: "Women Ethnic Dress",
    shopName: "Shop Name",
    price: 1000,
  ),ClothIcon(
    ontap: (){},
    image: AssetImage("images/NoPath - Copy (9).png"),
    name: "Women Ethnic Dress",
    shopName: "Shop Name",
    price: 1000,
  ),
    ClothIcon(
    ontap: (){},
    image: AssetImage("images/NoPath - Copy (9).png"),
    name: "Women Ethnic Dress",
    shopName: "Shop Name",
    price: 1000,
  ),ClothIcon(
    ontap: (){},
    image: AssetImage("images/NoPath - Copy (9).png"),
    name: "Women Ethnic Dress",
    shopName: "Shop Name",
    price: 1000,
  ),ClothIcon(
    ontap: (){},
    image: AssetImage("images/NoPath - Copy (9).png"),
    name: "Women Ethnic Dress",
    shopName: "Shop Name",
    price: 1000,
  ),ClothIcon(
    ontap: (){},
    image: AssetImage("images/NoPath - Copy (9).png"),
    name: "Women Ethnic Dress",
    shopName: "Shop Name",
    price: 1000,
  ),ClothIcon(
    ontap: (){},
    image: AssetImage("images/NoPath - Copy (9).png"),
    name: "Women Ethnic Dress",
    shopName: "Shop Name",
    price: 1000,
  ),ClothIcon(
      ontap: (){},
      image: AssetImage("images/NoPath - Copy (9).png"),
      name: "Women Ethnic Dress",
      shopName: "Shop Name",
      price: 1000,
    ),];
  String search;
  makeItems(List items){
    List<Widget> rows = [];
    for(int i=0;i<items.length;i++)
      {
        if(i%2==0){
          Row temp = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              items[i],
              ((items.length-1)==i) ? SizedBox() :items[i+1],
            ],
          );
          rows.add(temp);
        }
      }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey[300],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Center(
                      child: Text(
                        "fashion",
                        style: TextStyle(
                            fontSize: 100,
                            letterSpacing: 5,
                            fontWeight: FontWeight.w500,
                            color: Colors.green[400]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 32,
                      child: RawMaterialButton(
                          onPressed: () {},
                          child: Image(
                            image: AssetImage("images/u.png"),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.height) - 430,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
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
                    ),
                  ],
                ),
                Container(
                  height: (MediaQuery.of(context).size.height)-90,
                  child: ListView(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          "Fashion",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 300, top: 2, bottom: 2),
                        child: Divider(
                          indent: 3,
                          endIndent: 8,
                          color: Colors.black,
                          thickness: 3,
                        ),
                      ),
                      Container(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            FashionItem(
                              ontap:(){},
                              image:
                                  AssetImage("images/NoPath - Copy (10).png"),
                              name: "Women Ethnic Dress",
                              shopName: "Shop Name",
                              price: 1000,
                            ),
                            FashionItem(
                              ontap:(){},
                              image:
                              AssetImage("images/NoPath - Copy (10).png"),
                              name: "Women Ethnic Dress",
                              shopName: "Shop Name",
                              price: 1000,
                            ),
                            FashionItem(
                              ontap:(){},
                              image:
                              AssetImage("images/NoPath - Copy (10).png"),
                              name: "Women Ethnic Dress",
                              shopName: "Shop Name",
                              price: 1000,
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Text(
                          "For",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          RawMaterialButton(
                            onPressed: () {},
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage("images/3.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Women",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage("images/i.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Men",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          RawMaterialButton(
                            onPressed: () {},
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage("images/6.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Kids",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: makeItems(items),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ClothIcon extends StatelessWidget {
  final ImageProvider image;
  final String name;
  final String shopName;
  final int price;
  final Function ontap;
  ClothIcon({this.name, this.image, this.price, this.shopName,this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          width: 140,
          height: 190,
          child: Stack(
            children: <Widget>[
              Container(
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: image,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                name,
                                style: TextStyle(fontSize: 11, color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              shopName,
                              style: TextStyle(fontSize: 11, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "₹ $price",
                              style: TextStyle(fontSize: 8, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FashionItem extends StatelessWidget {
  final ImageProvider image;
  final String name;
  final String shopName;
  final int price;
  final Function ontap;
  FashionItem({this.name, this.image, this.price, this.shopName,this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 230,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(fit: BoxFit.fill, image: image //
                      ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, top: 3),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7, bottom: 4),
                child: Text(
                  shopName,
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7, bottom: 5),
                child: Text(
                  "₹ $price",
                  style: TextStyle(fontSize: 8, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
