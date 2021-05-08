import 'package:TrainnigInfo/Controller/ChangePasswordController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TrainnigInfo/Repository/MyRepository.dart';
import 'package:http/http.dart' as http;
import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<ChangePasswordPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ChangePasswordController _changePasswordController = Get.put(
      ChangePasswordController(
          repository:
              MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            "Change Password",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
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
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    height: Get.height / 1.8,
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
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 300,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  obscureText: true,
                                  controller: _changePasswordController
                                      .oldPasswordController,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  decoration: new InputDecoration(
                                    labelText: 'Old Password',
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
                                      return "Old Password is Required";
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
                                  controller: _changePasswordController
                                      .passwordController,
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
                                  controller: _changePasswordController
                                      .confirmPasswordController,
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
                                    else if (!value.contains(
                                        _changePasswordController
                                            .passwordController.text))
                                      return "Password is not match";
                                    else
                                      return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RaisedButton(
                                  color: Colors.white,
                                  child: Text(
                                    "Change Password",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    await _changePasswordController
                                        .changePasswordFunction(_formKey);
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
