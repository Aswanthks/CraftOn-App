
import 'package:flutter/material.dart';

import '../home/user_root_screen.dart';

class OrderPlaced extends StatefulWidget {
  const OrderPlaced({super.key});

  @override
  State<OrderPlaced> createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade700,
          automaticallyImplyLeading: false,
          // leading: IconButton(onPressed: () => {}, icon: const Icon(Icons.shopping_cart)),
          title: Text('Order Placed',
              style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu-Bold')),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ))
          ],
        ),
       
        body: Container(
          height: 400,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200, width: 2),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16))),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image(
                      image: AssetImage("assets/images/ic_thank_you.png"),
                      width: 300,
                    ),
                  ),
                ),
                flex: 5,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: <Widget>[
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text:
                                  "\n\nThank you for your purchase. We values each and every customer. We strive to provide good art and craft works. If you have any questions or feedback, please don’t hesitate to reach out.",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade800),
                            )
                          ])),
                      SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder:(context) => UserRootScreen(), ), (route) => false);
                        },
                       
                        child: Padding(
                          padding: const EdgeInsets.only(left: 48, right: 48),
                          child: Text(
                            "Home",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                flex: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
