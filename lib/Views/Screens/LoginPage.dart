import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TrainnigInfo/Views/Utilities/AppRoutes.dart';
import 'package:TrainnigInfo/Controller/LoginController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:http/http.dart' as http;
import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';

//flag for AdminCheck which is Globally declare
bool adminCheck = false;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LogInController logInController = Get.put(LogInController(
      repository:
          MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));

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
              Positioned(
                top: 60,
                left: Get.width / 2 - 40,
                child: Text(
                  "Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
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
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/Renown_logo.png',
                              height: 100,
                              width: 300,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              maxLines: 1,
                              controller: logInController.emailLogin,
                              cursorColor: Colors.white,
                              keyboardType: TextInputType.emailAddress,
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
                                else if (value.length < 6)
                                  return "password must be at least 6 characters";
                                else
                                  return null;
                              },
                            ),
                            Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.white),
                              child: CheckboxListTile(
                                activeColor: Colors.white,
                                checkColor: Colors.green,
                                title: Text(
                                  "Admin",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                value: adminCheck ?? false,
                                onChanged: (newValue) {
                                  setState(
                                    () {
                                      adminCheck = newValue;
                                    },
                                  );
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
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
                                logInController.loginFunction(
                                    adminCheck, _formKey);
                                FocusScope.of(context).unfocus();
                              },
                            ),
                            SizedBox(
                              height: 150,
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
