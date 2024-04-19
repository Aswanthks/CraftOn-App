import 'dart:convert';
import 'package:crafton_final/servieces/api_service.dart';
import 'package:crafton_final/servieces/db_services.dart';
import 'package:crafton_final/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/custom_text_style.dart';
import '../../widgets/custom_utils.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  Future<List<dynamic>> fetchOrders(String loginId) async {
    final response = await http.get(
      Uri.parse('https://vadakara-mca-craft-backend.onrender.com/api/student/view-orders/$loginId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];

      print(data);
      return data;
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<List<dynamic>>(
          future: fetchOrders(DbService.getLoginId()!), // Replace 'login_id_here' with the actual login ID
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('No data'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  dynamic order = snapshot.data![index];
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 8, top: 4),
                          child: Text(
                            order['product_name'],
                            maxLines: 2,
                            softWrap: true,
                            style: CustomTextStyle.textFormFieldSemiBold.copyWith(fontSize: 14),
                          ),
                        ),
                        Utils.getSizedBox(height: 6),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                order['total'],
                                style: CustomTextStyle.textFormFieldBlack.copyWith(color: Colors.green),
                              ),
                              Spacer(),
                              CustomButton(
                                text: 'Accept',
                                onPressed: () {


                                  ApiService().confirmOrder(
                                    context: context,
                                    orderId:  order['_id'],


                                  );


                                  // Handle accept button pressed
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
