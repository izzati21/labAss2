import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homestay_raya/models/product.dart';
import 'package:homestay_raya/views/screens/loginscreen.dart';
import 'package:homestay_raya/views/screens/mainscreen.dart';
import 'package:homestay_raya/views/screens/registrationscreen.dart';

import '../../models/user.dart';
import 'package:homestay_raya/views/shared/mainmenu.dart';

class SellerScreen extends StatefulWidget {
  final User user;
  const SellerScreen({super.key, required this.user});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(title: const Text("Profile"), actions: [
            IconButton(
                onPressed: _registrationForm,
                icon: const Icon(Icons.app_registration)),
            IconButton(onPressed: _loginForm, icon: const Icon(Icons.login)),
          ]),
          body: const Center(child: Text("Profile")),
          drawer: MainMenuWidget(user: widget.user)),
    );
  }

  void _registrationForm() {
    Navigator.push(context,
        MaterialPageRoute(builder: (content) => const RegistrationScreen()));
  }

  void _loginForm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const LoginScreen()));
  }
}
