// ignore_for_file: file_names
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_firebase_shopping_app/Types/Product.dart';
import '../../Screens/OnePageScreens/LoadingScreen.dart' show LoadingScreen;
import '../../Screens/OnePageScreens/DatabaseErrorScreen.dart' show DatabaseErrorScreen;
import '../../Utils/ThemeData.dart';
import '../../Services/service.dart' show ReturnData;
import '../../Services/product_service.dart' show ProductService;
import '../../Types/Product.dart' show ProductScreenArgs;

final List<String> imgList = [
  'https://samsung.akinoncdn.com/products/2020/12/29/5241/01e5dc7c-83e4-4382-bf1e-23776b89bbe0_size616x616.jpg',
  'https://samsung.akinoncdn.com/products/2020/12/29/5241/1e492b2d-5a06-4bbb-bd74-32f8b35c0fa5_size616x616.jpg',
  'https://samsung.akinoncdn.com/products/2020/12/29/5241/02ae5a1b-60b9-4864-a92b-ee527cae6f4d_size616x616.jpg',
  'https://samsung.akinoncdn.com/products/2020/12/29/5241/cfc77fca-f2fc-47fc-9607-a514aa8139e9_size616x616.jpg',
  'https://samsung.akinoncdn.com/products/2020/12/29/5241/2cc1bb59-eb33-4391-a861-3b470510054d_size616x616.jpg',
  'https://m.media-amazon.com/images/I/71S+uKt3FLS._AC_SL1500_.jpg'
];

final List<String> otherSellersList = [
  "1",
  "2",
  "3",
  "4"
];

class ProductHomeScreen extends StatefulWidget {
  ProductScreenArgs args;
  final VoidCallback exitProductScreen;
  final VoidCallback goToProductDetailScreen;
  ProductHomeScreen({ Key? key, required this.args, required this.exitProductScreen, required this.goToProductDetailScreen }) : super(key: key);

  @override
  _ProductHomeScreenState createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  final CarouselController _imageSlidercontroller = CarouselController();
  final CarouselController _otherSellersSlidercontroller = CarouselController();
  int _currentimageIndex = 0;
  List<String> imgList = [];

  Future<Product>? fetchProductData() async {
    ReturnData result = await ProductService.instance.getProduct(widget.args.productId);
    return result.data as Product;
  }

  Future<List<String>>? fetchProductImagesUrls() async {
    ReturnData result = await ProductService.instance.getProductImageUrls(widget.args.productId);
    imgList = await result.data as List<String>;
    return imgList;
  }

  Future<ProductVendorDetail>? fetchProductVendorData() async {
    if(widget.args.vendorReference != null){
      ReturnData result = await ProductService.instance.getProductVendorData(widget.args.vendorReference!);
      return result.data;
    }
    return ProductVendorDetail(name: "Unknown", vendorId: "null", score: -1);
  }

  Future<Brand>? fetchProductBrandData(brandReference) async {
    if(widget.args.vendorReference != null){
      ReturnData result = await ProductService.instance.getProductBrandData(brandReference);
      return result.data;
    }
    return Brand(name: "", website: "");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchProductData(),
      builder: (BuildContext context, AsyncSnapshot<Product> productSnapData){
        if(productSnapData.data == null){
          return const LoadingScreen();
        }else{
          ProductVendor? productVendor = productSnapData.data!.vendors.firstWhere((e) => e.vendorReference== widget.args.vendorReference);
          List<ProductVendor>? otherVendors = productSnapData.data!.vendors.where((e) => e.vendorReference != widget.args.vendorReference).toList();
          return SafeArea(
            child: Stack(
              children: [
                SizedBox(
                  height: 350,
                  child: FutureBuilder(
                    future: fetchProductImagesUrls(),
                    builder: (BuildContext context, AsyncSnapshot<List<String>> snap){
                      if(snap.data == null){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else if(snap.data!.isEmpty){
                        return const Text("There is no image about this product");
                      }
                      else{
                        return CarouselSlider.builder(
                          carouselController: _imageSlidercontroller,
                          options: CarouselOptions(
                            height: 350,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentimageIndex = index;
                              });
                          }),
                          itemCount: snap.data!.length,
                          itemBuilder: (BuildContext context, int index, int pageViewIndex){
                            return Container(
                              margin: const EdgeInsets.all(10),
                              child: Image.network(
                                snap.data![index],
                                fit: BoxFit.fitHeight,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: (loadingProgress.expectedTotalBytes != null) 
                                          ? 
                                          loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              )
                            );
                          }
                        );
                      }
                    }
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.5,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 10),
                      controller: scrollController,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imgList.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => _imageSlidercontroller.animateToPage(entry.key),
                                  child: Container(
                                    width: 12.0,
                                    height: 12.0,
                                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness == Brightness.dark
                                                ? Colors.white
                                                : Colors.black)
                                            .withOpacity(_currentimageIndex == entry.key ? 0.9 : 0.4)),
                                  ),
                                );
                              }).toList()
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ürün ismi ve markası
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FutureBuilder(
                                        future: fetchProductBrandData(productSnapData.data!.brandReference),
                                        builder: (context, AsyncSnapshot<Brand> productBrandSnaData){
                                          if(productBrandSnaData.data == null){
                                            return const CircularProgressIndicator();
                                          }else{
                                            return RichText(
                                              text: TextSpan(
                                                text: productBrandSnaData.data!.name,
                                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blue),
                                                recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  await launch(productBrandSnaData.data!.website);
                                                }
                                              ),
                                            );
                                          }
                                        }
                                      ),
                                      Text(
                                        productSnapData.data!.name, 
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                                      Row(
                                        children: const[
                                          Text("4,7"),
                                          Icon(Icons.star, color: Colors.yellow,),
                                          Text("Tüm Değerlendirmeler (393)")
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(thickness: 3,height: 40,),
                                  // Satıcı Bilgileri
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Satıcı", style: TextStyle(fontSize:20, fontWeight: FontWeight.w600),),
                                          FutureBuilder(
                                            future: fetchProductVendorData(),
                                            builder: (BuildContext context, AsyncSnapshot<ProductVendorDetail> productVendorDataSnap){
                                              if(productVendorDataSnap.data == null){
                                                return const CircularProgressIndicator();
                                              }else{
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 10),
                                                      child: Text(productVendorDataSnap.data!.name, style: const TextStyle(fontSize:18, fontWeight:FontWeight.w900, color: Colors.indigo)),
                                                    ),
                                                    Container(
                                                      decoration: const BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                                      ),
                                                      padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                                                      child: Text(productVendorDataSnap.data!.score.toString(), style: const TextStyle(color: Colors.white),),
                                                    )
                                                  ],
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                child: const Text("Satıcıya Sor"),
                                                onPressed: () {}
                                              )
                                            )
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                  const Divider(thickness: 3,height: 40,),
                                  // Diğer Satıcılar
                                  if(otherVendors.isNotEmpty) ...[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Diğer Satıcılar (${otherVendors.length})", style: const TextStyle(fontSize:16),),
                                      CarouselSlider.builder(
                                        carouselController: _otherSellersSlidercontroller,
                                        options: CarouselOptions(
                                          viewportFraction: 0.65,
                                          height: 200,
                                          enableInfiniteScroll: false
                                        ),
                                        itemCount: otherVendors.length, 
                                        itemBuilder: (BuildContext context, int index, int pageViewIndex){
                                          return FutureBuilder(
                                            future: ProductService.instance.getProductVendorData(otherVendors[index].vendorReference),
                                            builder: (BuildContext context, AsyncSnapshot<ReturnData> otherVendorSnap){
                                              if(otherVendorSnap.data == null){
                                                return const CircularProgressIndicator();
                                              }else{
                                                ProductVendorDetail vendor = otherVendorSnap.data!.data;
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).colorScheme.background,
                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.5),
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: const Offset(0, 3), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  margin: const EdgeInsets.only(top: 10, bottom:10),
                                                  padding: const EdgeInsets.all(20),
                                                  width: 230,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.only(bottom: 20),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              decoration: const BoxDecoration(
                                                                color: Colors.green,
                                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                                              ),
                                                              padding: const EdgeInsets.only(right: 10,left: 10,top: 5,bottom: 5),
                                                              margin: const EdgeInsets.only(right: 10),
                                                              child: Text(vendor.score.toString(), style: const TextStyle(color: Colors.white),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 10),
                                                              child: Text(vendor.name, style: const TextStyle(fontSize:18, fontWeight:FontWeight.w900, color: Colors.indigo)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        otherVendors[index].getPriceWithCartDiscount().toStringAsFixed(2) + " TL",
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w900,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets.only(top: 10),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: OutlinedButton(
                                                                child: const Text("Bu Satıcıdan Sepete Ekle"),
                                                                onPressed: () {}
                                                              )
                                                            )
                                                          ],
                                                        )
                                                      )
                                                    ],
                                                  )
                                                );
                                              }
                                            }
                                          );
                                        }
                                      ),
                                    ]                                   
                                  ),
                                  const Divider(thickness: 3,height: 40,),
                                  ],
                                  // Ürün Detayları
                                  ElevatedButton(
                                    child: const Text("Ürün Detayları"),
                                    onPressed: widget.goToProductDetailScreen,
                                  )
                                ],
                              )
                            )
                          
                          ],
                        )
                      )
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 75,
                    padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(productVendor.cartDiscount != 0) ...[
                              Text(
                                "Sepette %${productVendor.cartDiscount} indirimli fiyat", 
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).additionalColorScheme.success
                                ),
                              ),
                              Text(
                                productVendor.getPriceWithCartDiscount().toStringAsFixed(2) + " TL", 
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).additionalColorScheme.success
                                ),
                              ),
                              Text(
                                productVendor.getPriceWithDiscount().toStringAsFixed(2) + " TL", 
                                style: const TextStyle(
                                  fontSize: 14, 
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.lineThrough
                                )
                              )
                            ] else ...[
                              Text(
                                productVendor.price.toStringAsFixed(2) + " TL",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900
                                ),
                              ),
                            ],
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite_outline),
                          iconSize: 30,
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          child: const Padding(padding: EdgeInsets.all(10), child: Text("Add to Cart", style: TextStyle(fontSize: 20),)),
                          onPressed: () {},
                        )
                      ],
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left:10, top:10),
                    child: FloatingActionButton(
                    onPressed: widget.exitProductScreen,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground),
                  ),
                  )
                ),
              ],
            )
          );
        }
      }
    );
  }
}