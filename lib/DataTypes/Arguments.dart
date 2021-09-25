// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductScreenArgs{
  String productId;
  DocumentReference<Map<String,dynamic>>? vendorReference;
  ProductScreenArgs({
    required this.productId,
    this.vendorReference
  });
}

class VendorScreenArgs{
  final String vendorId;

  VendorScreenArgs({
    required this.vendorId
  });
}