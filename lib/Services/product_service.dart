import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'service.dart';
import '../constants.dart' show Category;
import '../DataTypes/FirebaseDataTypes.dart' show Product, Vendor, Brand;

class ProductService extends Service{
 static final ProductService _instance = ProductService._internal();
  factory ProductService() {
    return _instance;
  }
  ProductService._internal();
  static ProductService get instance => _instance;

  Future<ReturnData> getProductsByCategories(List<Category> categories) async{
    try {
      List<String> categoryIds = categories.map((e) => e.id).toList();
      QuerySnapshot<Map<String, dynamic>> productsData = await firebaseFirestore.collection("Products").where("categoryIds", arrayContainsAny: categoryIds).get();
      List<Product> products = productsData.docs.map((e) { 
        Map<String,dynamic> data = {"productId": e.id}; 
        data.addAll(e.data());
        return Product.fromJson(data);
      }).toList();
      return ReturnData.withOnlyData(isSuccessful: true, data: products);
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return ReturnData.withFirebaseMessage(isSuccessful: false, firebaseMessageCode: err.code);
    }
  }

  Future<ReturnData> getProduct(String productId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> productData = await firebaseFirestore.collection("Products").doc(productId).get();
      Map<String,dynamic> data = {"productId": productData.id}; 
      data.addAll(productData.data() ?? {});
      return ReturnData.withOnlyData(isSuccessful: true, data: Product.fromJson(data));
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return ReturnData.withFirebaseMessage(isSuccessful: false, firebaseMessageCode: err.code);
    }
  }

  Future<ReturnData> getProductImageUrls(String productId) async{
    try {
      ListResult storageRef = await firebaseStorage.ref().child("/Products/$productId").listAll();
      List<String> urls = [];
      await Future.forEach(storageRef.items, (Reference element) async {
        String url = await element.getDownloadURL();
        urls.add(url);
      });
      print(urls);
      return ReturnData.withOnlyData(isSuccessful: true, data: urls);
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return ReturnData.withFirebaseMessage(isSuccessful: false, firebaseMessageCode: err.code);
    }
  }

  Future<ReturnData> getProductVendorData(DocumentReference<Map<String,dynamic>> vendorReference) async {
    try {
      DocumentSnapshot<Map<String,dynamic>> vendorData = await vendorReference.get();
      Map<String,dynamic> data = {"vendorId": vendorData.id}; 
      data.addAll(vendorData.data() ?? {});
      return ReturnData.withOnlyData(isSuccessful: true, data: Vendor.fromJson(data));
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return ReturnData.withFirebaseMessage(isSuccessful: false, firebaseMessageCode: err.code);
    }
  }

  Future<ReturnData> getProductBrandData(DocumentReference<Map<String,dynamic>> brandReference) async {
    try {
      DocumentSnapshot<Map<String,dynamic>> brandData = await brandReference.get();
      return ReturnData.withOnlyData(isSuccessful: true, data: Brand.fromJson(brandData.data()!));
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return ReturnData.withFirebaseMessage(isSuccessful: false, firebaseMessageCode: err.code);
    }
  }

  Future<ReturnData> getVendor(String vendorId) async{
    try {
      DocumentSnapshot<Map<String,dynamic>> vendorData = await firebaseFirestore.collection("Vendors").doc(vendorId).get();
      Map<String, dynamic> data = {"vendorId": vendorData.id};
      data.addAll(vendorData.data() ?? {});
      return ReturnData.withOnlyData(isSuccessful: true, data: Vendor.fromJson(data));
    } on FirebaseException catch (err) {
      print("[${err.code}] - ${err.message}");
      return ReturnData.withFirebaseMessage(isSuccessful: false, firebaseMessageCode: err.code);
    }
  }
}