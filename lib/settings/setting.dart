import 'package:flutter/material.dart';

final settingLabel = [
  'Account',
  'Address',
  'Telephone',
  'E-mail',
  'Setting',
  'Credit Card',
];

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Account Settings',
          style: TextStyle(color: Colors.pink),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.pink),
        leading: IconButton(
          //default back button k
          icon: Icon(Icons.arrow_back_ios, color: Colors.pink),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.separated(

        itemCount: settingLabel.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              settingLabel[index],
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,

                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.grey,);
        },
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
}
