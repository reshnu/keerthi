import 'package:chmm_carpool/HomeScreen/findaRide.dart';
import 'package:chmm_carpool/HomeScreen/homeScreen.dart';
import 'package:chmm_carpool/Profile/profile.dart';
import 'package:chmm_carpool/auth/otpHome.dart';
import 'package:chmm_carpool/auth/otpPage.dart';
import 'package:chmm_carpool/auth/registerUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 Firebase.initializeApp();


  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userName = prefs.getString("userName");
  runApp(MyApp(screen: (userName == null) ? OtpHome() : HomeScreen()));
  print(userName);
}


class MyApp extends StatelessWidget {
  final Widget screen;
  MyApp({this.screen});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Share MyRide',
      //test phase
      home: screen,
      routes: {
        '/otphome': (context) => OtpHome(),
        '/otppage': (context) => OtpPage(),
        '/homescreen': (context) => HomeScreen(),
        '/register': (context) => SignUp(),
        '/profile': (context) => ProfilePage(),
        '/findaride': (context) => FindaRide(),
      },
    );
  }
}
