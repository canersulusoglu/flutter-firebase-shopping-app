// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';

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
      return vendors[0];
    }
    return null;
  }

  List<ProductVendor>? getOtherProductVendors(){
    if(vendors.length > 1){
      return vendors.sublist(1);
    }
    return null;
  }

  Product.fromJson(Map<String, dynamic> json){
    productId = json['productId'];
    categoryIds = json['categoryIds'];
    vendors = (json['vendors'] as List).map((e) => ProductVendor.fromJson(e)).toList();
    vendors.sort((a, b) => a.getPriceWithCartDiscount().compareTo(b.getPriceWithCartDiscount()));
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

class ProductVendor{
  late DocumentReference<Map<String,dynamic>> vendorReference;
  late num price;
  late int discount;
  late int cartDiscount;
  late List<PaymentOptions> paymentOptions;

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
    paymentOptions = (json['paymentOptions'] as List).map((e) => PaymentOptions.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    'vendorReference': vendorReference,
    'price': price,
    'discount': discount,
    'cartDiscount': cartDiscount,
    'paymentOptions': paymentOptions
  };
}

class Vendor{
  late String vendorId;
  late String name;
  late String email;
  late String city;
  late String contact;

  Vendor({
    required this.vendorId,
    required this.name,
    required this.email,
    required this.city,
    required this.contact
  });

  Vendor.fromJson(Map<String, dynamic> json){
    vendorId = json['vendorId'];
    name = json['name'];
    email = json['email'];
    city = json['city'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() => {
    'vendorId': vendorId,
    'name': name,
    'email': email,
    'city': city,
    'contact': contact,
  };
}

class PaymentOptions{
  late DocumentReference? cardReference;
  late List<Installment> installments;

  PaymentOptions({
    required this.cardReference,
    required this.installments
  });

  PaymentOptions.fromJson(Map<String, dynamic> json){
    cardReference = json['cardReference'];
    installments = (json['installments'] as List).map((e) => Installment.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    'cardReference': cardReference,
    'installments': installments
  };
}

class Installment{
  late num month;
  late num amount;

  Installment({
    required this.month,
    required this.amount
  });

  Installment.fromJson(Map<String, dynamic> json){
    month = json['month'];
    amount = json['amount'] ;
  }

  Map<String, dynamic> toJson() => {
    'month': month,
    'amount': amount
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

class PaymentCard{
  late String name;

  PaymentCard({
    required this.name
  });

  PaymentCard.fromJson(Map<String, dynamic> json){
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
    'name': name,
  };
}
