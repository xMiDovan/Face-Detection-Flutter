// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_final_fields, use_build_context_synchronously, unused_import

import 'package:animate_do/animate_do.dart';
import 'package:face/homepage.dart';
import 'package:flutter/material.dart';
import 'package:face/mainpage.dart';
import 'package:face/api/connect.dart';
import 'package:face/signup.dart';
import 'package:face/userpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _registrationStatus = '';
   Color _registrationStatusColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Login", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),)),
                      SizedBox(height: 20,),
                      FadeInUp(duration: Duration(milliseconds: 1200), child: Text("Login to your account", style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700]
                      ),)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(duration: Duration(milliseconds: 1200), child: makeInput(_emailController, label: "Email")),
                        FadeInUp(duration: Duration(milliseconds: 1300), child: makeInput(_passwordController, label: "Password", obscureText: true)),
                      ],
                    ),
                  ),
                  FadeInUp(duration: Duration(milliseconds: 1400), child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            )
                          ),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                              if (_emailController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty) {
                                    String registrationStatus = await loginUser(
                                    _emailController.text,
                                    _passwordController.text);
                                setState(() {
                                  _registrationStatus = registrationStatus;
                                });
                                // Check if the message contains "successful" and apply green color
                                if (registrationStatus.toLowerCase().contains('successful')) {
                                  setState(() {
                                    _registrationStatusColor = Colors.green;
                                  });
                          
                                  // Clear the text fields
                                  _emailController.clear();
                                  _passwordController.clear();
                          
                                  // Introduce a delay of 2 seconds before navigating to the login page
                                  await Future.delayed(Duration(seconds: 2));
                          
                                  // Navigate to the login page if registration is successful
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyUserPage()),
                                  );
                          
                                  // Clear the registration status after navigating to the login page
                                  setState(() {
                                    _registrationStatus = '';
                                  });
                                }else if(registrationStatus.toLowerCase().contains('admin'))
                                {
                                  setState(() {
                                    _registrationStatusColor = Colors.green;
                                  });
                          
                                  // Clear the text fields
                                  _emailController.clear();
                                  _passwordController.clear();
                          
                                  // Introduce a delay of 2 seconds before navigating to the login page
                                  await Future.delayed(Duration(seconds: 2));
                          
                                  // Navigate to the login page if registration is successful
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyHomePage()),
                                  );
                          
                                  // Clear the registration status after navigating to the login page
                                  setState(() {
                                    _registrationStatus = '';
                                  });
                                }
                                 else {
                                  // If not successful, apply red color
                                  setState(() {
                                    _registrationStatus = 'Email or Password is wrong.';
                                    _registrationStatusColor = Colors.red;
                                    _emailController.clear();
                                    _passwordController.clear();
                                  });
                                }
                              } else{
                                // Show an error message or handle it as per your requirement
                                setState(() {
                                  _registrationStatus = 'Please fill in all fields';
                                  _registrationStatusColor = Colors.red;
                                });
                              }
                            },
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Text("Login", style: TextStyle(
                              fontWeight: FontWeight.w600, 
                              fontSize: 18
                            ),),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _registrationStatus,
                          style: TextStyle(color: _registrationStatusColor),
                        ),
                      ],
                    ),
                  )),
                  FadeInUp(duration: Duration(milliseconds: 1500), child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      Text("Sign up", style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18
                      ),),
                    ],
                  ))
                ],
              ),
            ),
            FadeInUp(duration: Duration(milliseconds: 1200), child: Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover
                )
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget makeInput(TextEditingController controller, {label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),),
        SizedBox(height: 5,),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
          ),
        ),
      ],
    );
  }
}