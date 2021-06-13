import 'package:cs310_week5_app/routes/details_screen.dart';
import 'package:cs310_week5_app/routes/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/routes/login.dart';
import 'package:cs310_week5_app/routes/signup.dart';
import 'package:cs310_week5_app/routes/walkthrough.dart';
import 'package:cs310_week5_app/routes/account.dart';
import 'package:cs310_week5_app/routes/shopcart.dart';
import 'package:cs310_week5_app/routes/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cs310_week5_app/routes/search.dart';
import 'package:cs310_week5_app/routes/review.dart';

import 'notification/notificationslist.dart';


int initScreen;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //home: Welcome(),
        initialRoute: initScreen == 0 || initScreen == null ? '/walk': '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/walk': (context) => WalkThrough(),
          '/signup': (context) => SignUp(),
          '/login': (context) => Login(),
          //'/mainmenu': (context) => mainmenu(),
          '/account': (context) => Account(),
          //'/categories': (context) => Categories(),
          '/shopcart': (context) => ShopCart(),
          '/details_screen': (context) => DetailsScreen(),
          '/search': (context) => search(),
          '/review': (context) => ReviewPage(),
          '/notifications': (context) => Notifications(),
        },
    );
  }
}
