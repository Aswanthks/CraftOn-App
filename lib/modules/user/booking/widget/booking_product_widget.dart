import 'package:flutter/material.dart';

class BookingProductWidget extends StatefulWidget {
  const BookingProductWidget({super.key, required bookingDetails});

  @override
  State<BookingProductWidget> createState() => _BookingProductWidgetState();
}

class _BookingProductWidgetState extends State<BookingProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
          height: 150,
          padding: EdgeInsets.all(5.0),
          color: Colors.grey.shade100,
          margin: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtsemQNhRIYpZhC1zyy16TaX5c2h71tLSHi22QhbaTDtpAt-D9bIba1WmYXQJY80TNhZw&usqp=CAU',
                  width: 130,
                  height: 130),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product Name',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Ubuntu-Bold',
                            fontSize: 18)),
                    SizedBox(
                      width: 220,
                      child: Text('Lorem Ipsum is simplyLorem Ipsum is simplyLorem Ipsum is simplyLorem Ipsum is simplyLorem Ipsum is simply',
                         
                         overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 15)),
                    ),
                    Text('150',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Ubuntu-Regular',
                            fontSize: 15)),
                    Text('1 product',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Ubuntu-Regular',
                            fontSize: 15)),
                    Text('03/02/2024',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Ubuntu-Regular',
                            fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}