import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OwnerPayin extends StatefulWidget {
  String id;
  OwnerPayin(this.id);
  @override
  _OwnerPayinState createState() => _OwnerPayinState(id);
}

class _OwnerPayinState extends State<OwnerPayin> {
  static String id;
  _OwnerPayinState(String i){
    id = i;
  }

  var clr = Firestore.instance.collection('packing')
      .where('ownerID' ,isEqualTo: id).getDocuments();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: clr,
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snpshot){
          if(snpshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snpshot.hasData){
            List<DocumentSnapshot> data  = snpshot.data.documents;
            return ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(),
              itemCount: snpshot.data.documents.length==0?1:snpshot.data.documents.length,
              itemBuilder: (BuildContext context, int index){
                return showItems(data);
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
          return Card(
            child: Column(
              children: <Widget>[
                Text(data.elementAt(index).data['productName']),
                Text(data.elementAt(index).data['price'])
              ],
            ),
          );
        }
    );
  }

}
