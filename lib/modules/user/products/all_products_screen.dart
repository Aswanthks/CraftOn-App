
import 'package:crafton_final/modules/user/products/widgets/products_grid_widget.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        // leading: IconButton(onPressed: () => {}, icon: const Icon(Icons.shopping_cart)),
        title: Text('All Items',
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
      body: 
       AllProductGridWidget()
      ,
    );
  }
}