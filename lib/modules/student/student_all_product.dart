
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../servieces/api_service.dart';

class StudentAllProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<dynamic> productList = snapshot.data as List<dynamic>;
          return Container(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> product = productList[index];
                return Card(
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
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => SingleProduct(details: data[index],),));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    product['image'][0],
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
                                  product['product_name'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Rs.${product['price'].toString()}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  
  
  
  }

  Future<List<dynamic>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('${ApiService.baseUrl}/api/student/view-all-products'));
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
}
