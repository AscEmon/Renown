import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:TrainnigInfo/Controller/LoginController.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<LoginPage> {
  LogInController logInController = Get.find<LogInController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an Account ? ",
                style: TextStyle(color: Colors.white),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.SIGNUP);
                },
                child: Text(
                  "SingUp",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'images/login_bc.jpg',
                  height: Get.height,
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned(
              //     top: 120,
              //     left: Get.width / 2 - 60,
              //     child: ),
              Positioned(
                top: Get.height / 5,
                left: Get.width / 20,
                child: Container(
                  height: 420,
                  width: Get.width / 1.1,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Form(
                      key: logInController.formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Log In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 60),
                            TextFormField(
                              maxLines: 1,
                              controller: logInController.emailLogin,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              decoration: new InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white),
                                suffixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value.trim().isEmpty)
                                  return "Email is Required";
                                else if (!GetUtils.isEmail(value.trim()))
                                  return "Please enter valid email";
                                else
                                  return null;
                              },
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              maxLines: 1,
                              obscureText: true,
                              controller: logInController.passwordLogin,
                              cursorColor: Colors.white,
                              style: TextStyle(color: Colors.white),
                              decoration: new InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.white),
                                suffixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value.trim().isEmpty)
                                  return "Password is Required";
                                else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            RaisedButton(
                              color: Colors.white,
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              onPressed: () {
                                logInController.loginFunction();
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            SizedBox(
                              height: 130,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
