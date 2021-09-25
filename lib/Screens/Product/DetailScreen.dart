// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../DataTypes/Arguments.dart' show ProductScreenArgs;

typedef GoBackCallback = Function(int routeIndex);


class ProductDetailScreen extends StatefulWidget {
  final ProductScreenArgs args;
  final VoidCallback goToProductHomeScreen;
  const ProductDetailScreen({ Key? key, required this.args, required this.goToProductHomeScreen }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
      preferredSize: const Size.fromHeight(140),
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10), 
              child:  Text(
                "Samsung Galaxy A51 256 GB (Samsung Türkiye Garantili)", 
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
              )
            ),
            TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
              indicatorColor: Theme.of(context).colorScheme.primary,
              isScrollable: true,
              tabs: const[
                Tab(
                  icon: Icon(Icons.star),
                  text: "Değerlendirmeler",
                ),
                Tab(
                  icon: Icon(Icons.question_answer),
                  text: "Soru & Cevap",
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: "Ürün Açıklamaları",
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: "Ürün Özellikleri",
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: "Kampanyalar",
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: "Taksit Seçenekleri",
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: "İade Koşulları",
                ),
              ],
            ),
            const Divider(thickness: 3)
          ],
        ),
      ),
    ),
    body:TabBarView(
      controller: _tabController,
      children: const <Widget>[
        Center(
          child: Text("1"),
        ),
        Center(
          child: Text("2"),
        ),
        Center(
          child: Text("3"),
        ),
        Center(
          child: Text("4"),
        ),
        Center(
          child: Text("5"),
        ),
        Center(
          child: Text("6"),
        ),
        Center(
          child: Text("7"),
        ),
      ],
    ),
  );
  }
}