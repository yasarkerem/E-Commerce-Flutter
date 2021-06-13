import 'package:cs310_week5_app/routes/review.dart';
import 'package:flutter/material.dart';

import 'package:cs310_week5_app/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../http.dart';
import '../color.dart';
import 'old_add_to_cart.dart';
import 'old_colorsize.dart';
import 'old_counter.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({Key key, this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override

  List<String> colors = [];
  var setColor = "";
  List<String> sizes = [];
  var setSize = "";
  List<String> distributors = [];
  var setDistributor = "";
  List<ProductDetailInstance> stocks = [];
  var sum = -1;
  var warranty = 0;
  var numOfItems = 1;

  void initState() {
    super.initState();
    this.getColors();
    this.getSizes();
    this.getDistributors();
    this.getStocks();
  }

  Future<void> getColors() async {
    var queryParameters = {
      'pid': '${widget.product.id}',
    };

    var result = await http_getWparams("api/productcolor", queryParameters);
    if(result.ok)
    {
      setState(() {
        if(result.data['message'] == 'OK')
        {
          var in_colors = result.data['products'] as List<dynamic>;
            in_colors.forEach((in_color){
            colors.add(
              in_color["color"]
            );
          });
        }
        else {
          print(result.data['message']);
        }
      });
    }
  }

  Future<void> getSizes() async {
    var queryParameters = {
      'pid': '${widget.product.id}',
    };

    var result = await http_getWparams("api/productsize", queryParameters);
    if(result.ok)
    {
      setState(() {
        if(result.data['message'] == 'OK')
        {
          var in_sizes = result.data['products'] as List<dynamic>;
          in_sizes.forEach((in_size){
            sizes.add(
                in_size["size"]
            );
          });
        }
        else {
          print(result.data['message']);
        }
      });
    }
  }

  Future<void> getDistributors() async {
    var queryParameters = {
      'pid': '${widget.product.id}',
    };

    var result = await http_getWparams("api/productdistributor", queryParameters);
    if(result.ok)
    {
      setState(() {
        if(result.data['message'] == 'OK')
        {
          var in_distributors = result.data['products'] as List<dynamic>;
          in_distributors.forEach((in_distributor){
            distributors.add(
                in_distributor["distributor"]
            );
          });
        }
        else {
          print(result.data['message']);
        }
      });
    }
  }

  Future<void> getStocks() async {
    var queryParameters = {
      'pid': '${widget.product.id}',
    };

    var result = await http_getWparams("api/productstock", queryParameters);
    if(result.ok)
    {
      setState(() {
        if(result.data['message'] == 'OK')
        {
          var in_stocks = result.data['products'] as List<dynamic>;
          in_stocks.forEach((in_stock){
            stocks.add(ProductDetailInstance(
              color: in_stock['color'],
              stock: in_stock['stock'],
              size: in_stock['size'],
              distributor: in_stock['distributor'],
              warranty: in_stock['warranty'],
            )
            );
          });
        }
        else {
          print(result.data['message']);
        }
      });
    }
  }

  Future<void> addToCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getInt('userID');

    var result = await http_post("api/addtocard", {
      "pid": widget.product.id,
      "uid": id,
      "color": setColor,
      "size": setSize,
      "distributor": setDistributor,
      "stock": 0,
      "quantity" : numOfItems,
    });
    if(result.ok)
    {
      setState(() {
        print(result.data['message']);
      });
    }
  }

  void updateStock() {
    var i;

    setState(() {
      sum = 0;
    });

    for(i = 0; i < stocks.length; i++){
      if (stocks[i].color.contains(setColor) && stocks[i].distributor.contains(setDistributor) && stocks[i].size.contains(setSize)){
        setState(() {
          sum += stocks[i].stock;
        });
      }
    }

  }

  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: 20,
                    right: 20,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                  Row(
                  children: <Widget>[
                  Expanded(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Text("Color"),
                      DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: "Color",
                            filled: true,
                            fillColor: AppColors.keremColor,
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: AppColors.keremColor),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          //value: accountType,
                          items: colors
                              .map((label) => DropdownMenuItem<String>(
                              child: Text(label), value: label))
                              .toList(),
                          onSaved: (value) {
                            setState(() {
                              setColor = value;
                              updateStock();
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              setColor = value;
                              updateStock();
                            });
                          }),
/*
              Row(
                children: <Widget>[
                  ColorDot(
                    color: Color(0xFF356C95),
                    isSelected: true,
                  ),
                  ColorDot(color: Color(0xFFF8C078)
                  ,isSelected: true),
                  ColorDot(color: Color(0xFFA29B9B)),
                ],
              ),
              */
                    ],
                  ),
                ),
                SizedBox(width: 50,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Text("Size"),
                      DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: "Size",
                            filled: true,
                            fillColor: AppColors.keremColor,
                            border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: AppColors.keremColor),
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          //value: accountType,
                          items: sizes
                              .map((label) => DropdownMenuItem<String>(
                              child: Text(label), value: label))
                              .toList(),
                          onSaved: (value) {
                            setState(() {
                              setSize = value;
                              updateStock();
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              setSize = value;
                              updateStock();
                            });
                          }),
                    ],
                  ),
                  /*
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.blue),
              children: [
                TextSpan(text: "Size\n"),
                TextSpan(
                  text: "${product.size} cm",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold),
                )

              ],
            ),
          ),
          */
                ),

              ],
            ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //Text("Distributor"),
                            DropdownButtonFormField(
                                dropdownColor: Colors.white,
                                isExpanded: true,
                                decoration: InputDecoration(

                                  labelText: "Distributor",
                                  filled: true,
                                  fillColor: AppColors.keremColor,
                                  border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: AppColors.keremColor),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                //value: accountType,
                                items: distributors
                                    .map((label) => DropdownMenuItem<String>(
                                    child: Text(label), value: label))
                                    .toList(),
                                onSaved: (value) {
                                  setState(() {
                                    setDistributor = value;
                                    updateStock();
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    setDistributor = value;
                                    updateStock();
                                  });
                                }),
/*
              Row(
                children: <Widget>[
                  ColorDot(
                    color: Color(0xFF356C95),
                    isSelected: true,
                  ),
                  ColorDot(color: Color(0xFFF8C078)
                  ,isSelected: true),
                  ColorDot(color: Color(0xFFA29B9B)),
                ],
              ),
              */
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Description(product: widget.product),
                      SizedBox(height: 10),
                      //Text("$sum"),
                      if (sum == -1)
                        Text("Please enter infos")

                      else if(sum == 0)
                        Text("Out of stock")
                      else
                        Text("Stock: ${sum}"),
                      SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Row(
        children: <Widget>[
          buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          // if our item is less  then 10 then  it shows 01 02 like that
                          numOfItems.toString().padLeft(2, "0"),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      buildOutlineButton(
                          icon: Icons.add,
                          press: () {
                            setState(() {
                              numOfItems++;
                            });
                          }),
                    ],
                  ),
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
        ),
                      SizedBox(height: 10),
        Padding(
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
                    color: widget.product.color,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.add_shopping_cart),

                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ReviewPage(
                            product: widget.product,
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
                      if (sum <= 0 || numOfItems > sum){
                        return showDialog<void>(context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Stock Problem"),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text("Out of Stock"),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(child: Text("OK"),
                                    onPressed: (){
                                      Navigator.pop(context, "OK");
                                    },),
                                ],
                              );
                            });
                      }
                      else {
                        addToCart();
                        return showDialog<void>(context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("Confirmation"),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text("Product has been added to the cart"),
                                      Text("Will you continue shopping?"),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(child: Text("No"),
                                    onPressed: (){
                                     //Navigator.pop(context, "Cancel");
                                      Navigator.popAndPushNamed(context, "/shopcart");
                                    },),
                                  TextButton(child: Text("Yes"),
                                    onPressed: (){
                                      //Navigator.pop(context, "Yes");
                                      Navigator.popAndPushNamed(context, "/");
                                    },),
                                ],
                              );
                            });
                      }
                    },
                    child: Text(
                      "Add to Cart ${widget.product.title}".toUpperCase(),
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
        )
                    ],
                  ),
                ),
                ProductTitleWithImage(product: widget.product)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProductDetailInstance {
  String color;
  int stock;
  String size;
  String distributor;
  int warranty;

  ProductDetailInstance({this.color, this.stock, this.size, this.distributor, this.warranty});

}

SizedBox buildOutlineButton({IconData icon, Function press}) {
  return SizedBox(
    width: 40,
    height: 32,
    child: OutlineButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      onPressed: press,
      child: Icon(icon),
    ),
  );
}
