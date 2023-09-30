import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multi_user_authentication/firebase_options.dart';
import 'package:multi_user_authentication/views/screen/LoginScreen.dart';
import 'package:multi_user_authentication/views/screen/homePage.dart';
import 'package:multi_user_authentication/views/screen/splashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      getPages: [
        GetPage(
          name: "/",
          page: () => SplachScreen(),
        ),
        GetPage(
          name: "/login_page",
          page: () => LoginPage(),
        ),
        GetPage(
          name: "/home_page",
          page: () => HomePage(),
        ),
      ],
    ),
  );
}