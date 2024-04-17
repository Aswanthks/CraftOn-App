
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../servieces/api_service.dart';
import '../../widgets/custom_button.dart';
import '../user/products/single_product_screen.dart';

class StudentAllProductGrid extends StatelessWidget {
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              childAspectRatio: .60,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              children: List.generate(
                productList.length,
                (index) => GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SingleProduct(
                                      details: productList[index],
                                    ),
                                  ));
                            },
                            child: Image.network(
                              productList[index]['image'][0],
                              fit: BoxFit.fill,
                              height: 120,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  productList[index]['product_name'],
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 15,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => SingleProduct(),));
                                },
                                child: Text(
                                  productList[index]['price'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CustomButton(
                                  text: 'view more',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SingleProduct(
                                            details: productList[index],
                                          ),
                                        ));
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
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
      },
    );
  }

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


}
