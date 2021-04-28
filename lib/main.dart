import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/pages/home_page.dart';
import 'package:flutter_wordpress_api/pages/login_page.dart';
import 'package:flutter_wordpress_api/services/shared_service.dart';

Widget _defaultHome = new LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool _result = await SharedService.isLoggedIn();

  if(_result){
    _defaultHome = new HomePage();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wordpress Login',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.redAccent,
        accentColor: Colors.cyan[600]
      ),
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        '/home' : (BuildContext context) => new HomePage(),
        '/login' : (BuildContext context) => new LoginPage()
      }
    );
  }
}