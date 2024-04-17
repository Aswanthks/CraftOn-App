import 'dart:convert';

import 'package:crafton_final/modules/user/booking/widget/booking_product_widget.dart';
import 'package:crafton_final/servieces/api_service.dart';
import 'package:crafton_final/servieces/db_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookingScreen extends StatefulWidget {
  final String loginId;

  const BookingScreen({Key? key, required this.loginId}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late Future<List<dynamic>> _cartItemsFuture;

  @override
  void initState() {
    super.initState();
    _cartItemsFuture = _fetchCartItems();
  }

  Future<List<dynamic>> _fetchCartItems() async {
    final url = Uri.parse('${ApiService.baseUrl}/api/user/view-cart-confirmed/${DbService.getLoginId()}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> cartItems = jsonDecode(response.body)['data'];

        print(cartItems);
        return cartItems;
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      throw Exception('Failed to load cart items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        title: Text(
          'My Bookings',
          style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu-Bold'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              isDark ? Icons.notifications : Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _cartItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No bookings found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => BookingProductWidget(
                // Pass booking details to the widget
                bookingDetails: snapshot.data![index],
              ),
            );
          }
        },
      ),
    );
  }
}
