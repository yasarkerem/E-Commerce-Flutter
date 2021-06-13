import 'package:cs310_week5_app/routes/review.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:cs310_week5_app/Product.dart';


class AddToCart extends StatelessWidget {
  const AddToCart({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: product.color,
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.add_shopping_cart),

              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ReviewPage(
                        product: product,
                      );
                    }) );
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: AppColors.keremColor,
                onPressed: () {
                  if (product.stock != 0){
                    return showDialog<void>(context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context){
                      return AlertDialog(
                      title: Text("Alert Title"),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text("Out of Stock"),
                              Text("For notifications press yes"),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(child: Text("Cancel"),
                          onPressed: (){
                            Navigator.pop(context, "Cancel");
                          },),
                          TextButton(child: Text("Yes"),
                            onPressed: (){
                              Navigator.pop(context, "Yes");
                            },),
                        ],
                      );
                    });
                  }
                },
                child: Text(
                  "Add to Cart ${product.title}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
