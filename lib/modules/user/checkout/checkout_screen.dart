
import 'package:crafton_final/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../servieces/api_service.dart';
import '../../../servieces/db_services.dart';
import '../../../widgets/custom_text_field.dart';
import '../payment/payment_screen.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key, required this.amount});


  final String  amount;

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final _addressController = TextEditingController();

  bool isPaid = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        // leading: IconButton(onPressed: () => {}, icon: const Icon(Icons.shopping_cart)),
        title: Text('CheckOut',
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
        child: Column(children: [
          Expanded(
              child: ListView(children: [
            Container(
              margin: EdgeInsets.only(top: 50, bottom: 4, left: 4, right: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(color: Colors.grey.shade200)),
                  padding: EdgeInsets.only(left: 12, top: 8, right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 18,
                      ),

                      CustomTextField(
                          hintText: 'Enter delivery address',
                          labelText: 'Address',
                          controller: _addressController),

                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          Text('Select payments'),
                          Spacer(),
                          isPaid ?  const Text('Completed') :  CustomButton(text: 'Add', onPressed: ()  async{
                           isPaid = await  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(totalAmount: widget.amount,),));
                           
                           if(isPaid){
                             setState(() {
                               
                             });
                             
                           }

                          },)
                        ],
                      ),

                      SizedBox(height: 20,),

                      // standard Delivery

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                color: Colors.tealAccent.withOpacity(0.4),
                                width: 1),
                            color: Colors.tealAccent.withOpacity(0.2)),
                        margin: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: 1,
                              onChanged: (isChecked) {},
                              activeColor: Colors.tealAccent.shade400,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Standard Delivery",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Delivery within 7 days",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      // price section

                      Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                border:
                                    Border.all(color: Colors.grey.shade200)),
                            padding: EdgeInsets.only(
                                left: 12, top: 8, right: 12, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "PRICE DETAILS",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.5,
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Total MRP",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        widget.amount,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Bag discount",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '0',
                                        style: TextStyle(
                                            color: Colors.teal.shade300,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),


                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Order Total",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        '${widget.amount}',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 3),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Delievery Charges",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        'FREE',
                                        style: TextStyle(
                                            color: Colors.teal.shade700,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.5,
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  color: Colors.grey.shade400,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      '${widget.amount}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )
                                  ],
                                ),

                                SizedBox(
                                  height: 120,
                                ),

                                //button

                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red.shade700),
                                    onPressed: ()  async{
                                      if (_addressController.text.isEmpty || isPaid == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Add delevery address or complet payment')));
                                      } else {
                                        print(isPaid);


                                        try{


                                          await ApiService().orderProduct(loginId: DbService.getLoginId()!, context: context);




                                        }catch(e){


                                          setState(() {

                                          });

                                        }






                                      }
                                    },
                                    child: Text(
                                      "Place Order",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]))
        ]),
      ),
    );
  }
}
