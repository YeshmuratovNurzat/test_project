import 'package:flutter/material.dart';
import 'package:test_project/widgets/auth/auth_widget.dart';
import 'package:test_project/widgets/home/home_widget.dart';

void main() {
  const app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white
        ),
        primarySwatch: Colors.deepPurple,
      ),
      home: AuthWidget(),
      routes: <String, WidgetBuilder>{
        '/auth': (context) => AuthWidget(),
        '/home': (context) => HomeWidget(),
      },
      initialRoute: '/auth',
    );
  }
}
