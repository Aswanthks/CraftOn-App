import 'dart:convert';

import 'package:crafton_final/servieces/db_services.dart';
import 'package:crafton_final/widgets/custom_button.dart';
import 'package:crafton_final/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  TextEditingController _replyController = TextEditingController();

  Future<dynamic> fetchComplaints(String loginId) async {
    final response = await http.get(
      Uri.parse('https://vadakara-mca-craft-backend.onrender.com/api/student/view-feedback-student/$loginId'),
    );

    print('------------------------------------------------');
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];

      return data;
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: FutureBuilder<dynamic>(
        future: fetchComplaints(DbService.getLoginId()!), // Replace 'login_id_here' with the actual login ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {

            return snapshot.data!.length == 0 ? Center(child: Text('No complaints'),)  : ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.message),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(snapshot.data![index]['name'],style: TextStyle(color: Colors.blue),),
                    SizedBox(height: 5,),
                      Text(snapshot.data![index]['feedback']),


                  ],
                ),
                subtitle: Text(snapshot.data![index]['product'],),
              ),
            );
          }
        },
      ),
    );
  }
}
