import 'package:cs310_week5_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/utils/Cart_Components/old_cart_card.dart';
import 'package:cs310_week5_app/utils/Home_Components/appBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../http.dart';

class ShopCart extends StatefulWidget {
  @override
  _ShopCartState createState() => _ShopCartState();
}

class _ShopCartState extends State<ShopCart> {

  int userId;
  bool isLoggedIn = false;
  var user;
  List<CartProduct> products = [];
  var sum = 0.0;

  setIsLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getInt('userID');
    setState(() {
      if (id == 0) {
        isLoggedIn = false;
        //await preferences.setBool('isLoggedIn', true);
      }
      else {
        isLoggedIn = true;
        userId = id;
        //await preferences.setBool('isLoggedIn', false);
      }
    });
  }

  void initState() {
    super.initState();
    setIsLoggedIn();
    getCart();
  }

  @override
  int _selectedIndex = 2;
  List routes = ["/", "/search", "/shopcart", "/account"];

  void _onItemTapped(int index) {
    setState(() {
      int oldIndex = _selectedIndex;
      _selectedIndex = index;
      if (_selectedIndex != oldIndex) {
        Navigator.popAndPushNamed(context, routes[index]);
      }
    });
  }

  Future<void> getCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getInt('userID');
    var queryParameters = {
      'uid': '$id',
    };

    var result = await http_getWparams("api/showcard", queryParameters);
    if(result.ok)
    {
      setState(() {
        if(result.data['message'] == 'OK')
        {
          var in_products = result.data['products'] as List<dynamic>;
          in_products.forEach((in_product){
            products.add(CartProduct(
              paid: in_product['paid'],
              name: in_product['name'],
              color: in_product['color'],
              price: in_product['price'],
              size: in_product['size'],
              distributor: in_product['distributor'],
              quantity: in_product['quantity'],
              discount_rate: in_product['discount_rate'],
              image: in_product['picture'],
            )
            );
          });
          var i;
          for (i = 0; i < products.length; i++) {
            sum += products[i].price*(100-products[i].discount_rate)/100.0 * products[i].quantity;
          }
        }
        else {
          print(result.data['message']);
        }
      });
    }
  }

  Future<void> deleteItem(int paid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getInt('userID');
    var result = await http_put("api/removeproductfromcard", {
      "uid": id,
      "paid": paid
    });
    if(result.ok)
    {
      print(result.data['message']);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBAR(context),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: products.length == 0 ? Center(child: Text("Cart is empty"))
                    : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: ListTile(
                          leading: Image.network(products[index].image,width: 50,height: 100,),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 200,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(products[index].name,
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(icon: Icon(Icons.delete), onPressed: (){
                                deleteItem(products[index].paid);
                                Navigator.popAndPushNamed(context, "/shopcart");
                              })

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
                                        child: Text("${products[index].size}"),
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(10,0,0,0),
                                        child: Text("Color: "),
                                      ),
                                      Padding(padding: EdgeInsets.fromLTRB(0,0,0,0),
                                        child: Text("${products[index].color}"),
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
                                          child: Text("${products[index].quantity}"),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("\$${products[index].price * products[index].quantity}",style: TextStyle(
                                          decoration:TextDecoration.lineThrough,
                                        ),
                                        ),
                                        SizedBox(width: 15,),
                                        Text("\$${products[index].quantity * products[index].price*(100-products[index].discount_rate)/100}",style: TextStyle(
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
                                  Text("${products[index].distributor}"),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                ),
              ),
            ),
            Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      /* Text("\$199.9",style: TextStyle(
                          decoration:TextDecoration.lineThrough,
                        fontSize: 16,

                      ),
                      ),
                      SizedBox(width: 15,),
                       */
                      Text("\$$sum",style: TextStyle(
                        fontSize: 24,
                      ),),
                    ],
                  ),
                  RaisedButton(onPressed: (){
                    return showDialog<void>(context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Onaylama"),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text("Onayladı"),
                                  Text("Nerden baksan iyi alışveriş"),
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
                  },
                  child: Text("Accept"),)
                ],
              ),
            ),
          ],
        ),
      ),


      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.house_sharp, color: Colors.white),
              label: "Home", backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.search, color: Colors.white),
              label: "Categories", backgroundColor: Colors.orange),
          //BottomNavigationBarItem(icon: Icon(Icons.favorite,color: Colors.white),
          //   label: "Favorites", backgroundColor: Colors.yellow),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              label: "Cart", backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_sharp, color: Colors.white),
              label: "Account", backgroundColor: Colors.blue),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,

        onTap: _onItemTapped,
      ),

    );
  }

  AppBar appBAR(BuildContext context) {
    if (isLoggedIn == true) {
      return AppBar(
        backgroundColor: AppColors.ardaColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Cart",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        ),
      );
    }
    else {
      return AppBar(
        backgroundColor: AppColors.ardaColor,
        automaticallyImplyLeading: false,
        title: Text("Cart",style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.zero,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  "Register", style: TextStyle(
                  color: Colors.white,
                ),
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.only(right: 10.0),
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
      );
    }
  }
}


class CartProduct {
  String name;
  String color;
  int price;
  String size;
  String distributor;
  int quantity;
  int discount_rate;
  int paid;
  String image;



  CartProduct({this.name, this.color, this.price, this.size, this.distributor, this.quantity, this.discount_rate, this.paid, this.image});

}

