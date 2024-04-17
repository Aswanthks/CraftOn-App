import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../servieces/api_service.dart';
import '../../../../servieces/db_services.dart';
import '../../../../widgets/custom_button.dart';
import '../edit_product_screen.dart';
import '../my_single_product.screen.dart';

class MyProductGridWidget extends StatefulWidget {
  MyProductGridWidget({super.key});

  @override
  State<MyProductGridWidget> createState() => _MyProductGridWidgetState();
}

class _MyProductGridWidgetState extends State<MyProductGridWidget> {
  final productList = [
    'https://cdn.pixabay.com/photo/2017/08/03/21/11/art-2578353_1280.jpg',
    'https://cdn.pixabay.com/photo/2017/08/03/21/11/art-2578353_1280.jpg',
    'https://cdn.pixabay.com/photo/2017/08/03/21/11/art-2578353_1280.jpg',
    'https://cdn.pixabay.com/photo/2017/08/03/21/11/art-2578353_1280.jpg',
    'https://cdn.pixabay.com/photo/2017/08/03/21/11/art-2578353_1280.jpg',
  ];

  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(
      Uri.parse(
          '${ApiService.baseUrl}/api/student/view-all-product-added-by-student/${DbService.getLoginId()}'),
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.count(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  childAspectRatio: .4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                  children: List.generate(
                    data!.length,
                    (index) => GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey.shade200)),
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
                                        builder: (context) => MySingleProduct(details: data[index],),
                                      ));
                                },
                                child: Image.network(
                                  data[index]['image'][0],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index]['product_name'],
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 15),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MySingleProduct(details:data[index]),
                                          ));
                                    },
                                    child:  Text(
                                      data[index]['price'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CustomButton(
                                      text: 'Edit',
                                      onPressed: () async{
                                      await  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProduct(details:data[index]),
                                            ));
                                        setState(() {
                                          
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CustomButton(
                                      text: 'Delete',
                                      onPressed: () async{

                                        setState(() {
                                          
                                        });

                                       await ApiService().deleteProduct(context,  data[index]['_id']);
                                        setState(() {
                                          
                                        });


                                        
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            );
          }
        });
 
 
 
 
  }
}
