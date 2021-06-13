import 'package:cs310_week5_app/notification/notificationsPage.dart';
import 'package:cs310_week5_app/settings/setting.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../notification/notificationslist.dart';
import 'package:cs310_week5_app/utils/constant.dart';
import '../orders/orders.dart';

import 'package:flutter/material.dart';
import 'package:cs310_week5_app/Product.dart';
import 'package:cs310_week5_app/routes/details_screen.dart';
import 'package:cs310_week5_app/utils/Home_Components/appBar.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/utils/Home_Components/body.dart';
import 'package:cs310_week5_app/utils/Home_Components/appBar.dart';
import 'package:cs310_week5_app/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../http.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  static const kPrimcolor = Color(0xFFFF8084);
  static const kacolor = Color(0xFFF1F1F1);
  static const kwhitecolor = Color(0xFFFFFFFF);
  static const klightcolor = Color(0xFF808080);
  static const kdarkcolor = Color(0xFF303030);

  static const kRadius = 0.0;
  static const kAppBarHeight = 56.0;

  final labels = ['Notifications', 'Payments', 'My Orders', 'Account Settings'];
  final icons = [
    Icons.notifications,
    Icons.payment,
    Icons.local_dining,
    Icons.settings,
  ];
  @override
  int userId;
  bool isLoggedIn = false;
  var user;

  setIsLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getInt('userID');
    setState(() {
      if (id == 0) {
        isLoggedIn = false;
        //await preferences.setBool('isLoggedIn', true);
      } else {
        isLoggedIn = true;
        userId = id;
        //await preferences.setBool('isLoggedIn', false);
      }
    });
  }

  int _selectedIndex = 3;
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
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: [
              Container(
                height: 250.0,
                child: Image(
                  image: NetworkImage(
                      'https://lh3.googleusercontent.com/proxy/HIrAQDZQe1jrsLTzj3HFxe6-q0yJM_uqYhy25pIIgnuD5IESE0LiATMGt-o-e9iICEiM0tXT9LrG8i57aQg1bn72mpuPTURhsnSy9A'),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: -48,
                bottom: 10,
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      color: Colors.indigo,
                      width: 1,
                    ),
                    image: DecorationImage(
                      image: AssetImage('kerojordo.jpg'),
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: -40,
                  bottom: -20,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 23,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w900,
                    ),
                  )),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: labels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    icons[index],
                    color: Colors.red,
                  ),
                  title: Text(labels[index]),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    switch (labels[index]) {
                      case 'Notifications':
                        return Notifications();
                        break;

                      case 'My Orders':
                        return Orders();
                        break;

                      case 'Account Settings':
                        return Setting();
                        break;
                    }
                  })),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.house_sharp, color: Colors.white),
              label: "Home",
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.white),
              label: "Search",
              backgroundColor: Colors.orange),
          //BottomNavigationBarItem(icon: Icon(Icons.favorite,color: Colors.white),
          //   label: "Favorites", backgroundColor: Colors.yellow),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              label: "Cart",
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_sharp, color: Colors.white),
              label: "Account",
              backgroundColor: Colors.blue),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  snackBarMsg(BuildContext context, String msg) {
    var sb = SnackBar(
      elevation: 0.0,
      content: Text(msg),
      duration: Duration(seconds: 1),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(sb);
  }

  AppBar appBAR(BuildContext context) {
    if (isLoggedIn == true) {
      return AppBar(
        backgroundColor: AppColors.ardaColor,
        automaticallyImplyLeading: false,
        title: Text(
          "MyAccount",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return AppBar(
        backgroundColor: AppColors.ardaColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Account Page",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.zero,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )),
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
              )),
        ],
      );
    }
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
