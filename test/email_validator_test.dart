import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cs310_week5_app/Product.dart';

import 'widget_test.dart';


import 'package:cs310_week5_app/Product.dart';
import 'package:email_validator/email_validator.dart';


void main() {
  test('Empty Email Test', () {
    var result = EmailValidator();
    expect(result, 'Enter Email!');
  });

  test('Invalid Email Test', () {
    var result = EmailValidator();
    expect(result, 'Enter Valid Email!');
  });
  test('Valid Email Test', () {
    var result = EmailValidator.validate('ajay.kumar@nonstopio.com');
    expect(result, null);
  });

  test('Empty Password Test', () {
    var result = EmailValidator.validate('');
    expect(result, 'Enter Password!');
  });

  test('Invalid Password Test', () {
    var result = EmailValidator.validate('123');
    expect(result, 'Password must be more than 6 charater');
  });

  test('Valid Password Test', () {
    var result = EmailValidator.validate('ajay12345');
    expect(result, null);
  });
}