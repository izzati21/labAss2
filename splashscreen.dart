import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homestay_raya/views/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config.dart';
import '../../models/user.dart';
import 'buyerscreen.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(149, 69, 168, 123),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(" HOMESTAY RAYA",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Seymour One')),
              CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(255, 84, 90, 202),
                  valueColor: AlwaysStoppedAnimation(
                      Color.fromARGB(255, 144, 203, 221)),
                  strokeWidth: 15),
              Text("Version 0.1a")
            ]),
      ),
    );
  }

  Future<void> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _email = (prefs.getString('email')) ?? '';
    String _pass = (prefs.getString('pass')) ?? '';
    if (_email.isNotEmpty) {
      http.post(Uri.parse("${ServerConfig.SERVER}/php/login_user.php"),
          body: {"email": _email, "password": _pass}).then((response) {
        var jsonResponse = json.decode(response.body);
        if (response.statusCode == 200 && jsonResponse['status'] == "success") {
          //var jsonResponse = json.decode(response.body);
          User user = User.fromJson(jsonResponse['data']);
          Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => BuyerScreen(user: user))));
        } else {
          User user = User(
            id: "0",
            email: "unregistered",
            name: "unregistered",
            // address: "na",
            phone: "0123456789",
            // regdate: "0",
            // credit: "0"
          );

          Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => const LoginScreen())));
        }
      });
    } else {
      User user = User(
        id: "0",
        email: "unregistered",
        name: "unregistered",
        // address: "na",
        phone: "0123456789",
        // regdate: "0",
        // credit: "0"
      );
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => const LoginScreen())));
    }
  }
}
