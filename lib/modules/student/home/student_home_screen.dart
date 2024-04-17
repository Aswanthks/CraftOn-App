
import 'package:flutter/material.dart';
import 'package:carousel_images/carousel_images.dart';

import '../Students_all_product_list.dart';
import '../product/my_product_screen.dart';
import '../student_all_product.dart';
import '../student_product.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final List<String> listImages = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.red.shade700),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 8.0),
                          child: Column(
                            children: [
                              Text('Welcome Back',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Ubuntu-Bold')),
                              Text('Student',
                                  style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ))
                        ],
                      )
                    ]),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  CarouselImages(
                    scaleFactor: 0.7,
                    listImages: listImages,
                    height: 220.0,
                    borderRadius: 20.0,
                    cachedNetworkImage: true,
                    verticalAlignment: Alignment.bottomCenter,
                    onTap: (index) {
                      print('Tapped on page $index');
                    },
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('My Products',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Ubuntu-Bold')),
                        InkWell(
                          onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => MyProducts(),));
                          },
                          child: Text('See all',
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'Ubuntu-Bold')),
                        )
                      ],
                    ),
                  ),
                  StudentProductWidget(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('All Products',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Ubuntu-Bold')),
                        InkWell(
                          onTap:() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAllProductList(),));
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'Ubuntu-Bold'),
                          ),
                        )
                      ],
                    ),
                  ),
                  StudentAllProduct()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
