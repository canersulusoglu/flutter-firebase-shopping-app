// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppShoppingCartScreen extends StatelessWidget {
  const AppShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Column(
        children: [
          Text("Shopping Cart Screen"),
        ],
      )),
    );
  }
}
