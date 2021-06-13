
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/routes/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Deneme extends StatefulWidget {
  @override
  _DenemeState createState() => _DenemeState();
}

class _DenemeState extends State<Deneme> {
  @override

  int userId;
  bool isLoggedIn = false;
  var user;


  setIsLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getInt('userID');
    setState(() {
      if (id == null)
      {
        isLoggedIn = false;
        //await preferences.setBool('isLoggedIn', true);
      }
      else
      {
        print("ho");
        isLoggedIn = true;
        userId = id;
        //await preferences.setBool('isLoggedIn', false);
      }
    });
  }


  void initState() {
    super.initState();
    setIsLoggedIn();
  }



  Widget build(BuildContext context) {
    if(isLoggedIn){
      return Scaffold(
        appBar: AppBar(
          title: Text("o artık ${isLoggedIn}",),
        ),
      );
    }
  }
}
