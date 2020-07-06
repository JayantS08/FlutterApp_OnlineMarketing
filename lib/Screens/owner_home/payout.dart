import 'package:flutter/material.dart';
class Payout extends StatefulWidget {
  @override
  _PayoutState createState() => _PayoutState();
}

class _PayoutState extends State<Payout> {
  List<String>notification = new List.filled(4, 'You recived Rs 4000 for order #',growable: true);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("PayOut",style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: _buildBody(),
    );
  }
Widget _buildBody(){
return Padding(
  
  padding: const EdgeInsets.fromLTRB(20,100,20,0),
  child:   Container(
    
    child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
      
        children: <Widget>[
      
Container(
      
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            
            color: Colors.purple,
            borderRadius: BorderRadius.circular(50)
          ),
          child: Center(child: Text('IMAGE')),
        ),
      ),
),

Divider(height: 25,),
              Container(
                
                child: Text("History",style: TextStyle(
                  fontSize: 21,
                  color: Colors.green,
                  fontWeight: FontWeight.bold
                ),),
              ),
      
              Container(
                height: 346,
                child: Center(
      
                  child: ListView.separated(itemBuilder: (BuildContext context,int index){
      
          
      notification[index] = 'You recived ${(index+1)*233} on order #${(index+1)*23}';
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(title: Text(notification[index].toString(),style: TextStyle(

                fontSize: 20
              ),),
              
              ),
            );
      
          
      
          }, separatorBuilder: (BuildContext context,int index)=> Divider(color: Colors.black,), itemCount: notification.length),
      
                ),
              ),
      
        ],
      
      ),
    ),
  ),
);
}

}