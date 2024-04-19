
import 'package:flutter/material.dart';
import '../../servieces/api_service.dart';
import '../../utils/vslidator.dart';
import '../../widgets/custom_text_field.dart';
import 'login_screen.dart';

class StudentSignUp extends StatefulWidget {
  const StudentSignUp({super.key});

  @override
  State<StudentSignUp> createState() => _StudentSignUpState();
}

class _StudentSignUpState extends State<StudentSignUp> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _academicYearController = TextEditingController();
  final _courseController = TextEditingController();
  final _streamController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Form(
                key: formKey,
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
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5.0)
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 70,
                              child: Text(
                                'Student Sign Up',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: CustomTextField(
                                controller: _nameController,
                                hintText: 'Enter name',
                                labelText: 'Name',
                                validator: (value) =>
                                     value == null || value.isEmpty ?   'Fill the field' : null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: CustomTextField(
                                controller: _emailController,
                                hintText: 'Enter email',
                                labelText: 'Email',
                                validator: (value) => validateEmail(value),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: CustomTextField(
                                controller: _mobileController,
                                hintText: 'Enter mobile number',
                                labelText: 'Mobile number',
                                validator: (value) {
                                  // Check if the number contains exactly 10 digits
                                  if (_mobileController.text.length != 10) {
                                    return 'Mobile number must be 10 digits';
                                  }

                                  // Check if no two consecutive digits are the same
                                  // for (int i = 0; i < _mobileController.text.length - 1; i++) {
                                  //   if (_mobileController.text[i] == _mobileController.text[i ]) {
                                  //     return  '' ;
                                  //   }
                                  // }

                                  return null;
                                }
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: CustomTextField(
                                controller: _addressController,
                                hintText: 'Enter your address',
                                labelText: 'Address',
                                validator: (value) =>
                                     value == null || value.isEmpty ?   'Fill the field' : null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: CustomTextField(
                                controller: _academicYearController,
                                hintText: 'Academic year',
                                labelText: 'Academic year',
                                validator: (value) =>
                                     value == null || value.isEmpty ?   'Fill the field' : null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: CustomTextField(
                                controller: _courseController,
                                hintText: 'Course name',
                                labelText: 'Course name',
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Fill the field'
                                        : null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: CustomTextField(
                                controller: _streamController,
                                hintText: 'Stream',
                                labelText: 'Stream',
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Fill the field'
                                        : null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });

                                        if(formKey.currentState!.validate()){

                                          await ApiService().registerStudent(
                                              name: _nameController.text,
                                              email: _emailController.text,
                                              mobile: _mobileController.text,
                                              address: _addressController.text,
                                              stream: _streamController.text,
                                              academicYear:
                                              _academicYearController.text,
                                              courseName: _courseController.text,
                                              password: _passwordController.text,
                                              context: context);
                                        }

                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Already have an account? '),
                                    InkWell(
                                        onTap: () {

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
                            SizedBox(
                              height: 20,
                            )
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
