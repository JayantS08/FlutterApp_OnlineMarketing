import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetDrawerList extends StatefulWidget {
  String category;
  GetDrawerList(this.category);

  @override
  _GetDrawerListState createState() => _GetDrawerListState(category);
}

class _GetDrawerListState extends State<GetDrawerList> {
  String search, category;
  List ownerID = [];
  int ownerIndex = 0;
  String uri;
  bool check = false;
  bool isFetched = false;
  List<DocumentSnapshot> ds = [];
  _GetDrawerListState(this.category);

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 32,
          child: RawMaterialButton(
              onPressed: () {},
              child: Image(
                image: AssetImage("images/u.png"),
                fit: BoxFit.cover,
              )),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
//              color: Colors.white,
                width: (MediaQuery.of(context).size.height) - 430,
                child: TextFormField(
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    hintText: 'Search',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Icon(
                        Icons.search,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(
                        20.0, 5.0, 20.0, 5.0),
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
            IconButton(
              color: Colors.green,
              icon: Icon(Icons.refresh),
              onPressed: () {

              },
            )
          ],
        ),
      ),
      body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 250, top: 10),
                      child: Text(
                        category,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 250, top: 2, bottom: 2),
                      child: Divider(
                        indent: 3,
                        endIndent: 8,
                        color: Colors.black,
                        thickness: 3,
                      ),
                    ),
                    SizedBox(height: 10,),
                    _fetchItems(category),
                  ],
                ),
              ),


    );
  }

  _fetchItems (String category) {
    if(isFetched){
      if(ownerIndex < ownerID.length)
        _fetchData(category, ownerID[ownerIndex]);
      return showItems();
    }
    else {
      _fetchOwner(category);
      return Center(child: CircularProgressIndicator());
    }
  }

  _fetchOwner (String category) async{
    var document = await Firestore.instance.collection(category).getDocuments();

//    var details;
    for (int i = 0; i < document.documents.length; i++) {
      ownerID.add(document.documents.elementAt(i).documentID);
      await _fetchData(category, document.documents.elementAt(i).documentID);
    }
  }

  _fetchData(String category,String documentID) async{
    var itemOwner = await Firestore.instance.collection(category)
        .document(documentID).collection(category)
        .where('isAvailable', isEqualTo: true)
        .getDocuments();
    if(itemOwner.documents.length > 0) {
      for (int i = 0; i < itemOwner.documents.length; i++)
        ds.add(itemOwner.documents.elementAt(i));
      setState(() {
        isFetched = true;
        ownerIndex++;
      });
    }
    print(itemOwner.documents.length);
  }

  showItems() {
    return Expanded(
      child: ListView.builder(
          itemCount: ds.length,
          itemBuilder: (BuildContext context, index) {
            List c = ds.elementAt(index).data['colorsAvailable'];
            List d = ds.elementAt(index).data['mediaUrl'];
            if(d.length==0)
              uri ="https://firebasestorage.googleapis.com/v0/b/delilo.appspot.com/o/no_image.jpg?alt=media&token=6d3528a5-96e4-4871-b3e5-a327616a9bcc";
            else
              uri = d[0];
            List <Color> colors = [];
            for(var i = 0; i < c.length; i++)
              colors.add(Color(int.parse(c[i])));
            print('colors = $colors');
              return ClothIcon(
                ontap: (){},
                img: Image.network(uri),
                name: '${ds.elementAt(index)['productName']}',
                price: int.parse('${ds.elementAt(index)['price']}'),
              );
          }
      ),
    );
  }
}

class ClothIcon extends StatelessWidget {
  final Image img;
  final String name;
  final int price;
  final Function ontap;
  ClothIcon({this.name, this.img, this.price,this.ontap});

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
                    image: img.image,
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
                      width: 230,
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
                                style: TextStyle(fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "₹ $price",
                              style: TextStyle(fontSize: 11, color: Colors.white),
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