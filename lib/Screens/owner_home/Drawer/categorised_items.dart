import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../owner_additems.dart';

class CategorisedItems extends StatefulWidget {
  String id, category;
  CategorisedItems(this.category, this.id);

  @override
  _CategorisedItemsState createState() => _CategorisedItemsState(category,id);
}

class _CategorisedItemsState extends State<CategorisedItems> {

  String id, category;
  int _filterValue = 0;
  String uri;
  List <String> filteritem = ['All items', 'Out of stock'];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  _CategorisedItemsState(this.category, this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawerScrimColor: Colors.black,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.greenAccent,
          title: Text(category,style: TextStyle(color: Colors.black),),
      ),
        floatingActionButton: RaisedButton(
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,      body: SafeArea(
        child: ListView(
          controller: ScrollController(),
          shrinkWrap: true,
          children: <Widget>[
            Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: List<Widget>.generate(
                    2,
                        (int filterindex) {
                      return ChoiceChip(
                        padding: EdgeInsets.all(7),
                        labelPadding: EdgeInsets.all(1),
                        pressElevation: 5,
                        shadowColor: Colors.greenAccent,
                        selectedColor: Colors.greenAccent,
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
            _fetchItems(_filterValue),
          ],
        ),
      )
    );
  }

  _fetchItems(int itemType) {
    print(_filterValue);
    var isAvailability = _filterValue == 0 ? true : false;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(category).document(id).collection(category)
          .where('isAvailable', isEqualTo: isAvailability)
          .snapshots(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
        print('build');
        print(snapshot.hasData);
        if (snapshot.hasError) return Text('${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            {
//              print(snapshot.data.documents.elementAt(0).data);
              var documents = snapshot.data.documents;
              print('length =  ${documents.length}');
              if(documents.length == 0){
                return Center(
                  child: Text('No items....'),
                );
              }
              else
              return Container(
                padding: EdgeInsets.fromLTRB(15,0,15,0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, index) {

                    List c = documents.elementAt(index).data['colorsAvailable'];
                    List d = documents.elementAt(index).data['mediaUrl'];
                    if(d.length==0)
                      uri ="https://firebasestorage.googleapis.com/v0/b/delilo.appspot.com/o/no_image.jpg?alt=media&token=6d3528a5-96e4-4871-b3e5-a327616a9bcc";
                    else
                      uri = d[0];
                    List <Color> colors = [];
                    for(var i = 0; i < c.length; i++)
                      colors.add(Color(int.parse(c[i])));
                    print('colors = $colors');
                    print(uri);
                    return Card(
                      elevation: 5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: SwitchListTile(
//                        inactiveThumbImage:
                        activeTrackColor: Colors.green,
                        activeColor: Colors.greenAccent,
                        value: documents.elementAt(index).data['isAvailable']
                            ? true : false,
                        onChanged: (isAvailable) =>
                            _changeAvailability(isAvailable, documents.elementAt(index).data, index),
                        title: Text('${documents.elementAt(index)['productName']}'),
                        subtitle: ListTile(
                            title: Text('Rate'),
                            subtitle: Row(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  width: 50,
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 1,
                                    scrollDirection: Axis.horizontal,
                                    children: List<Widget>.generate(colors.length, (int index){
                                      return CircleAvatar(
                                        radius: 5,
                                        backgroundColor: colors[index],
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Text("out of stock")
                              ],
                            ),
                          leading: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 42,
                              minHeight: 44,
                              maxWidth: 42,
                              maxHeight: 44,
                            ),
                            child: Image.network(uri, fit: BoxFit.cover),
                          ),
                          ),

                      ),
                    );
                  },
                ),
              );
            }
        }
      },
    );
  }

  _changeAvailability(bool isAvailable, Map<String, dynamic> document, int index) async{
//    print(isAvailable);
    var documentId = document['postId'];
    var data = {
      'isAvailable': isAvailable
    };
    await Firestore.instance.collection(category)
        .document(id)
        .collection(category)
        .document(documentId)
        .updateData(data);
    print('item availability changed');

  }


}

