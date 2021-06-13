import 'package:cs310_week5_app/routes/account.dart';
import 'package:flutter/material.dart';
import '../http.dart';
import '../orders/refundpage.dart';
import 'orders.dart';

class OrdersPage extends StatefulWidget {
  OrdersPage({Key key, this.Products, this.order}) : super(key: key);

  List<OrderAtt> Products;
  Order order;

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>{
  @override

  Future<void> refund(int oid) async {
    var result = await http_post("api/refund", {
      "oid": oid,
    });
    if(result.ok)
    {
      //print(result.data);
      if(result.data['message'] == 'OK')
      {
        print("Successfully asked for refund");
      }
      else
        print(result.data['message']);
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
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
                "Order Number",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20,),

              Text(
                widget.Products[0].name,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 30,),

              TextButton(




                onPressed: () {
                  refund(widget.order.oid);
                },
                child: Text(
                "REFUND",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,

                ),
              ),



              ),





            ],
          ),
        ),
      ),
    );

  }
}

