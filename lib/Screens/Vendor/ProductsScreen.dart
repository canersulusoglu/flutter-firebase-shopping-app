// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../DataTypes/Arguments.dart' show VendorScreenArgs;


class VendorProductsScreen extends StatefulWidget {
  final VendorScreenArgs args;
  final VoidCallback goToVendorHomeScreen;
  const VendorProductsScreen({ 
    Key? key,
    required this.args,
    required this.goToVendorHomeScreen
  }) : super(key: key);

  @override
  _VendorProductsScreenState createState() => _VendorProductsScreenState();
}

class _VendorProductsScreenState extends State<VendorProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text("Vendor Products")
    );
  }
}