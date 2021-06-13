import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/dimension.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/http.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool logSuccess = false;
  int attemptCount;
  String mail;
  String pass;
  String response = "";
  final _formKey = GlobalKey<FormState>();

  Future<void> loginUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var result = await http_post("login", {
      "email": mail,
      "password": pass,
    });
    if(result.ok)
    {
      //print(result.data);
      if(result.data['message'] == 'OK')
      {
        final userdata = new Map<String, dynamic>.from(result.data['user'][0]);
        await preferences.setInt('userID', userdata['id']);
        await preferences.setString('username', userdata['name']);
        setState((){
          response = userdata['name'];
          logSuccess = true;
          Navigator.pushNamed(context, "/");
        });
      }
      else
        {
          setState((){
            response = result.data['message'];
          });
        }
      print(response);
    }
  }

  Future<void> showAlertDialog(String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //User must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override





  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$response',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.ardaColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.grey,
   //     decoration: BoxDecoration(
   //         image: DecorationImage(
   //           image: NetworkImage("https://wallpaperaccess.com/full/2912973.jpg"),
   //           fit: BoxFit.cover,
   //         )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding: Dimen.regularPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*
                      Text(
                        "Please, come in!",
                        style: TextStyle(
                          color: AppColors.keremColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 30.0,
                          letterSpacing: -0.7,
                        ),
                      ),
                      */

                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: AppColors.secondary,
                                  filled: true,
                                  labelText: 'E-mail',
                                  //labelText: 'Username',
                                  labelStyle: kLabelLightTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.ardaColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  errorStyle: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your e-mail';
                                  }
                                  if (!EmailValidator.validate(value)) {
                                    return 'The e-mail address is not valid';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  mail = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: AppColors.secondary,
                                  filled: true,
                                  labelText: 'Password',
                                  //labelText: 'Username',
                                  labelStyle: kLabelLightTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.secondary),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  errorStyle: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 3) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  pass = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();

                                      //print('$response');

                                   // Navigator.pushNamed(context, "/");

                                    loginUser();
                                    //showAlertDialog("Action", 'Button clicked');
                                    setState(() {
                                      attemptCount += 1;
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Logging in')));
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Text(
                                    'Login',
                                    style: kButtonDarkTextStyle,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppColors.keremColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
