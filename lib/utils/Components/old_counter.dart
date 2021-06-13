import 'package:flutter/material.dart';
import 'package:cs310_week5_app/Product.dart';
import 'old_cart_counter.dart';

class CounterWithFavBtn extends StatelessWidget {


  const CounterWithFavBtn({
    Key key, @required this.product,
  }) : super(key: key);
  final Product product;
  @override

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CartCounter(),
        Container(
          padding: EdgeInsets.all(0),
  //        child: Row(
    //        children: [
      //       Icon(Icons.thumb_up_alt_sharp),
        //     //Text("${product.rating}",style: TextStyle(fontWeight: FontWeight.bold,),),
          //  ],
          //),

        )


      ],
    );
  }
}
