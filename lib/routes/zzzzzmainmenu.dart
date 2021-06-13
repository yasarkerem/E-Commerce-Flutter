import 'dart:ffi';

import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/productCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http.dart';

class mainmenu extends StatefulWidget {
  @override
  _mainmenuState createState() => _mainmenuState();
}

class Product {
  String name;
  AssetImage image;
  double rating;
  double price;

}



class _mainmenuState extends State<mainmenu> {

  int _selectedIndex = 0;

List routes = ["/", "/home_screen", "/shopcart", "/account"];
  void _onItemTapped(int index) {
    setState(() {
      int oldIndex = _selectedIndex;
      _selectedIndex = index;
      if(_selectedIndex != oldIndex) {
        Navigator.popAndPushNamed(context, routes[index]);
      }
    });
  }

  bool isLoggedIn;
  var user;

  setIsLoggedIn() async {
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    var result = await http_get("login");
    if (result.ok)
    {
      setState(() {
        print(result.data);
        if (result.data['loggedIn'] == false)
        {
          print("hi");
          isLoggedIn = false;
          //await preferences.setBool('isLoggedIn', true);
        }
        else
        {
          print("ho");
          isLoggedIn = true;
          user = new Map<String, dynamic>.from(result.data['user'][0]);
          //await preferences.setBool('isLoggedIn', false);
        }
      });
    }
  }

  void initState() {
    super.initState();
    setIsLoggedIn();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.ardaColor,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 200),
            child: IconButton(icon: Icon(Icons.search),
                onPressed: (){
              showSearch(context: context, delegate: null);
                }),
          ),
          Padding(
              padding: EdgeInsets.zero,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  "", style: TextStyle(
                  color: Colors.white,
                ),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
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
      ),


      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: ProductCard()),
                  Expanded(child: ProductCard()),
                ],
              ),
              SizedBox(height: 100,),
              Row(
                children: [
                  Text("3.column",style: TextStyle(
                    fontSize: 50,
                  ),)
                ],
              ),
              SizedBox(height: 100,),
              Row(
                children: [
                  Text("4.column",style: TextStyle(
                    fontSize: 50,
                  ),)
                ],
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.house_sharp,color: Colors.white),
              label: "Home",backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.search,color: Colors.white),
              label: "Categories",backgroundColor: Colors.orange),
         //BottomNavigationBarItem(icon: Icon(Icons.favorite,color: Colors.white),
           //   label: "Favorites", backgroundColor: Colors.yellow),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,color: Colors.white),
              label: "Cart",backgroundColor: Colors.green),
          BottomNavigationBarItem(icon: Icon(Icons.account_box_sharp,color: Colors.white),
              label: "Account",backgroundColor: Colors.blue),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,

        onTap: _onItemTapped,
      ),
    );
  }
}


