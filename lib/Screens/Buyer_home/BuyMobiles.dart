import 'package:flutter/material.dart';

class Mobiles extends StatefulWidget {
  @override
  _MobilesState createState() => _MobilesState();
}

class _MobilesState extends State<Mobiles> {
  String search;

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
                    color: Colors.grey[400],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.white,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Center(
                        child: Text("mobiles",style: TextStyle(fontSize: 100,letterSpacing: 5,fontWeight: FontWeight.w500,color: Colors.green[400]),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 32,
                      child: RawMaterialButton(
                          onPressed: () {

                          },
                          child: Image(
                            image: AssetImage("images/u.png"),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      width: (MediaQuery. of(context). size. height)-430,
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
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.green,
                                  size: 20,
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
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
