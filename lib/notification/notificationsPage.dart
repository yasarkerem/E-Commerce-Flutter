import 'package:flutter/material.dart';
import 'notificationslist.dart';
class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.pink),
        ),

        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.pink),
        leading: IconButton( //default back button
          icon: Icon(Icons.arrow_back_ios, color: Colors.pink),
          onPressed: () => Navigator.of(context).pop(),
        ),

      ),
      body: FittedBox(
        child: Container(

          width: MediaQuery.of(context).size.width,
          
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(10),
          
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [BoxShadow(
              color: Colors.deepPurpleAccent,
              blurRadius: 2.0,

            )]
          ),
          child: Column(
           
            children: [
              Text(
              "Bildirim başlığı auahaoıifhsfaoh",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),

              Text(
                "Bildirim açıklaması afşuhqşfahoşı, açıklama yapmak ne kadar kolaymış sanki",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),

          ],
          ),
        ),
      ),
    );

  }
}