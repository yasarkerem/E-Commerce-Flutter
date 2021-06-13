import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cs310_week5_app/Product.dart';

import 'widget_test.dart';

main(){
  test("One should be one",(){
    //Arrange
    int expectednumber = 1;

    //ACT
    expectednumber++;

    //assert
    expect(expectednumber,2);


  });
  test("IT SHOULD FAIL",(){
    //Arrange
    Product testproduct;

    //ACT

    //assert
    expect(testproduct,"testproduct");


  });

  test("IT SHOULD PASS",(){
    //Arrange
    Product testproduct;
    String testprodduct = Hermonia;

    //ACT

    //assert
    expect(testprodduct,Hermonia );


  });

  test("IT SHOULD FAIL",(){
    //Arrange
    Product testproduct;
    Product product0 = Product(
        id: 1,
        title: "Office Code",
        price: 234,
        size: 12,
        description: dummyText,
        image: "assets/kero.jpg",
        color: Color(0x7052AE3D));
    Product productcopy = Product(
        id: 1,
        title: "Office Code",
        price: 234,
        size: 12,
        description: dummyText,
        image: "assets/kero.jpg",
        color: Color(0x70AE3D77));
    Product productcopy1 = Product(
        id: 1,
        title: "Office Code",
        price: 234,
        size: 12,
        description: dummyText,
        image: "assets/kero.jpg",
        color: Color(0x700A2F53));
    Product productcopy2 = Product(
        id: 1,
        title: "Office Code",
        price: 234,
        size: 12,
        description: dummyText,
        image: "assets/kero.jpg",
        color: Color(0x70031268));
    Product productcopy3 = Product(
        id: 1,
        title: "Office Code",
        price: 234,
        size: 12,
        description: dummyText,
        image: "assets/kero.jpg",
        color: Color(0x70000000));
    String Message = "Is it valid?";

    //ACT

    //assert
    expect(testproduct,"testproduct",skip: {Message, testproduct });


  });

  test("IT SHOULD PASS",(){
    //Arrange
    Product testproduct;

    //ACT

    //assert
    expect(testproduct,testproduct );


  });

  test("IT SHOULD FAIL",(){
    //Arrange
    Product testproduct = Product(
        id: 10,
        title: "Office Code",
        price: 234,
        size: 12,
        description: dummyText,
        image: "assets/kero.jpg",
        color: Color(0xFF3D82AE));
    Product test2product = Product(
        id: 1,
        title: "Office Code",
        price: 234,
        size: 12,
        description: dummyText,
        image: "assets/kero.jpg",
        color: Color(0xFF3D82AE));

    //ACT

    //assert
    expect(testproduct,test2product);


  });

  test("Test for the incrementing function",(){
    //Arrange
    int a = 8;
    int b = increment(a);

    //ACT

    //assert
    expect(b,9 );


  });

  test("Test for the decrement function",(){
    //Arrange
    int a = 8;
    int b = decrement(a);

    //ACT

    //assert
    expect(b,7 );


  });
  test("Test for of the function (+ and -) and should return true",(){
    //Arrange
    int a = 8;
    int b = decrement(a);
    int c = 8;
    int d = increment(c);

    //ACT

    //assert
    expect(c,9 );

    //ACT

    //assert
    expect(b,7 );


  });
  test("Number is expected",(){
    //Arrange
    var largenm = 208593045809502591;

    //ACT
    largenm++;

    //assert
    expect(largenm,208593045809502592);


  });
  test("IT SHOULD FAIL",(){
    //Arrange
    Product product0 = Product(
        id: 1,
        title: "Office Code",
        price: 234,
        size: 12,
        description: dummyText,
        image: "assets/kero.jpg",
        color: Color(0x7052AE3D));
    Product productcopy = Product(
        id: 1,
        title: "Office Code",
        price: 234,
        size: 12,
        description: dummyText,
        image: "assets/kero.jpg",
        color: Color(0x7052AE3D));

    //ACT

    //assert
    expect(product0,productcopy);
    print("It should not fail");




  });

  test("Number is expected",(){
    //Arrange
    int exp = 1;

    //ACT
    exp++;

    //assert
    expect(exp,2);


  });




}