
import 'package:flutter/material.dart';

class SingleProduct extends StatefulWidget {
   SingleProduct({super.key,required this.details});


  Map<String,dynamic> details;

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        // leading: IconButton(onPressed: () => {}, icon: const Icon(Icons.shopping_cart)),
        title: Text('Product Details',
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
      body: Builder(builder: (context) {
        return Container(
          height: double.infinity,
          child: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Hero(
                  tag: 'heroTag',
                  child: Image(
                    image: NetworkImage(widget.details['image'][0]),
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      height: 28,
                      width: 32,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        iconSize: 14,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 4,
                            width: 4,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                          ),
                          Container(
                            height: 28,
                            width: 32,
                            child: IconButton(
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              onPressed: () {},
                              iconSize: 14,
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,

//product detail section

                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 320,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Text('Name',style: TextStyle(color: Colors.black,fontSize: 16),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              widget.details['product_name'],
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                         
                        ],
                      ),

                      SizedBox(height: 10,),

                      Text('Description',style: TextStyle(color: Colors.black,fontSize: 16),),
                     SizedBox(height: 5,),
                     
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.details['description'],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Container(
                      //   alignment: Alignment.topLeft,
                      //   margin: EdgeInsets.only(left: 8),
                      //   child: Text(
                      //     "Size",
                      //     style: TextStyle(
                      //         color: Colors.black.withOpacity(0.8),
                      //         fontSize: 12),
                      //   ),
                      // ),
                      SizedBox(height: 8),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "Price",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            child: Text(
                            widget.details['price'],
                              style: TextStyle(
                                  color: Colors.greenAccent.shade700,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      
                    ],
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
