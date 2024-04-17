
import 'package:crafton_final/modules/user/booking/booking_screen.dart';
import 'package:crafton_final/servieces/db_services.dart';
import 'package:flutter/material.dart';

import '../cart/cart_page.dart';
import '../profile/profile_screen.dart';
import 'home_screen.dart';

class UserRootScreen extends StatefulWidget {
  const UserRootScreen({super.key});

  @override
  State<UserRootScreen> createState() => _UserRootScreenState();
}

class _UserRootScreenState extends State<UserRootScreen> {


  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pagesList = [
    const Home(),
    CartPage(),
    BookingScreen(loginId: DbService.getLoginId()!),
    ProfileScreen(),
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
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),

           BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bookings',
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