// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../constants.dart' show Category;
import '../Utils/RandomColor.dart';
import '../Services/service.dart' show ReturnData;
import '../Services/product_service.dart' show ProductService;
import '../DataTypes/FirebaseDataTypes.dart' show Product, ProductVendor;
import '../DataTypes/Arguments.dart' show ProductScreenArgs;

class AppProductListScreen extends StatefulWidget {
  final Category category;
  const AppProductListScreen({ Key? key, required this.category}) : super(key: key);

  @override
  _AppProductListScreenState createState() => _AppProductListScreenState();
}

class _AppProductListScreenState extends State<AppProductListScreen> {
  late Category category;

  @override
  void initState() {
    super.initState();
    category = widget.category;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10), 
                  child: Text(
                    category.getName(context),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                  )
                )
              ),
              const Divider(thickness: 3)
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(category.subCategories.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  children: List.generate(category.subCategories.length, (int index) {
                    return SubCategoryCard(category: category.subCategories[index],);
                  })
                ),
              )
            ],
            const Divider(height: 50, thickness: 3,),
            Container(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: ProductService.instance.getProductsByCategories([category]),
                builder: (BuildContext context, AsyncSnapshot<ReturnData> snap){
                  if(snap.data == null){
                    return const CircularProgressIndicator();
                  }else{
                    List<Product> productsData = snap.data!.data;
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 0.37,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      children: List.generate(productsData.length, (index){
                        return ProductCard(productData: productsData[index],);
                      })
                    );
                  }
                }
              )
            )
          ],
        ),
      )
    );
  }
}


class SubCategoryCard extends StatelessWidget {
  final Category category;
  const SubCategoryCard({ Key? key, required this.category}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    Color cardBackgroundColor = randomColor(opacity: 0.7);
    bool backgroundColorIsDark = colorIsDark(cardBackgroundColor);
    return Card(
      color: cardBackgroundColor,
      child: InkWell(
        highlightColor: (backgroundColorIsDark)? Colors.white12 : Colors.black12,
        onTap: () {
          Navigator.of(context).pushNamed(
            "product_list", 
            arguments: category
          );
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder(
                future: category.getImage(),
                builder: (context, AsyncSnapshot snap) {
                  if (snap.connectionState == ConnectionState.done) {
                    return snap.data;
                  }else{
                    return const CircularProgressIndicator();
                  }
                },
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    category.getName(context), 
                    textAlign: TextAlign.center, 
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(color: getTextColor(cardBackgroundColor)),
                  )
                )
              )
            ],
          ),
        )
      ),
    );
  }
}


class ProductCard extends StatefulWidget {
  final Product productData;
  const ProductCard({ Key? key, required this.productData }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _currentimageIndex = 0;

  @override
  Widget build(BuildContext context) {
    ProductVendor? productVendor = widget.productData.getChipestProductVendor();
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("product", arguments: ProductScreenArgs(
            productId: widget.productData.productId,
            vendorReference: (productVendor != null) ? productVendor.vendorReference : null
          ));
        },
        child: FutureBuilder(
          future: ProductService.instance.getProductImageUrls(widget.productData.productId),
          builder: (BuildContext context, AsyncSnapshot<ReturnData> snap){
            if(snap.data == null){
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }else{
              List<String> data = snap.data!.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      if (data.isNotEmpty) ...[
                        CarouselSlider.builder(
                          itemCount: data.length, 
                          itemBuilder: (BuildContext context, int index, int pageViewIndex){
                            return Image.network(
                              data[index],
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
                            );
                          }, 
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentimageIndex = index;
                              });
                            }
                          ),
                        ),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: data.asMap().entries.map((entry) {
                          return Container(
                            width: 24.0,
                            height: 4.0,
                            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 1.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(_currentimageIndex == entry.key ? 0.9 : 0.4)),
                          );
                        }).toList()
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                widget.productData.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                                )
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: const [
                                  Icon(Icons.star, size:18, color:Colors.yellow),
                                  Icon(Icons.star, size:18, color:Colors.yellow),
                                  Icon(Icons.star, size:18, color:Colors.yellow),
                                  Icon(Icons.star, size:18, color:Colors.yellow),
                                  Icon(Icons.star, size:18),
                                  Text("(1354)")
                                ],
                              ),
                            ),
                            if(productVendor != null) ...[
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    if (productVendor.discount != 0) ...[
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Text(
                                          "%" + productVendor.discount.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Colors.white
                                          )
                                        ),
                                      )
                                    ],
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (productVendor.discount != 0) ...[
                                              Text(
                                                productVendor.price.toStringAsFixed(2) + " TL",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                  fontSize: 14,
                                                )
                                              ),
                                            ],

                                            if(productVendor.cartDiscount != 0) ...[
                                              Text(
                                                productVendor.getPriceWithDiscount().toStringAsFixed(2) + " TL",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  //fontWeight: FontWeight.w800,
                                                  fontSize: 18,
                                                )
                                              ),
                                            ] else ...[
                                              Text(
                                                productVendor.getPriceWithDiscount().toStringAsFixed(2) + " TL",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18,
                                                )
                                              ),
                                            ],
                                          ],
                                        ),
                                      )
                                    )
                                  ],
                                ),
                              ),
                              if(productVendor.cartDiscount != 0) ...[
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(220, 220, 220, 1),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sepette %${productVendor.cartDiscount} indirimli fiyat",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(0, 128, 0, 1)
                                        ),
                                      ),
                                      Text(
                                        productVendor.getPriceWithCartDiscount().toStringAsFixed(2) + " TL",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: Colors.black
                                        )
                                      ),
                                    ],
                                  )
                                )
                              ]
                            ],
                          ],
                        )
                      )
                    ],
                  ),
                  Column(
                    children: [
                      if(productVendor != null) ...[
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: (){}, 
                                  child: const Text("Sepete Ekle")
                                )
                              )
                            ],
                          )
                        )
                      ]
                    ],
                  )
                  
                ],
              );
            }
          },
        ),
      ),
    );
  }
}