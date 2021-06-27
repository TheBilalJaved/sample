import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ivoting/Screens/SignUp/SignUp.dart';
import 'package:ivoting/Screens/UserDashboard/UserDashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _passwordVisible = false;

  TextEditingController _userEmail = TextEditingController();
  TextEditingController _userPass = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _userLoginPressed = true;
  bool _adminLoginPressed = false;

  bool _userContainerVisible = true;
  bool _adminContainerVisible = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        // backgroundColor: mainColorShade,
        body: Form(
          key: _formKey,
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: ListView(children: [
              Center(
                  child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/logo.png"))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "LOGIN",
                      style: TextStyle(
                          // color: slider1textColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // row for role base access
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _userContainerVisible = true;
                                _adminContainerVisible = false;
                                _userLoginPressed = true;
                                _adminLoginPressed = false;
                              });
                            },
                            child: Text("User Login",
                                style: _userLoginPressed
                                    ? TextStyle(color: Colors.blue)
                                    : TextStyle(color: Colors.grey))),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _userContainerVisible = false;
                              _adminContainerVisible = true;
                              _userLoginPressed = false;
                              _adminLoginPressed = true;
                            });
                          },
                          child: Text(
                            "Admin Login",
                            style: _adminLoginPressed
                                ? TextStyle(color: Colors.blue)
                                : TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),

                    //Admin Login Container
                    Visibility(
                      // maintainSize: true,
                      // maintainAnimation: true,
                      // maintainState: true,
                      visible: _adminContainerVisible,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Email cannot be empty";
                                  } else if (!value.contains("@")) {
                                    return "Please enter a valid email address";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _userEmail,
                                decoration: InputDecoration(
                                  labelText: "Enter Email",
                                  fillColor: Colors.white,
                                  // labelStyle: TextStyle(color: slider1textColor),
                                  focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        // color: slider1textColor,
                                        ),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      )),
                                  focusedErrorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          // color: slider1textColor,
                                          )),
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
                            //Password Textfield
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              controller: _userPass,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                labelText: "Enter Password",
                                fillColor: Colors.white,
                                // labelStyle: TextStyle(color: slider1textColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      // color: slider1textColor,
                                      ),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        // color: slider1textColor,
                                        )),
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      // color: slider1textColor,
                                      ),
                                ),
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
                              ),
                            ),
                            //Login Button
                            Container(
                              margin: EdgeInsets.only(top: 50),
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
                                    child: Text("Login as Admin"),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserDashboardScreen()));
                                      if (_formKey.currentState!.validate()) {
                                        // _loginfunction();

                                      }
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //user Login Container
                    Visibility(
                      // maintainSize: true,
                      // maintainAnimation: true,
                      // maintainState: true,
                      visible: _userContainerVisible,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Email cannot be empty";
                                  } else if (!value.contains("@")) {
                                    return "Please enter a valid email address";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _userEmail,
                                decoration: InputDecoration(
                                  labelText: "Enter Email",
                                  fillColor: Colors.white,
                                  // labelStyle: TextStyle(color: slider1textColor),
                                  focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        // color: slider1textColor,
                                        ),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      )),
                                  focusedErrorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          // color: slider1textColor,
                                          )),
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
                            //Password Textfield
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              controller: _userPass,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                labelText: "Enter Password",
                                fillColor: Colors.white,
                                // labelStyle: TextStyle(color: slider1textColor),
                                focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      // color: slider1textColor,
                                      ),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                        // color: slider1textColor,
                                        )),
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      // color: slider1textColor,
                                      ),
                                ),
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
                              ),
                            ),
                            //Login Button
                            Container(
                              margin: EdgeInsets.only(top: 50),
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
                                    child: Text("Login"),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _loginfunction();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Dont have an Account? "),
                        InkWell(
                          child: Text(
                            "SIGN UP",
                            // style: TextStyle(color: slider1textColor),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              )),
            ]),
          ),
        ),
      ),
    );
  }

  _loginfunction() async {
    setState(() {});
    try {
      EasyLoading.show(status: 'loading...');

      dynamic result = await _auth.signInWithEmailAndPassword(
          email: _userEmail.text.toString().trim(),
          password: _userPass.text.toString());
      // if (result != null) {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => Dashboard()));
      //   EasyLoading.dismiss();
      // }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      // showAlertDialog(context, e.message, "Login Failed");
    }
  }
}
