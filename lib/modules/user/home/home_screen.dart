
import 'package:crafton_final/modules/user/home/widgets/all_product_widget.dart';
import 'package:crafton_final/modules/user/home/widgets/work_highlight_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_images/carousel_images.dart';

import '../products/all_products_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                              Text('User',
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
                        Text('Work Highlights',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Ubuntu-Bold')),
                        InkWell(
                          onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => AllProducts(),));
                          },
                          child: Text('See all',
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'Ubuntu-Bold')),
                        )
                      ],
                    ),
                  ),
                  HighLightWidget(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Products',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Ubuntu-Bold')),
                        InkWell(
                          onTap:() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AllProducts(),));
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
                  AllProductWidget()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
