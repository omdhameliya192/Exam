
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../helpers/Helpers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = "";
  String password = "";

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Multi-User Authentication",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: "FACEBOOK",
                    titleStyle: TextStyle(
                      fontSize: 25,
                      color: Color(0xff39579a),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                    content: Form(
                      key: loginKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.0013,
                          ),
                          TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            validator: (val) =>
                            (val!.isEmpty) ? "Enter email" : null,
                            onSaved: (val) {
                              email = val!;
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: "Enter roles wise email id..",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xff39579a),
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            validator: (val) =>
                            (val!.isEmpty) ? "Enter password" : null,
                            onSaved: (val) {
                              password = val!;
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: "Enter your password..",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xff39579a),
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () async {
                                  if (loginKey.currentState!.validate()) {
                                    loginKey.currentState!.save();

                                    await FireStoreHelper.fireStoreHelper
                                        .addUser(
                                        email: email, password: password);
                                    emailController.clear();
                                    passwordController.clear();
                                    Get.back();

                                    Get.snackbar(
                                      "Sing In",
                                      "Sing In Successfull for $email",
                                      backgroundColor: Colors.green,
                                    );
                                    Get.offAllNamed("/home_page",
                                        arguments: email);
                                    email = "";
                                    password = "";
                                  }
                                },
                                child: Text("Login"),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  emailController.clear();
                                  passwordController.clear();
                                  email = "";
                                  password = "";
                                },
                                child: Text("Reset"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: Get.height * 0.125,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color(0xff39579a),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(5, 5),
                        color: Colors.grey.shade200,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Login With Facebook",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: "GOOGLE",
                    titleStyle: TextStyle(
                      fontSize: 25,
                      color: Color(0xffdf4a32),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                    content: Form(
                      key: loginKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.0013,
                          ),
                          TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            validator: (val) =>
                            (val!.isEmpty) ? "Enter email" : null,
                            onSaved: (val) {
                              email = val!;
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: "Enter roles wise email id..",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xff39579a),
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            validator: (val) =>
                            (val!.isEmpty) ? "Enter password" : null,
                            onSaved: (val) {
                              password = val!;
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: "Enter your password..",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xff39579a),
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () async {
                                  if (loginKey.currentState!.validate()) {
                                    loginKey.currentState!.save();

                                    await FireStoreHelper.fireStoreHelper
                                        .addUser(
                                        email: email, password: password);
                                    emailController.clear();
                                    passwordController.clear();
                                    Get.back();

                                    Get.snackbar(
                                      "Sing In",
                                      "Sing In Successfull for $email",
                                      backgroundColor: Colors.green,
                                    );
                                    Get.offAllNamed("/home_page",
                                        arguments: email);
                                    email = "";
                                    password = "";
                                  }
                                },
                                child: Text("Login"),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  emailController.clear();
                                  passwordController.clear();
                                  email = "";
                                  password = "";
                                },
                                child: Text("Reset"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: Get.height * 0.125,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color(0xffdf4a32),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(5, 5),
                        color: Colors.grey.shade200,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Login With Google",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: "WHATSAPP",
                    titleStyle: TextStyle(
                      fontSize: 25,
                      color: Color(0xff075e54),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                    content: Form(
                      key: loginKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.0013,
                          ),
                          TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            validator: (val) =>
                            (val!.isEmpty) ? "Enter email" : null,
                            onSaved: (val) {
                              email = val!;
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: "Enter roles wise email id..",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xff39579a),
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            validator: (val) =>
                            (val!.isEmpty) ? "Enter password" : null,
                            onSaved: (val) {
                              password = val!;
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: "Enter your password..",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xff39579a),
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () async {
                                  if (loginKey.currentState!.validate()) {
                                    loginKey.currentState!.save();

                                    await FireStoreHelper.fireStoreHelper
                                        .addUser(
                                        email: email, password: password);
                                    emailController.clear();
                                    passwordController.clear();
                                    Get.back();

                                    Get.snackbar(
                                      "Sing In",
                                      "Sing In Successfull for $email",
                                      backgroundColor: Colors.green,
                                    );
                                    Get.offAllNamed("/home_page",
                                        arguments: email);
                                    email = "";
                                    password = "";
                                  }
                                },
                                child: Text("Login"),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  emailController.clear();
                                  passwordController.clear();
                                  email = "";
                                  password = "";
                                },
                                child: Text("Reset"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: Get.height * 0.125,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color(0xff075e54),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(5, 5),
                        color: Colors.grey.shade200,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Login With WhatsApp",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: "GITHUB",
                    titleStyle: TextStyle(
                      fontSize: 25,
                      color: Color(0xff202020),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                    content: Form(
                      key: loginKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.0013,
                          ),
                          TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            validator: (val) =>
                            (val!.isEmpty) ? "Enter email" : null,
                            onSaved: (val) {
                              email = val!;
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: "Enter roles wise email id..",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xff39579a),
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: passwordController,
                            textInputAction: TextInputAction.done,
                            validator: (val) =>
                            (val!.isEmpty) ? "Enter password" : null,
                            onSaved: (val) {
                              password = val!;
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: "Enter your password..",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xff39579a),
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                onPressed: () async {
                                  if (loginKey.currentState!.validate()) {
                                    loginKey.currentState!.save();

                                    await FireStoreHelper.fireStoreHelper
                                        .addUser(
                                        email: email, password: password);
                                    emailController.clear();
                                    passwordController.clear();
                                    Get.back();

                                    Get.snackbar(
                                      "Sing In",
                                      "Sing In Successfull for $email",
                                      backgroundColor: Colors.green,
                                    );
                                    Get.offAllNamed("/home_page",
                                        arguments: email);
                                    email = "";
                                    password = "";
                                  }
                                },
                                child: Text("Login"),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  emailController.clear();
                                  passwordController.clear();
                                  email = "";
                                  password = "";
                                },
                                child: Text("Reset"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: Get.height * 0.125,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Color(0xff202020),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(5, 5),
                        color: Colors.grey.shade200,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Login With Github",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xff39579a),
                    child: Text(
                      "f",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xffdf4a32),
                    child: Text(
                      "G",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xff075e54),
                    child: Text(
                      "W",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xff202020),
                    child: Text(
                      "g",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}