import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/Helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = "";
  String password = "";

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  String currentaRole = "";

  @override
  Widget build(BuildContext context) {
    String currentEmail = ModalRoute.of(context)!.settings.arguments as String;
    currentaRole = currentEmail.split("@")[1].split(".")[0];
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/company.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              currentEmail,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Role : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${currentaRole}"),
              ],
            ),
            SizedBox(
              height: 400,
            ),
            OutlinedButton(
              onPressed: () {
                Get.offNamedUntil("/login_page", (route) => false);
              },
              child: Text("Log out"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "My Compnay",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: FireStoreHelper.fireStoreHelper.fatchAllUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
                querySnapshot!.docs;
            print("*********");
            print(currentEmail);
            print(currentaRole);
            print("*********");
            return (currentaRole == "admin")
                ? ListView.builder(
              itemCount: allDocs.length,
              itemBuilder: (context, i) => (currentEmail ==
                  allDocs[i]['email'])
                  ? Container()
                  : ListTile(
                title: Text(
                  "${allDocs[i]['email']}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                          title: "EDIT",
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
                                  textInputAction:
                                  TextInputAction.next,
                                  validator: (val) => (val!.isEmpty)
                                      ? "Enter email"
                                      : null,
                                  onSaved: (val) {
                                    email = val!;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText:
                                    "Enter roles wise email id..",
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12),
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
                                  textInputAction:
                                  TextInputAction.done,
                                  validator: (val) => (val!.isEmpty)
                                      ? "Enter password"
                                      : null,
                                  onSaved: (val) {
                                    password = val!;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    labelStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText:
                                    "Enter your password..",
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(12),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () async {
                                        if (loginKey.currentState!
                                            .validate()) {
                                          loginKey.currentState!
                                              .save();

                                          await FireStoreHelper
                                              .fireStoreHelper
                                              .updateUser(
                                            email: email,
                                            password: password,
                                            id: allDocs[i].id,
                                          );
                                          emailController.clear();
                                          passwordController
                                              .clear();
                                          Get.back();

                                          Get.snackbar(
                                            "Edit",
                                            "Edit Data In Successfull for $email",
                                            backgroundColor:
                                            Colors.green,
                                          );
                                          email = "";
                                          password = "";
                                        }
                                      },
                                      child: Text("edit"),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    OutlinedButton(
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
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        await FireStoreHelper.fireStoreHelper
                            .deleteUser(id: allDocs[i].id);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            )
                : ListView.builder(
              itemCount: allDocs.length,
              itemBuilder: (context, i) =>
              (currentEmail == allDocs[i]['email'])
                  ? Container()
                  : ListTile(
                title: Text(
                  "${allDocs[i]['email']}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}