
import 'package:crafton_final/modules/auth/signup_screen.dart';
import 'package:flutter/material.dart';

import '../../servieces/api_service.dart';
import '../../utils/vslidator.dart';
import '../student/home/student_root_screen.dart';
import '../user/home/user_root_screen.dart';

class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  final formKey = GlobalKey<FormState>();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.only(
                    top: 170, bottom: 170, left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5), blurRadius: 5.0)
                    ],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 50,
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) => validateEmail(value),
                            decoration: InputDecoration(
                                errorText: emailError,
                                border: const OutlineInputBorder(),
                                labelText: 'Email',
                                hintText:
                                    'Enter valid email id as abc@gmail.com'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15, bottom: 0),
                          //padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) => validatePassword(value),
                            obscureText: true,
                            decoration: InputDecoration(
                                errorText: passwordError,
                                border: const OutlineInputBorder(),
                                labelText: 'Password',
                                hintText: 'Enter secure password'),
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
                                child: const Text(
                                  'Log in ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () async {
                                  if(formKey.currentState!.validate()){
                                    setState(() {
                                    loading = true;
                                  });
                                var role =   await ApiService().login(
                                      context: context,
                                      email: _emailController.text,
                                      password: _passwordController.text);

                                  if(role == 1){

                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => UserRootScreen(),), (route) => false);
                                  }

                                  if(role == 2){

                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StudentRootScreen(),), (route) => false);
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Dont have an account? '),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SignUp(),
                                      ));
                                },
                                child: const Text(
                                  'Click here to register.',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue),
                                ))
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void _loginHandler() {
    setState(() {
      emailError = validateEmail(_emailController.text);
      passwordError = validatePassword(_passwordController.text);
      // if (emailError == null && passwordError == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const UserRootScreen(),
          ),
          (route) => false);
      // } else {
      //   setState(() {});
      // }
    });
  }
}
