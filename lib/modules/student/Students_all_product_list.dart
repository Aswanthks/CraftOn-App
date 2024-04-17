
import 'package:crafton_final/modules/student/student_all_product_grid.dart';
import 'package:flutter/material.dart';

class StudentAllProductList extends StatefulWidget {
  const StudentAllProductList({super.key});

  @override
  State<StudentAllProductList> createState() => _StudentAllProductListState();
}

class _StudentAllProductListState extends State<StudentAllProductList> {
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
       StudentAllProductGrid()
      ,
    );
  }
}