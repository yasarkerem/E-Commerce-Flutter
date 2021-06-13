import 'package:cs310_week5_app/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/Product.dart';
import 'package:http/http.dart';
class Cart_Card extends StatefulWidget {

  const Cart_Card({
    Key key,
    this.product,
    this.cartproduct,
  }) : super(key: key);

  final Product product;
  final cartProduct cartproduct;

  @override
  _Cart_CardState createState() => _Cart_CardState();
}

List<cartProduct> CartList =[
  cartProduct("urunaaaaaaa s f tr b eg r d ", 9.99, "yellow", "nike", 40,2),
  cartProduct("urun2", 19.99, "red", "adi", 42,2),
  cartProduct("urun3", 29.99, "yellow", "puma", 43,2),
  cartProduct("urun4", 39.99, "red", "hemm", 41,3),
  cartProduct("urun5", 49.99, "black", "hub", 48,4),
  cartProduct("urun6", 49.99, "black", "hub", 48,4),
];

class _Cart_CardState extends State<Cart_Card> {
  @override
  int itemcount = 1;
  double totalPrice = 0;
  @override


  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset("assets/kerojordo.jpg",width: 50,height: 100,),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: Text("${widget.cartproduct.title}",
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,),
                  ),
                ],
              ),
            ),
            IconButton(icon: Icon(Icons.delete), onPressed: (){})

          ],
        ),
        subtitle: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text("Size: "),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0,0,0,0),
                      child: Text("${widget.cartproduct.size.toStringAsFixed(0)}"),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text("Color: "),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0,0,0,0),
                      child: Text("${widget.cartproduct.color}"),
                    ),
                  ],
                ),
                /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0,0,0,0),
                      child: IconButton(icon: Icon(Icons.remove_circle_outline_sharp,),
                        onPressed:(){
                          if (widget.cartproduct.count > 1) {
                            setState(() {
                              widget.cartproduct.count--;
                              print(widget.cartproduct.count);
                            });
                          }

                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0,0,0,0),
                      child: Text("${widget.cartproduct.count}"),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0,0,0,0),

                        child: IconButton(icon: Icon(Icons.add_circle_outline_sharp),
                        onPressed: ()=> setState(()=> widget.cartproduct.count++))
                    ),
                  ],
                ),
    */
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text("Count: "),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0,0,0,0),
                        child: Text("${widget.cartproduct.count}"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("\$${widget.cartproduct.price}",style: TextStyle(
                        decoration:TextDecoration.lineThrough,
                      ),
                      ),
                      SizedBox(width: 15,),
                      Text("\$${widget.cartproduct.price}",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.keremColor,
                      ),),

                    ],
                  ),
                ],
              ),
            ),
            //SizedBox(height: 40,),
            Row(
              children: [
                Text("Distributor: "),
                Text("${widget.product.distributor}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
class All_Cards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: CartList.length,
        itemBuilder: (context, index){
          return Cart_Card(cartproduct: CartList[index],);
        });
  }
}

class cartProduct{
  String title;
  String color;
  double size;
  double price;
  String distributor;
  int count;

  cartProduct(this.title,this.price,this.color,this.distributor,this.size,this.count);
}
