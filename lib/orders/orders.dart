import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../http.dart';
import '../orders/orderspage.dart';

class Orders extends StatefulWidget{
  Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders>{
  @override

  List<Order> orders = [];
  List<OrderAtt> orderatts = [];

  void initState() {
    super.initState();
    this.getOrders();
    this.getOrderAtts();
  }

  Future<void> getOrders() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getInt('userID');
    var queryParameters = {
      'uid': '$id',
    };

    var result = await http_getWparams("api/showorders", queryParameters);
    if(result.ok)
    {
      setState(() {
        if(result.data['message'] == 'OK')
        {
          var in_orders = result.data['products'] as List<dynamic>;
          in_orders.forEach((in_order){
            orders.add(Order(
                oid: in_order["oid"],
                status: in_order["status"],
                uid: in_order["uid"],
                date: in_order["date"],
                address: in_order["address"],
            ));
          });
        }
        else {
          print(result.data['message']);
        }
      });
    }
  }

  Future<void> getOrderAtts() async {
    var result = await http_post("api/showorderatts", {});
    if(result.ok)
    {
      //print(result.data);
      if(result.data['message'] == 'OK')
      {
        var in_orderatts = result.data['products'] as List<dynamic>;
        in_orderatts.forEach((in_orderatt){
          orderatts.add(OrderAtt(
              oaid: in_orderatt["oaid"],
              oid: in_orderatt["oid"],
              color: in_orderatt["color"],
              quantity: in_orderatt["quantity"],
              size: in_orderatt["size"],
              price: in_orderatt["price"],
              name: in_orderatt["name"],
              distributor: in_orderatt["distributor"],
              pid: in_orderatt["pid"],
              image: in_orderatt["image"],
          ));
        });
      }
    }
  }

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
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Orders',
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
      body: ListView.separated(
          itemCount: orders.length,


          itemBuilder: (context, index) {
            return ListTile(

              title: Text(
                'Order number ${orders[index].oid}',
                style: TextStyle(
                  color: Colors.indigo,
                ),
              ),
              subtitle: Text('${orders[index].date} / ${orders[index].status}'),
              onTap: () {
                List<OrderAtt> products = [];
                var i;
                for (i = 0; i < orderatts.length; i++)
                  {
                    if (orders[index].oid == orderatts[i].oid)
                      {
                        products.add(orderatts[i]);
                      }
                  }
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        OrdersPage(
                          order: orders[index],
                          Products: products,
                        )));
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

class Order {
  int oid;
  int uid;
  String status;
  String address;
  String date;

  Order({this.oid, this.uid, this.status, this.address, this.date});
}

class OrderAtt {
  int oaid;
  int oid;
  String color;
  int quantity;
  String size;
  var price;
  String name;
  String distributor;
  int pid;
  String image;

  OrderAtt({this.oaid, this.oid, this.color, this.quantity, this.size, this.price, this.name, this.distributor, this.pid, this.image});
}

