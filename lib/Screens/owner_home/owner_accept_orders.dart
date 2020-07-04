



import 'package:delilo/Screens/owner_home/Menu.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcceptOrders extends StatefulWidget {
  String id;
  AcceptOrders(this.id);
  @override
  _AcceptOrdersState createState() => _AcceptOrdersState(id);
}

class _AcceptOrdersState extends State<AcceptOrders> {
   String ownerID;
   _AcceptOrdersState(this.ownerID);
   Future<QuerySnapshot> packing;
    
     Future<QuerySnapshot> ready;
      Future<QuerySnapshot> picked;
       Future<QuerySnapshot> shipping;
        Future<QuerySnapshot> delivered;
  @override
  initState(){
    print('init');
    var ref = Firestore.instance;
    packing = ref.collection('packing').where('ownerID',isEqualTo: ownerID.toString()).getDocuments();
    ready = ref.collection('ready').where('ownerID',isEqualTo: ownerID.toString()).getDocuments();
    picked = ref.collection('picked').where('ownerID',isEqualTo: ownerID.toString()).getDocuments();
    shipping = ref.collection('shipping').where('ownerID',isEqualTo: ownerID.toString()).getDocuments();
    delivered = ref.collection('delivered').where('ownerID',isEqualTo: ownerID.toString()).getDocuments();

  
  super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      
          child: Scaffold(
        appBar: AppBar(title: Text("Accepting Orders",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        
        bottom: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black,
          isScrollable: true,
          tabs: [
          //Tab(text: 'All',),
          Tab(text: 'Packing',),
          Tab(text: 'Ready',),
          Tab(text: 'Picked',),
          Tab(text: 'Shipping',),
          Tab(text: 'Delivered',),

        ]
        ),
        ),
        
        body: TabBarView(children: [
//_buildbodyAll(packing, 'packing'),
_buildBody(packing, 'packing'),
_buildBody(ready, 'ready'),
_buildBody(picked ,'picked'),
_buildBody(shipping, 'shipping'),
_buildBody(delivered, 'delivered'),

        ])
        ),
    );
  }

  Widget _buildbodyAll(Future<QuerySnapshot>fut,String type){
    return Container(child: Text("all wil be here"));
  }

//Main body ////////

Widget _buildBody(Future<QuerySnapshot>fut,String type){
  return FutureBuilder<QuerySnapshot>(
    future: fut,
    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snpshot){
if(snpshot.connectionState==ConnectionState.waiting){
  
  return Container(
    height: 50,
    child: CircularProgressIndicator(),);
}
 if(snpshot.hasData){
   List<DocumentSnapshot> data  = snpshot.data.documents;
   if(type=='all'){
return Container(child: Text('hello'),);
   }
  return ListView.builder(itemBuilder: (BuildContext context, int index){
    if(snpshot.data.documents.length==0){
DocumentSnapshot snps;
 return Container(child:Center(child: Text('No items'),));
 //packingContainer(snps,'Ready');      
    }
if(type=='packing'){
  
  return packingContainer(data[index],'Ready');
}
if(type=='ready'){
  
  return readyContainer(data[index]);
}
if(type=='picked'){
  return packingContainer(data[index],'Picked');
}
if(type=='shipping'){
  return packingContainer(data[index],'shipping');
}
if(type=='delivered'){
  return packingContainer(data[index],'delivered');
}
DocumentSnapshot snps;
 return packingContainer(snps,'Ready');
  },itemCount: snpshot.data.documents.length==0?1:snpshot.data.documents.length,);

 }
 DocumentSnapshot snps;
 return packingContainer(snps,'Ready');
    }
  );
}

var ref  = Firestore.instance;
//Packing Container
//

  Widget packingContainer(DocumentSnapshot dataDoc,String buttonText) {
    Map data;
    try{ data=dataDoc.data;}catch(e){
      print("$e");
    }
    String id;
    String orderName, clientName, ADDRESS  , clientmobileNumber;
    bool isPaid=false;
    double orderBill;
    try{
      
      id = data==null?'id':data['id'].toString();
      orderName = data['orderName'];
      clientName = data['clientName'];
      
      clientmobileNumber = data['clientmobileNumber'];
      isPaid = data['isPaid'];
      orderBill = data['orderBill'];
      ADDRESS = data['ADDRESS'];
      
      

    }catch(e){
      print('$e');
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 21,
        
            child: Container(
          height: 300,
          
          padding: EdgeInsets.all(20),
          
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(id.toString()),
                ),
                Divider(color: Colors.transparent),
                Row(
                  children: <Widget>[
                    SizedBox(child: Text("PACKING",style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold),)),
                    SizedBox(width: 50),
                    SizedBox(child: Text(clientName.toString()))
                  ],
                ),
                Divider(color: Colors.transparent),
                Container(child: Text(orderName.toString(),style: TextStyle(fontWeight:FontWeight.bold,fontSize: 21),)),
                Divider(color: Colors.transparent),
                Row(
                  children: <Widget>[
                    Container(child: Text('Total Bill: Rs $orderBill       ')),
                    SizedBox(
                      child: Container(
                        height: 25,
                        width: 70,
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                            color: Colors.green
                            ),
                      child: Center(child: Text(isPaid?' Paid':' Not Paid',style: TextStyle(fontWeight:FontWeight.bold),)),
                      
                      ),
                      
                    )
                  ],
                ),
                Divider(color: Colors.transparent),
                Row(
                  children: <Widget>[
                    SizedBox(child: Icon(Icons.location_on),),
                    
                    SizedBox(child: Text("ADDRESS   $ADDRESS  "),)
                  ],
                ),
                Text('Mobile Number: $clientmobileNumber'),
          Divider(color: Colors.transparent),
          Container(
            height:40,
            width: 500,
            
            child:  RaisedButton(
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(21)),
              elevation: 15,
              color: Colors.green,
              child: Text("Order $buttonText"),
              onPressed: (){
                ref.collection(buttonText).document(data==null?'id': data['id']).setData(data);
                upload(buttonText, dataDoc?.documentID??'id');
              }
              ),
          )    ],
            ),
          
        ),
      ),
    );
  }


//Ready Container
//

Widget readyContainer(DocumentSnapshot dataDoc) {
  Map data =dataDoc.data;
    int id;
    String orderName, clientName, ADDRESS  , clientmobileNumber,delieveryBoyName;
    bool isPaid=false;
    double orderBill;
    try{
      id = data['id'];
      orderName = data['orderName'];
      clientName = data['clientName'];
      delieveryBoyName = data['delieveryBoyName'];
      clientmobileNumber = data['clientmobileNumber'];
      isPaid = data['isPaid'];
      orderBill = data['orderBill'];
      ADDRESS = data['ADDRESS'];
      
      

    }catch(e){
      print('$e');
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 21,
            child: Container(
          height: 340,
          
          padding: EdgeInsets.all(20),
          
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(id.toString()),
                ),
                Divider(color: Colors.transparent),
                Row(
                  children: <Widget>[
                    SizedBox(child: Text("PACKING",style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold),)),
                    SizedBox(width: 50),
                    SizedBox(child: Text(clientName.toString()))
                  ],
                ),
                Divider(color: Colors.transparent),
                Container(child: Text(orderName.toString(),style: TextStyle(fontWeight:FontWeight.bold,fontSize: 21),)),
                Divider(color: Colors.transparent),
                Row(
                  children: <Widget>[
                    Container(child: Text('Total Bill: Rs $orderBill       ')),
                    SizedBox(
                      child: Container(
                        height: 25,
                        width: 70,
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                            color: Colors.green
                            ),
                      child: Center(child: Text(isPaid?' Paid':' Not Paid',style: TextStyle(fontWeight:FontWeight.bold),)),
                      
                      ),
                      
                    )
                  ],
                ),
                Divider(color: Colors.transparent),
                Row(
                  children: <Widget>[
                    SizedBox(child: Icon(Icons.location_on),),
                    
                    SizedBox(child: Text("ADDRESS  $ADDRESS  "),)
                  ],
                ),
                Text('Mobile Number: $clientmobileNumber'),
          Divider(color: Colors.transparent),
          Row(children: <Widget>[
            SizedBox(child: Text(delieveryBoyName.toString() ),),
            SizedBox(width: 25,),
            Icon(Icons.phone_in_talk),
            SizedBox(width: 25,),
            Icon(Icons.location_on)

          ],),
          Divider(color: Colors.transparent),
          Container(
            height:40,
            width: 500,
            
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(21)),
              elevation: 15,
              color: Colors.green,
              child: Text("Order delivery"),
              onPressed: getfunction('ready', data)),
          )    ],
            ),
          
        ),
      ),
    );
  }

}


////////////////////
///
///









getfunction(String operation,Map<dynamic,dynamic>data){
 switch(operation.toLowerCase()){
   case 'packing':
   return onPackingTap(data);
   break;
   case 'ready':
   return onreadyTap(data);
   break;
   case 'picked':
   return onPickedTap(data);
   break;
   case 'shipping':
   return onShippingTap(data);
   break;
   case 'delivered':
   return onDeliveredTap();
   break;
   default:
   return (){};
 }
}

onreadyTap(Map<dynamic,dynamic>data){
  upload('picked', 'data');
}

onPickedTap(Map<dynamic,dynamic>data){
  upload('shipping', 'data');
}

onShippingTap(Map<dynamic,dynamic>data){
  upload('delivered', 'data');
}

onDeliveredTap(){
  
}

onPackingTap(Map<dynamic,dynamic>data){
  upload('ready', 'data');
}

upload(String coll, String id)async{
  var ref = Firestore.instance;
 // data??=new Map<String,dynamic>();
  var result =await ref.collection(coll).document(id).delete();
  
}