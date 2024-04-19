import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../servieces/api_service.dart';
import '../../../servieces/db_services.dart';
import '../../auth/login_screen.dart';
import '../complaint_view.dart';
import 'edit_profile_screen.dart';
import 'widget/profile_menu_widget.dart';
import 'package:http/http.dart' as http;

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({Key? key}) : super(key: key);

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  Future<Map<String, dynamic>> fetchProfileData(String loginId) async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/student/view-profile/$loginId'),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'][0];
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade700,
          // leading: IconButton(onPressed: () => {}, icon: const Icon(Icons.shopping_cart)),
          title: Text('Profile',
              style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu-Bold')),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  isDark ? Icons.notifications : Icons.notifications,
                  color: Colors.white,
                ))
          ],
        ),
        body: FutureBuilder(
          future: fetchProfileData(DbService.getLoginId()!),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var profileData = snapshot.data!;

              // Use profileData to populate your UI
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      /// -- IMAGE
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Image(
                                    image: AssetImage(
                                        'assets/images/slider1.png'))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(profileData['name'],
                          style: Theme.of(context).textTheme.headline4),
                      Text(profileData['email'],
                          style: Theme.of(context).textTheme.headline6),
                      Text(profileData['mobile'],
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 20),

                      /// -- BUTTON
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditStudentsProfile(
                                    name: profileData['name'],
                                    email: profileData['email'],
                                    address: profileData['address'],
                                    mobile: profileData['mobile'],
                                    id: profileData['_id'],
                                    stream: 'hhh',
                                    accadamicYear: profileData['academic_year'],
                                    courseName: profileData['course_name'],
                                  ),
                                ));

                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade700,
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          child: const Text('Edit Profile',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 10),

                      ListTile(
                        onTap: () {

                          Navigator.push(context,MaterialPageRoute(builder: (context) => ComplaintViewScreen(),));
                        },
                        title: Text('Complaints'),
                        trailing: Icon(Icons.arrow_circle_right),

                      ),

                      ListTile(
                        onTap: () {},
                        title: Text('Review'),
                        trailing: Icon(Icons.arrow_circle_right),
                      ),

                      ProfileMenuWidget(
                          title: "Logout",
                          icon: LineAwesomeIcons.alternate_sign_out,
                          textColor: Colors.red,
                          endIcon: false,
                          onPress: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login_page(),
                                ),
                                (route) => false);
                          }),
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
