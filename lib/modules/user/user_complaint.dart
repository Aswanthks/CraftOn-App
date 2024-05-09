import 'dart:convert';

import 'package:crafton_final/servieces/db_services.dart';
import 'package:crafton_final/widgets/custom_button.dart';
import 'package:crafton_final/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserComplaintViewScreen extends StatefulWidget {
  const UserComplaintViewScreen({Key? key}) : super(key: key);

  @override
  State<UserComplaintViewScreen> createState() => _UserComplaintViewScreenState();
}

class _UserComplaintViewScreenState extends State<UserComplaintViewScreen> {
  TextEditingController _replyController = TextEditingController();

  Future<dynamic> fetchComplaints(String loginId) async {
    final response = await http.get(
      Uri.parse('https://vadakara-mca-craft-backend.onrender.com/api/user/view-complaint-user/${DbService.getLoginId()}'),
    );


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
        title: Text('Complaint'),
      ),
      body: FutureBuilder<dynamic>(
        future: fetchComplaints(DbService.getLoginId()!), // Replace 'login_id_here' with the actual login ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {

            print(snapshot.data);


            return snapshot.data!.length == 0 ? Center(child: Text('No complaints'),)  : ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Reply"),

                      content: Text(snapshot.data![index]['reply'].length != 0 ?  snapshot.data![index]['reply'] : 'replayed soon'),
                  ));
                },
                leading: Icon(Icons.message),
                title: Text(snapshot.data![index]['title']),
                subtitle: Text(snapshot.data![index]['complaint']),
              ),
            );
          }
        },
      ),
    );
  }
}
