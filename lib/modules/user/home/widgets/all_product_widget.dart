import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../servieces/api_service.dart';
import '../../../../servieces/db_services.dart';
import '../../products/single_product_screen.dart';

class AllProductWidget extends StatefulWidget {
  AllProductWidget({super.key});

  @override
  State<AllProductWidget> createState() => _AllProductWidgetState();
}

class _AllProductWidgetState extends State<AllProductWidget> {
  final highlightList = [
    'https://images.herzindagi.info/image/2022/Jan/craft-item-you-can-make-with-paper-plate.jpg',
    'https://5.imimg.com/data5/SELLER/Default/2022/3/GX/KZ/NO/143524742/new-product-500x500.jpeg',
    'https://5.imimg.com/data5/SELLER/Default/2022/6/QU/JJ/BC/138070366/new-product-500x500.jpeg'
  ];

  Future<List<dynamic>> fetchProducts() async {
    try {
      final response = await http.get(
          Uri.parse('${ApiService.baseUrl}/api/student/view-all-products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> productList = snapshot.data as List<dynamic>;

            print(productList[0]);

            return Container(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productList.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleProduct(
                          details: productList[index],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: SizedBox(
                      width: 160,
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      productList[index]['image'][0],
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
                                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => SingleProduct(),));
                                  },
                                  child: Text(
                                    productList[index]['product_name'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Rs.${productList[index]['price']}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async{



                              await ApiService().addToCart(
                                loginId: DbService.getLoginId()!, 
                                productId: productList[index]['_id'], 
                                price:double.parse( productList[index]['price']), 
                                context: context);

                            setState(() {
                              
                            });
                              


                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: const Text(
                                'ADD TO CART',
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
              ),
            );
          }
        });
  }
}
