import 'package:cs310_week5_app/utils/color.dart';
import 'package:flutter/material.dart';

class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State {
  int curr = 0;
  int totalpage = 4;

  List<List<String>> stringList = [
    [
      "WELCOME",
      "Awesome e-commerce app",
      "https://adtechresources.com/wp-content/uploads/2020/02/Mobile-Application.jpeg",
      "Your personal shop"
    ],
    [
      "INTRO",
      "Signup easily",
      "https://cdn.pttrns.com/764/8981_f.jpg",
      "You can register with many options"
    ],
    [
      "PROFILE",
      "Create your profile and...",
      "https://recentlyheard.com/wp-content/uploads/2019/11/eCommerce-sites-discounts.jpg",
      "Promotions, coupons and special offers"
    ],
    [
      "CONTENT",
      "Unique shoes!",
      "https://i.pinimg.com/originals/fe/0b/a0/fe0ba0ae65e6ae07f3331211131a1a5b.jpg",
      "You can buy & sell incredible products!"
    ],
  ];

  void nextPage() {
    setState(() {
      if (curr == 3) {
        curr = 3;
      } else {
        curr++;
      }
    });
  }

  void prevPage() {
    setState(() {
      if (curr == 0) {
        curr = 0;
      } else {
        curr--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: Color(0xFFD1D1D6),
        title: Text(
          stringList[curr][0],
          style: TextStyle(
            color: Color(0xFF757575),
            letterSpacing: -1,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                stringList[curr][1],
                style: TextStyle(
                  color: Color(0xFF229A98),
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(stringList[curr][2]),
              //I made radius 140 which is equivalent to circular image 280x280
              radius: 140,
              backgroundColor: Color(0xFF229A98),
            ),
            Center(
              child: Text(
                stringList[curr][3],
                style: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: prevPage,
                    child: Text(
                      "Prev",
                      style: TextStyle(color: AppColors.keremColor),
                    ),
                  ),
                  Text(
                    "${curr + 1}/$totalpage",
                    style: TextStyle(color: Color(0xFF229A98)),
                  ),
                  OutlinedButton(
                    onPressed: nextPage,
                    child: Text(
                      "Next",
                      style: TextStyle(color: AppColors.ardaColor),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
