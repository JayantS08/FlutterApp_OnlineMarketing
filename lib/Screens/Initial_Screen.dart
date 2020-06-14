import 'package:delilo/Screens/authenticate/owner_form.dart';
import 'package:flutter/material.dart';
import 'package:delilo/Screens/authenticate/Buyer_Login.dart';
import 'package:delilo/Screens/authenticate/Owner_Login.dart';

class initial extends StatefulWidget {
  @override
  _initialState createState() => _initialState();
}

class _initialState extends State<initial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/back.png"),
                  fit: BoxFit.cover,
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 70, left: 70, top: 70),
            child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/logo.png"),
                  )
              ),
            ),
          ),
          Positioned(
            height: 70,
            bottom: 300,
            right: 80,
            child: Container(
              width: 245,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                    color: Colors.white,
                    textColor: Colors.deepPurple,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    },
                    child: Text(
                      "I am a Buyer".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                          color: Colors.black
                      ),
                    ),
                ),
              ),
            ),
          ),
          Positioned(
            height: 70,
            bottom: 220,
            right: 80,
            child: Container(
              width: 245,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                    color: Colors.white,
                    textColor: Colors.deepPurple,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OwnerForm()),
                      );
                    },
                    child: Text(
                      "I am a Shop Owner".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black
                      ),
                    ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
