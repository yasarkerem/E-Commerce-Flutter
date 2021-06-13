
import 'package:cs310_week5_app/utils/Review_Components/ratingBar.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/utils/Review_Components/reviewCard.dart';
import '../http.dart';
import '../utils/Review_Components/comratebox.dart';
import 'package:cs310_week5_app/Product.dart';
import 'details_screen.dart';
import 'package:cs310_week5_app/utils/Components/body.dart';
import 'package:cs310_week5_app/utils/Home_Components/body.dart';
import 'home_screen.dart';
class ReviewPage extends StatefulWidget {

  const ReviewPage({
    Key key,
    @required this.product,
    this.yorum,
  }) : super(key: key);

  final Product product;
  final Yorum yorum;

  @override
  _ReviewPageState createState() => _ReviewPageState();
}


class _ReviewPageState extends State<ReviewPage> {

  List<Yorum> databaseReviews = [];
  int a = 0;
  @override

  void initState() {
    super.initState();
    this.getReviews();
  }


  Future<void> getReviews() async {
    var queryParameters = {
      'pid': '${widget.product.id}',
    };

    var result = await http_getWparams("api/getReviews", queryParameters);
    if(result.ok)
    {
      setState(() {
        if(result.data['message'] == 'OK')
        {
          var in_reviews = result.data['reviews'] as List<dynamic>;
          in_reviews.forEach((in_review){
            databaseReviews.add(Yorum(
              username: in_review['name'],
              comment: in_review['comment'],
              indiRating: in_review['rating'],)
            );
          });
        }
        else {
          print(result.data['message']);
        }
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [


            Expanded(
              flex: 1,
              child: Padding(
                  padding: EdgeInsets.all(10),
                child: databaseReviews.length == 0 ? Center(child: Text("There is no comments"))
                    : ListView.builder(
                  itemCount: databaseReviews.length,
                    itemBuilder: (context,index) {
                        return ReviewCard(yorum: databaseReviews[index]);
                    }),

              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                   if(a == 0) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return comRateBox(product: widget.product);
                          });
                    }
                   else{
                     showDialog(
                         context: context,
                         builder: (BuildContext context){
                           return AlertDialog(
                             title: Text("Multiple Comment Error"),
                             content: SingleChildScrollView(
                               child: ListBody(
                                 children: <Widget>[
                                   Text("You cannot make multiple comments"),
                                   Text("You already commented on this product"),
                                 ],
                               ),
                             ),
                             actions: <Widget>[
                               TextButton(child: Text("Ok"),
                                 onPressed: (){
                                   Navigator.pop(context, "Ok");
                                 },),
                             ],
                           );
                         });

                   }
                  },
                  child: Icon(Icons.add),
                ),
              ],
            )
          ],


        ),
      ),


    );
  }
}



class Yorum {
  int indiRating;
  String username;
  String comment;

  Yorum({this.username, this.indiRating, this.comment});

}