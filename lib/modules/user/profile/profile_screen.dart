
import 'package:crafton_final/modules/user/user_complaint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../servieces/api_service.dart';
import '../../../servieces/db_services.dart';
import '../../auth/login_screen.dart';
import '../../student/profile/widget/profile_menu_widget.dart';
import '../booking/booking_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> _fetchProfileData() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/api/user/view-profile/${DbService.getLoginId()}'),
    );
    print('ffff');
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
        title: Text('Profile', style: TextStyle(color: Colors.white, fontFamily: 'Ubuntu-Bold')),
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
        future: _fetchProfileData(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final profileData = snapshot.data!;
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: const Image(
                                  image: AssetImage('assets/images/slider1.png'))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(profileData['name'], style: Theme.of(context).textTheme.headline4),
                    Text(profileData['email'], style: Theme.of(context).textTheme.headline6),
                    Text(profileData['mobile'], style: Theme.of(context).textTheme.headline6),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () => {

                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditUserProfile(
                            address: profileData['address'],
                            email: profileData['email'],
                            mobile: profileData['mobile'],
                            name: profileData['name'],
                          ),)),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserComplaintViewScreen() ,));
                      },
                      title: Text('My complaint'),
                      trailing: Icon(Icons.arrow_right),


                    ),

                    ProfileMenuWidget(
                        title: "Logout",
                        icon: LineAwesomeIcons.alternate_sign_out,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login_page(),));
                        }),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
