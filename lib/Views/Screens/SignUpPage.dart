import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TrainnigInfo/Controller/SignUpController.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:http/http.dart' as http;
import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController signUpController = Get.put(SignUpController(
      repository:
          MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("images/login_bc.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    height: Get.height / 1.22,
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
                    child: Form(
                      key: signUpController.formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 420,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/Renown_logo.png',
                                  height: 100,
                                  width: 300,
                                  fit: BoxFit.contain,
                                ),
                                // Text(
                                //   "Sign Up",
                                //   style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 32,
                                //       fontWeight: FontWeight.bold),
                                // ),

                                TextFormField(
                                  maxLines: 1,
                                  controller:
                                      signUpController.nameControllerSingUp,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  decoration: new InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(color: Colors.white),
                                    suffixIcon: Icon(
                                      Icons.account_box,
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
                                      return "Name is Required";
                                    else
                                      return null;
                                  },
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  maxLines: 1,
                                  controller:
                                      signUpController.emailControllerSingUp,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.emailAddress,
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
                                // SizedBox(height: 8),
                                // TextFormField(
                                //   maxLines: 1,
                                //   controller:
                                //       signUpController.phoneControllerSingUp,
                                //   cursorColor: Colors.white,
                                //   keyboardType: TextInputType.phone,
                                //   style: TextStyle(color: Colors.white),
                                //   decoration: new InputDecoration(
                                //     labelText: 'Phone Number',
                                //     labelStyle: TextStyle(color: Colors.white),
                                //     suffixIcon: Icon(
                                //       Icons.phone,
                                //       color: Colors.white,
                                //     ),
                                //     focusedBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(10.0),
                                //       borderSide: BorderSide(
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //     enabledBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(10.0),
                                //       borderSide: BorderSide(
                                //         color: Colors.white,
                                //         width: 1.0,
                                //       ),
                                //     ),
                                //   ),
                                //   validator: (value) {
                                //     if (value.trim().isEmpty)
                                //       return "Phone Number is Required";
                                //     else
                                //       return null;
                                //   },
                                // ),
                                SizedBox(height: 8),
                                TextFormField(
                                  maxLines: 1,
                                  obscureText: true,
                                  controller:
                                      signUpController.passwordControllerSingUp,
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
                                SizedBox(height: 8),
                                TextFormField(
                                  maxLines: 1,
                                  obscureText: true,
                                  controller: signUpController
                                      .confirmPasswordControllerSingUp,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  decoration: new InputDecoration(
                                    labelText: 'Confirm Password',
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
                                      return "Confirm Password is Required";
                                    else if (!value.contains(signUpController
                                        .passwordControllerSingUp.text))
                                      return "Password is not match";
                                    else
                                      return null;
                                  },
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                RaisedButton(
                                  color: Colors.white,
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    await signUpController.signUpFunction();
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
