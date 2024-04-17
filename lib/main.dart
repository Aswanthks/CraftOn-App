
import 'package:crafton_final/servieces/db_services.dart';
import 'package:flutter/material.dart';

import 'modules/auth/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DbService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  Login_page()
     
    );
  }
}
