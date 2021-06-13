import 'package:cs310_week5_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/Product.dart';

class ColorAndSize extends StatelessWidget {
  const ColorAndSize({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Color"),
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
                  items: ["blackaaa","andaaa","yellow","black","and","white"]
                      .map((label) => DropdownMenuItem<String>(
                      child: Text(label), value: label))
                      .toList(),
                  onSaved: (value) {
                    //  accountType = value;
                  },
                  onChanged: (value) {
                    //  accountType = value;
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Size"),
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
                  items: ["35","36","37","38","39","40","41","42","43","44","45"]
                      .map((label) => DropdownMenuItem<String>(
                      child: Text(label), value: label))
                      .toList(),
                  onSaved: (value) {
                  //  accountType = value;
                  },
                  onChanged: (value) {
                  //  accountType = value;
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
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorDot({
    Key key,
    this.color,
    // by default isSelected is false
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 5,
        right: 10,
      ),
      padding: EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
