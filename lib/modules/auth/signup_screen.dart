
import 'package:crafton_final/modules/auth/student_signup_screen.dart';
import 'package:crafton_final/modules/auth/user_signup_screen.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            'Choose to register',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Container(
                  width: 422,
                  height: 307,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpUser(),));
                          },
                          child: Container(
                          
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.red.shade700, // Background color for container
                              borderRadius: BorderRadius.circular(5.0), // Set to 0 for square shape
                            ),
                            child: const Center(child: Text('User',style: TextStyle(fontSize: 20.0,color: Colors.white),)),
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentSignUp(),));
                          },
                          child: Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.red.shade700, // Background color for container
                              borderRadius: BorderRadius.circular(5.0), // Set to 0 for square shape
                            ),
                            child: const Center(child: Text('Student',style: TextStyle(fontSize: 20.0,color: Colors.white),)),
                          ),
                        ),

                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
