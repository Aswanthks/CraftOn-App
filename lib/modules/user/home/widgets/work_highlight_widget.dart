import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../servieces/api_service.dart';
import '../../../../servieces/db_services.dart';
import '../../products/single_product_screen.dart';

class HighLightWidget extends StatefulWidget {
  HighLightWidget({super.key});

  @override
  State<HighLightWidget> createState() => _HighLightWidgetState();
}

class _HighLightWidgetState extends State<HighLightWidget> {
  final highlightList = [
    'https://images.herzindagi.info/image/2022/Jan/craft-item-you-can-make-with-paper-plate.jpg',
    'https://5.imimg.com/data5/SELLER/Default/2022/3/GX/KZ/NO/143524742/new-product-500x500.jpeg',
    'https://5.imimg.com/data5/SELLER/Default/2022/6/QU/JJ/BC/138070366/new-product-500x500.jpeg'
  ];

  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(
      Uri.parse(
          '${ApiService.baseUrl}/api/user/view-product-highlights'),
    );

    print(response.body);

    if (response.statusCode == 200) {
      // Handle successful response
      return jsonDecode(response.body)['data']; // Decode JSON if successful
    } else {
      // Handle error scenario (e.g., display error message)
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('no data'));
          } else {
            var data = snapshot.data;

            return Container(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data!.length,
                itemBuilder: (context, index) => Card(
                  child: SizedBox(
                    width: 160,
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SingleProduct(
                                          details: data[index],
                                        ),
                                      ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    data[index]['image'][0],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SingleProduct(
                                          details: data[index],
                                        ),
                                      ));
                                },
                                child: Text(
                                  data[index]['product_name'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'RS:${data[index]["price"]}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {


                            await ApiService().addToCart(
                                loginId: DbService.getLoginId()!,
                                productId: data[index]['_id'],
                                price:double.parse( data[index]['price']),
                                context: context);

                            setState(() {

                            });





                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.red.shade700,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            child: const Text(
                              'Add to cart',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
