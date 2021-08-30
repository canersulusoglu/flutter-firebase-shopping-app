// ignore_for_file: file_names
import 'package:flutter/material.dart';

class AppCategoriesScreen extends StatefulWidget {
  const AppCategoriesScreen({ Key? key }) : super(key: key);

  @override
  _AppCategoriesScreenState createState() => _AppCategoriesScreenState();
}

class _AppCategoriesScreenState extends State<AppCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Column(
        children: [
          Text("Categories Screen"),
        ],
      )),
    );
  }
}