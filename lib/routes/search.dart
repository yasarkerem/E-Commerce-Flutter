import 'package:cs310_week5_app/Product.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/routes/details_screen.dart';

import '../http.dart';
class search extends StatefulWidget {
  @override
  Search createState() => Search();
}



class Search extends State<search> {
  TextEditingController editingController = TextEditingController();

  List<Product> databaseProducts = [];

  Future<void> getProducts() async {
    var result = await http_get("api/products");
    if(result.ok)
    {
      setState(() {
        if(result.data['message'] == 'OK')
        {
          var in_products = result.data['products'] as List<dynamic>;
          in_products.forEach((in_product){
            databaseProducts.add(Product(
                id: in_product['pid'],
                title: in_product['name'],
                price: in_product['price'],
                rating: in_product['rating'],
                size: 12,
                description: in_product['description'],
                image: "assets/kero.jpg",
                color: Color(0xFF3D82AE))
            );
          });
        }
        else {
          print(result.data['message']);
        }
      });
    }
  }
  @override

  final duplicateItems = ["nike air force","nike air jordan","nike lebron","adidas stan smith","adidas stan smith Star Wars Edition"];
  var items = List<String>();

  @override
  void initState(){
    this.getProducts();
    print(databaseProducts);
    items.addAll(duplicateItems);
    super.initState();
  }
  int _selectedIndex = 1;

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

  void filterSearchResults(String query){

    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);

    if(query.isNotEmpty)
      {
        List<String> dummyListData = List<String>();
        dummySearchList.forEach((item) {
        if(item.contains((query)))
          {
            dummyListData.add(item);
          }
        });
        setState(() {
          items.clear();
          items.addAll(dummyListData);
        });
        return;
      }
    else{
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Column(
          children:<Widget>[

            SizedBox(height:10,),

            TextField(
              onChanged: (value){
                filterSearchResults(value);

              },
              controller: editingController,
              decoration: InputDecoration(
                labelText: "Explore the Products",
                hintText: "Hermonia is the best Shoe Store ",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius:BorderRadius.all(Radius.circular(10))
                )
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder:(context,index)
              {
                return ListTile(
                  title: Text("${items[index]}"),
                );

              })

          ],
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.house_sharp, color: Colors.white),
                label: "Home", backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.white),
                label: "Search", backgroundColor: Colors.orange),
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
        )
    );

  }
}