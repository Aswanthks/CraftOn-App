
import 'package:flutter/material.dart';

import '../../servieces/api_service.dart';
import '../../utils/vslidator.dart';
import '../../widgets/custom_text_field.dart';
import 'login_screen.dart';

class SignUpUser extends StatefulWidget {
  const SignUpUser({super.key});

  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  final formState = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: loading ?  Center(child: CircularProgressIndicator(),)  : Form(
        key: formState,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5), blurRadius: 5.0)
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 100,
                        child: Text(
                          'User Sign Up',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: CustomTextField(
                          controller: _nameController,
                          hintText: 'Enter name',
                          labelText: 'Name',
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Enter name' : null,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: CustomTextField(
                          controller: _emailController,
                          hintText: 'Enter email',
                          labelText: 'Email',
                          validator: (value) => validateEmail(value),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: CustomTextField(
                          controller: _mobileController,
                          hintText: 'Enter mobile number',
                          labelText: 'Mobile number',
                          validator: (value) {
                            if (_mobileController.text.length != 10) {
                              return 'Mobile number must be 10 digits';
                            }
                          }



                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: CustomTextField(
                          controller: _addressController,
                          hintText: 'Enter your address',
                          labelText: 'Address',
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Enter Address' : null,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: CustomTextField(
                          obscureText: true,
                          controller: _passwordController,
                          labelText: 'Password',
                          hintText: 'Enter secure password',
                          validator: (value) => validatePassword(value),
                        ),
                      ),
                      SizedBox(
                        height: 65,
                        width: 360,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade700),
                              child: Text(
                                'Signup',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
          

          
          
          
                                   if(formState.currentState!.validate()){
          
                                     await ApiService().registerUser(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  mobile: _mobileController.text,
                                  address: _addressController.text,
                                  password: _passwordController.text,
                                  context: context,
                                );
          

                                }else{
          
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('all fields are required!!')));
          
                                }
          
                                setState(() {
                                  loading = false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account? '),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login_page(),
                                        ));
                                  },
                                  child: Text(
                                    'Click here to login.',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.blue),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
