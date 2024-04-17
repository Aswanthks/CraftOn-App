import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../servieces/api_service.dart';
import '../../../servieces/db_services.dart';
import '../../../utils/custom_text_style.dart';
import '../../../widgets/custom_utils.dart';
import '../checkout/checkout_screen.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<dynamic> fetchCartData(String loginId) async {
    final response = await http
        .get(Uri.parse('${ApiService.baseUrl}/api/user/view-cart/$loginId'));

    print(response.body);

    if (response.statusCode == 200) {

      var data = jsonDecode(response.body);

      totalAmount = data['totalAmount'];
      return data;
    } else {
      throw Exception('Failed to load cart data');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  getTotal() async{

    await fetchCartData(DbService.getLoginId()!);
    setState(() {
      
    });
  }



  int totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        // leading: IconButton(onPressed: () => {}, icon: const Icon(Icons.shopping_cart)),
        title: Text('Cart',
            style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu-Bold')),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                isDark ? Icons.notifications : Icons.notifications,
                color: Colors.white,
              ))
        ],
      ),
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "SHOPPING CART",
                  style: CustomTextStyle.textFormFieldBold
                      .copyWith(fontSize: 16, color: Colors.black),
                ),
                margin: EdgeInsets.only(left: 12, top: 12),
              ),
              FutureBuilder(
                future: fetchCartData(DbService.getLoginId()!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('No Data'));
                  } else {
                    var cartItems = snapshot.data['data'] ?? [];

                    totalAmount = snapshot.data['totalAmount']; 
                    
                  
                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 8, left: 8, top: 8, bottom: 8),
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14)),
                                        color: Colors.red.shade700,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                cartItems[index]['image'][0]))),
                                  ),
                                  Expanded(
                                    flex: 100,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: 8, top: 4),
                                            child: Text(
                                              cartItems[index]['product_name'],
                                              maxLines: 2,
                                              softWrap: true,
                                              style: CustomTextStyle
                                                  .textFormFieldSemiBold
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ),
                                          Utils.getSizedBox(height: 6),
                                          
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "\$${cartItems[index]['total']}",
                                                  style: CustomTextStyle
                                                      .textFormFieldBlack
                                                      .copyWith(
                                                          color: Colors.green),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      GestureDetector(
                                                        onTap: () async{

                                                          await ApiService().updateCartQuantity(
                                                            context: context, id: cartItems[index]['_id'],
                                                             quantity: int.parse(cartItems[index]['quantity'])-1);
                                                          setState(() {
                                                            
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 24,
                                                          color: Colors
                                                              .grey.shade700,
                                                        ),
                                                      ),
                                                      Container(
                                                        color: Colors
                                                            .grey.shade200,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 2,
                                                                right: 12,
                                                                left: 12),
                                                        child: Text(
                                                          cartItems[index]['quantity'],
                                                          style: CustomTextStyle
                                                              .textFormFieldSemiBold,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async{

                                                          await ApiService().updateCartQuantity(
                                                            context: context, 
                                                            id: cartItems[index]['_id'], 
                                                            quantity: int.parse(cartItems[index]['quantity']) + 1
                                                            );
                                                        setState(() {
                                                          
                                                        });
                                                          
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 24,
                                                          color: Colors
                                                              .grey.shade700,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () async{

                                  setState(() {
                                    
                                  });

                                  await ApiService().deleteCartItem(cartItems[index]['_id'], context);

                                  
                                  
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 10, top: 8),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      color: Colors.red.shade700),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      itemCount: cartItems!.length,
                    );
                  }
                },
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Text(
                            "Total",
                            style: CustomTextStyle.textFormFieldMedium
                                .copyWith(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 30),
                          child: Text(
                            "\$${totalAmount}",
                            style: CustomTextStyle.textFormFieldBlack.copyWith(
                                color: Colors.greenAccent.shade700,
                                fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Utils.getSizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        padding: EdgeInsets.only(
                            top: 12, left: 60, right: 60, bottom: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                      ),
                      onPressed: () {
                        print('object');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckOut(amount: totalAmount.toString(),),
                            ));
                      },
                      child: Text(
                        "Checkout",
                        style: CustomTextStyle.textFormFieldSemiBold
                            .copyWith(color: Colors.white),
                      ),
                    ),

                    // ),
                    Utils.getSizedBox(height: 8),
                  ],
                ),
                margin: EdgeInsets.only(top: 16),
              )
            ],
          );
        },
      ),
    );
  }
}
