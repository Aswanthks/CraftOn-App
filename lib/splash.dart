import 'dart:async';


import 'package:flutter/material.dart';

import 'modules/auth/login_screen.dart';

class Spash_screen extends StatefulWidget {
  const Spash_screen({super.key});

  @override
  State<Spash_screen> createState() => _Spash_screenState();
}

class _Spash_screenState extends State<Spash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () {Navigator.push(context, MaterialPageRoute(builder: (context) => Login_page(),));});
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade700,
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Art &\nCraft',
              
              style: TextStyle( fontFamily: 'ProtestRevolution', fontSize: 105,color: Colors.white),
            ),
            SizedBox(
              height: 120,
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white)
              ),
              child: Text('"Craft something different today"',
                style: TextStyle(color: Colors.grey.shade50,fontFamily: 'SpaceGrotesk',),
              ),
            )
          ],
        ),
      )),
    );
  }
}
