// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../DataTypes/Arguments.dart' show VendorScreenArgs;

class VendorAssessmentsScreen extends StatefulWidget {
  final VendorScreenArgs args;
  final VoidCallback goToVendorHomeScreen;
  const VendorAssessmentsScreen({
    Key? key,
    required this.args,
    required this.goToVendorHomeScreen
  }) : super(key: key);

  @override
  _VendorAssessmentsScreenState createState() => _VendorAssessmentsScreenState();
}

class _VendorAssessmentsScreenState extends State<VendorAssessmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text("VENDOR aSSESSMENTS SREEN"),
    );
  }
}