import 'package:cs310_week5_app/utils/dimension.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/http.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int attemptCount;
  String mail;
  String pass;
  String pass2;
  String fullName;
  String accountType;
  String response = "";
  final _formKey = GlobalKey<FormState>();

  Future<void> signUpUser() async {
    var result = await http_post("register", {
      "fullname": fullName,
      "email": mail,
      "password": pass,
      "confirmpassword": pass2,
      "types": accountType
    });
    if(result.ok)
      {
        setState(() {
          response = result.data['message'];
        });
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
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Container(
          // decoration: BoxDecoration(

 //             image: DecorationImage(
 //               image: NetworkImage("https://wallpaperaccess.com/full/2912973.jpg"),
            //              fit: BoxFit.cover,

          child: Padding(
            padding: Dimen.regularPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                                hintText: 'E-mail',
                                //labelText: 'Username',
                                labelStyle: kLabelLightTextStyle,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.primary),
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
                                hintText: 'Full Name',
                                //labelText: 'Username',
                                labelStyle: kLabelLightTextStyle,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.primary),
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
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your Full Name';
                                }

                                return null;
                              },
                              onSaved: (String value) {
                                fullName = value;
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
                                hintText: 'Password',
                                //labelText: 'Username',
                                labelStyle: kLabelLightTextStyle,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.primary),
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
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                pass = value;
                              },
                            ),
                          ),
                        ]
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
                                    hintText: 'Password (Repeat)',
                                    //labelText: 's',
                                    labelStyle: kLabelLightTextStyle,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: AppColors.primary),
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
                                  validator:
                                      (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your password';

                                    }
                                    if (value.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    pass2 = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: DropdownButtonFormField(
                              dropdownColor: Colors.white,
                                iconEnabledColor: Colors.white,
                                decoration: InputDecoration(
                                  labelText: "Account Type",
                                  icon: Icon(Icons.person),
                                  filled: true,
                                  fillColor: AppColors.secondary,
                                  labelStyle: kLabelLightTextStyle,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.secondary),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                value: accountType,
                                items: ["customer", "product manager", "sales manager"]
                                    .map((label) => DropdownMenuItem<String>(
                                        child: Text(label), value: label))
                                    .toList(),
                                onSaved: (value) {
                                  accountType = value;
                                },
                                onChanged: (value) {
                                  accountType = value;
                                }),
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
                                  if (accountType == null) {
                                    showAlertDialog(
                                        "Error", 'Please select an account type');
                                  }
                                  if (pass != pass2) {
                                    showAlertDialog(
                                        "Error", 'Passwords must match');
                                  } else {
                                    signUpUser();
                                  }
                                  //
                                  setState(() {
                                    attemptCount += 1;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Logging in')));
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Sign Up',
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
        ),
      ),
    );
  }
}
