
import 'package:crafton_final/modules/student/booking.dart';
import 'package:crafton_final/modules/student/home/student_home_screen.dart';
import 'package:flutter/material.dart';

import '../product/add_product_screen.dart';
import '../profile/profile_screen.dart';

class StudentRootScreen extends StatefulWidget {
  const StudentRootScreen({super.key});

  @override
  State<StudentRootScreen> createState() => _StudentRootScreenState();
}

class _StudentRootScreenState extends State<StudentRootScreen> {


  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pagesList = [
    const StudentHome(),
    AddProduct(),
    Booking(),
    StudentProfileScreen(),
  ];


  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade700,
      body:_pagesList[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_rounded),
            label: 'Add product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'booking',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',

          ),

        ],
      ),
    );
  }
}