import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../http.dart';
import 'notificationsPage.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  int _selectedIndex = 3;
  List routes = ["/", "/search", "/shopcart", "/account"];

  List<Notif> notifs = [];

  void initState() {
    super.initState();
    this.getNotifs();
  }

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

  Future<void> deleteNotif(int nid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getInt('userID');
    var result = await http_put("api/removenotification", {
      "uid": id,
      "nid": nid
    });
    if(result.ok)
    {
      print(result.data['message']);
    }
  }

  Future<void> getNotifs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getInt('userID');
    var queryParameters = {
      'uid': '$id',
    };

    var result = await http_getWparams("api/shownotifications", queryParameters);
    if(result.ok)
    {
      setState(() {
        if(result.data['message'] == 'OK')
        {
          var in_notifs = result.data['products'] as List<dynamic>;
          in_notifs.forEach((in_notif){
            notifs.add(Notif(
              nid: in_notif['nid'],
              text: in_notif['text'],
            ));
          });
        }
        else {
          print(result.data['message']);
        }
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications List',
          style: TextStyle(color: Colors.pink),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.pink),
        leading: IconButton(
          //default back button
          icon: Icon(Icons.arrow_back_ios, color: Colors.pink),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: notifs.length == 0 ? Center(child: Text("There are no notifications."))
          : ListView.separated(
          itemCount: notifs.length,


          itemBuilder: (context, index) {
            return ListTile(

              title: Text(
                notifs[index].text,
                style: TextStyle(
                  color: Colors.indigo,
                ),
              ),
              onTap: (){
                deleteNotif(notifs[index].nid);
                Navigator.popAndPushNamed(context, "/notifications");
              },
              enabled: true,
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          }),
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

class Notif {

  int nid;
  String text;

  Notif({this.nid, this.text});

}
