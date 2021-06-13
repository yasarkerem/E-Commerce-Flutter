import 'package:cs310_week5_app/utils/Home_Components/appBar.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/utils/Home_Components/body.dart';
import 'package:cs310_week5_app/utils/Home_Components/appBar.dart';
import 'package:cs310_week5_app/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../http.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int userId;
  String username;
  bool isLoggedIn = false;
  var user;

   setIsLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getInt('userID');
    setState(() {
      if (id == 0) {
        isLoggedIn = false;
        //await preferences.setBool('isLoggedIn', true);
      }
      else {
        isLoggedIn = true;
        userId = id;
        //await preferences.setBool('isLoggedIn', false);
      }
    });
  }

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('userID', 0);
    setState((){
      isLoggedIn = false;
    });
  }


  void initState() {
    super.initState();
    setIsLoggedIn();
  }

  @override
  int _selectedIndex = 0;

  List routes = ["/", "/search", "/shopcart", "/account"];

  void _onItemTapped(int index) {
    setState(() {
      int oldIndex = _selectedIndex;
      _selectedIndex = index;
      if (_selectedIndex != oldIndex) {
        //Navigator.pushNamed(context, routes[index]);
        Navigator.popAndPushNamed(context, routes[index]);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBAR(context),
        body: Body(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.house_sharp, color: Colors.white),
                label: "Home", backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.white),
                label: "Search", backgroundColor: Colors.orange),
            //BottomNavigationBarItem(icon: Icon(Icons.favorite,color: Colors.white),
            //   label: "Favorites", backgroundColor: Colors.yellow),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                label: "Cart", backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box_sharp, color: Colors.white),
                label: "Account", backgroundColor: Colors.blue),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,

          onTap: _onItemTapped,
        )
    );
  }
/*
  AppBar buildAppBar() {
    return AppBar(
      title: Text("lalaland"),
    );
  }
*/
  AppBar appBAR(BuildContext context) {
    if (isLoggedIn == true) {
      return AppBar(
        backgroundColor: AppColors.ardaColor,
        automaticallyImplyLeading: false,
        title: Text("Welcome to Home Page",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextButton(
              child: Text("Log Out",
              style: TextStyle(
                color: Colors.white,
              ),),
              onPressed: (){
                logOut();
              },
            ),
          ),
        ],
      );
    }
    else {
      return AppBar(
        backgroundColor: AppColors.ardaColor,
        automaticallyImplyLeading: false,
        title: Text("Home Page",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.zero,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  "Register", style: TextStyle(
                  color: Colors.white,
                ),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
          ),
        ],
      );
    }
  }
}