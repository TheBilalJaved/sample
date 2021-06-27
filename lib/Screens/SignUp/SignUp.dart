import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ivoting/Screens/SignIn/SignIn.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userEmail = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _userPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var _passwordVisible = false;
  var _confirmPasswordVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //databse refrence
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: mainColorShade,
      body: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: ListView(shrinkWrap: true, children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/logo.png"))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "SIGN UP",
                          style: TextStyle(
                              // color: slider1textColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _userName,
                                  decoration: InputDecoration(
                                    labelText: "Full Name",
                                    fillColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.black),
                                    focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          // color: slider1textColor,
                                          ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            // color: slider1textColor,
                                            )),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          // color: slider1textColor,
                                          ),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email cannot be empty";
                                    } else if (!value.contains("@")) {
                                      return "Please enter a valid email address";
                                    }
                                    return null;
                                  },
                                  controller: _userEmail,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    fillColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.black),
                                    focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          // color: slider1textColor,
                                          ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            // color: slider1textColor,
                                            )),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          // color: slider1textColor,
                                          ),
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: _userPassword,
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        // color: slider1textColor,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    labelText: "Password",
                                    fillColor: Colors.white,
                                    labelStyle: TextStyle(color: Colors.black),
                                    focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          // color: slider1textColor,
                                          ),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            // color: slider1textColor,
                                            )),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          // color: slider1textColor,
                                          ),
                                    ),
                                  )),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      _userPassword.text != value) {
                                    return "Password does not match";
                                  }
                                  return null;
                                },
                                controller: _confirmPassword,
                                obscureText: !_confirmPasswordVisible,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _confirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      // color: slider1textColor,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _confirmPasswordVisible =
                                            !_confirmPasswordVisible;
                                      });
                                    },
                                  ),
                                  labelText: "Confirm Password",
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        // color: slider1textColor,
                                        ),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          // color: slider1textColor,
                                          )),
                                  errorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        // color: slider1textColor,
                                        ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          // primary: slider1textColor,
                                          textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800)),
                                      child: Text("Sign up"),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _signUpUser();
                                          print('signup Pressed');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an Account? "),
                            InkWell(
                              child: Text(
                                "LOGIN",
                                // style: TextStyle(color: slider1textColor),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _signUpUser() async {
    try {
      EasyLoading.show(status: 'loading...');

      await _auth
          .createUserWithEmailAndPassword(
              email: _userEmail.text.toString().trim(),
              password: _userPassword.text.toString())
          .then((user) async {
        print(user);
        var userDetail = {
          "name": _userName.text.toString(),
          "email": _userEmail.text.toString().trim(),
          "password": _userPassword.text.toString(),
          "timestamp": Timestamp.now()
        };
        await db
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .set(userDetail)
            .then((value) {
          EasyLoading.dismiss();
          // Navigator.push(this.context,
          //     MaterialPageRoute(builder: (context) => Dashboard()));
          print("user added");
        });
      });
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      // showAlertDialog(context, e.message, "Sign up Failed");
      print(e);
    }
  }
}
