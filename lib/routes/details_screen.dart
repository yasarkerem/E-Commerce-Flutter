import 'package:cs310_week5_app/utils/color.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:cs310_week5_app/Product.dart';
import 'package:cs310_week5_app/utils/Components/body.dart';
import 'package:cs310_week5_app/routes/search.dart';
class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);



  @override



  _DetailsScreenState createState() => _DetailsScreenState();
}



class _DetailsScreenState extends State<DetailsScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: AppColors.ardaColor,
      appBar: buildAppBar(context),
      body: Body(product: widget.product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
    );
  }
}



