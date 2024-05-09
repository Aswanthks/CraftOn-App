import 'dart:convert';

import 'package:crafton_final/servieces/db_services.dart';
import 'package:crafton_final/widgets/custom_button.dart';
import 'package:crafton_final/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplaintViewScreen extends StatefulWidget {
  const ComplaintViewScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintViewScreen> createState() => _ComplaintViewScreenState();
}

class _ComplaintViewScreenState extends State<ComplaintViewScreen> {
  TextEditingController _replyController = TextEditingController();

  Future<dynamic> fetchComplaints(String loginId) async {
    final response = await http.get(
      Uri.parse('https://vadakara-mca-craft-backend.onrender.com/api/student/view-complaint-student/$loginId'),
    );

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

            if(snapshot.data!.length == 0) {
              return Center(child: Text('No complaints'),);
            }else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                actions: [
                                  CustomButton(
                                    text: 'Reply',
                                    onPressed: () {
                                      if (_replyController.text.isNotEmpty) {
                                        postReply(snapshot.data![index]['_id'],
                                            _replyController.text);
                                        Navigator.pop(context);
                                      }
                                      // Handle replay button pressed
                                    },
                                  )
                                ],
                                title: CustomTextField(
                                  hintText: 'Enter reply',
                                  controller: _replyController,
                                  labelText: 'Reply',
                                ),
                              ),
                        );
                      },
                      leading: Icon(Icons.message),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("User : ${snapshot.data![index]['name']}"),
                          Text("Product : ${snapshot.data![index]['product']}"),




                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Title : ${snapshot.data![index]['title']}"),
                          Text("Description : ${snapshot
                              .data![index]['complaint']}"),

                          if( snapshot.data![index]['reply'].length != 0 )
                            Text('Replied',style: TextStyle(color: Colors.red),)
                        ],),
                    );
                  }


              );
            }
          }
        },
      ),
    );
  }


  Future<void> postReply(String id, String reply) async {
    try {
      // Make HTTP POST request
      var response = await http.post(
        Uri.parse('https://vadakara-mca-craft-backend.onrender.com/api/user/reply-complaint'),
        body: {'_id': id, 'reply': reply},
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Show snackbar if successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reply posted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Show error snackbar if request fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to post reply!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Show error snackbar if exception occurs
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
