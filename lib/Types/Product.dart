// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductVendorDetail{
  late String vendorId;
  late String name;
  late double score;

  ProductVendorDetail({
    required this.vendorId,
    required this.name,
    required this.score
  });

  ProductVendorDetail.fromJson(Map<String, dynamic> json){
    vendorId = json['vendorId'];
    name = json['name'] ;
    score = json['score'];
  }

  Map<String, dynamic> toJson() => {
    'vendorId': vendorId,
    'name': name,
    'score': score
  };
}

class ProductVendor{
  late DocumentReference<Map<String,dynamic>> vendorReference;
  late num price;
  late int discount;
  late int cartDiscount;
  late List<dynamic> paymentOptions;

  ProductVendor({
    required this.vendorReference,
    required this.price,
    this.discount = 0,
    this.cartDiscount = 0,
    this.paymentOptions = const []
  });

  double getPriceWithDiscount(){
    double discountAmount = discount != 0 ? ((price * discount).toDouble() / 100).toDouble() : 0;
    return (price - discountAmount);
  }

  double getPriceWithCartDiscount(){
    double discountAmount = discount != 0 ? ((price * discount).toDouble() / 100).toDouble() : 0;
    double cardDiscountAmount = cartDiscount != 0 ? ((price * cartDiscount).toDouble() / 100).toDouble() : 0;
    return (price - discountAmount - cardDiscountAmount);
  }

  ProductVendor.fromJson(Map<String, dynamic> json){
    vendorReference = json['vendorReference'];
    price = json['price'] ;
    discount = json['discount'];
    cartDiscount = json['cartDiscount'];
    paymentOptions = json['paymentOptions'];
  }

  Map<String, dynamic> toJson() => {
    'vendorReference': vendorReference,
    'price': price,
    'discount': discount,
    'cartDiscount': cartDiscount,
    'paymentOptions': paymentOptions
  };
}

class Product{
  late String productId;
  late List<dynamic> categoryIds;
  late List<ProductVendor> vendors;
  late String name;
  late DocumentReference? brandReference;
  late Map<String,dynamic> features;

  Product({
    required this.productId,
    this.categoryIds = const [], 
    this.vendors = const [],
    this.name = "",
    this.brandReference,
    this.features = const {}
  });

  ProductVendor? getChipestProductVendor(){
    if(vendors.isNotEmpty){
      double minPrice = vendors[0].getPriceWithCartDiscount();
      int index = 0;
      for (var i = 1; i < vendors.length; i++) {
        if(vendors[i].getPriceWithCartDiscount() < minPrice){
          index = i;
        }
      }
      return vendors[index];
    }
    return null;
  }


  Product.fromJson(Map<String, dynamic> json){
    productId = json['productId'];
    categoryIds = json['categoryIds'];
    vendors = (json['vendors'] as List).map((e) => ProductVendor.fromJson(e)).toList();
    name = json['name'];
    brandReference = json['brandReference'];
    features = json['features'];
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'categoryIds': categoryIds,
    'vendors': vendors,
    'name': name,
    'brandReference': brandReference,
    'features': features
  };

}

class Brand{
  late String name;
  late String website;

  Brand({
    required this.name,
    required this.website
  });

  Brand.fromJson(Map<String, dynamic> json){
    name = json['name'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'website': website,
  };
}


class ProductScreenArgs{
  String productId;
  DocumentReference<Map<String,dynamic>>? vendorReference;
  ProductScreenArgs({
    required this.productId,
    this.vendorReference
  });
}