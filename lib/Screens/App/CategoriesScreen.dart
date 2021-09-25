// ignore_for_file: file_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_shopping_app/Services/auth_service.dart';
import '../../constants.dart' show productCategories;

class AppCategoriesScreen extends StatefulWidget {
  const AppCategoriesScreen({ Key? key }) : super(key: key);

  @override
  _AppCategoriesScreenState createState() => _AppCategoriesScreenState();
}

class _AppCategoriesScreenState extends State<AppCategoriesScreen> {
  int selectedTopCategoryIndex = -1;

  void changeMainCategory(String categoryId){
    int id = int.parse(categoryId);
    setState(() {
      selectedTopCategoryIndex = id;
    });
  }

  Widget buildFirstSubCategories(int topCategoryIndex){
    if(topCategoryIndex == -1){
      return const Text("Sana Özel");
    }else{
      if(productCategories[topCategoryIndex].subCategories.isNotEmpty){
         return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.75
          ),
          itemCount: productCategories[topCategoryIndex].subCategories.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    "product_list", 
                    arguments: productCategories[topCategoryIndex].subCategories[index]
                  );
                },
                child: SizedBox(
                  width: 450,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FutureBuilder(
                        future: productCategories[topCategoryIndex].subCategories[index].getImage(),
                        builder: (context, AsyncSnapshot snap) {
                          if (snap.connectionState == ConnectionState.done) {
                            return Container(child: snap.data, padding: const EdgeInsets.all(5));
                          }else{
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      Text(productCategories[topCategoryIndex].subCategories[index].getName(context), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }else{
        return const Text("It seems that this category is empty.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Container(
            margin: const EdgeInsets.only(left: 5),
            child: Column(
              children: [
                SizedBox(
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () => changeMainCategory('-1'),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar( 
                              child: Text(AuthService.instance.getLoggedUserData.name![0] + AuthService.instance.getLoggedUserData.surname![0]),
                            ),
                            const Text("Sana Özel", textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                    child: ListView.builder(
                      itemCount: productCategories.length,
                      itemBuilder: (BuildContext context, int index){
                        return Card(
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () => changeMainCategory(productCategories[index].id),
                            child: SideCategoryItem(index: index,),
                          ),
                        );
                      }
                    ),
                  ),
                )
              ],
            )
          )
        ),
        const VerticalDivider(),
        Expanded(
          child: buildFirstSubCategories(selectedTopCategoryIndex)
        )
      ],
    );
  }
}


class SideCategoryItem extends StatefulWidget {
  final int index;
  const SideCategoryItem({ Key? key, required this.index }) : super(key: key);

  @override
  _SideCategoryItemState createState() => _SideCategoryItemState();
}

class _SideCategoryItemState extends State<SideCategoryItem> {

  Future? _beforeLoadFetchImage;
  Future? beforeLoadFetchImage() async {
    return await productCategories[widget.index].getImage();
  }

  @override
  void initState() {
    super.initState();
    _beforeLoadFetchImage = beforeLoadFetchImage()!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FutureBuilder(
            future: _beforeLoadFetchImage,
            builder: (context, AsyncSnapshot snap) {
              if (snap.connectionState == ConnectionState.done) {
                return Container(child: snap.data, padding: const EdgeInsets.all(5));
              }else{
                return const CircularProgressIndicator();
              }
            },
          ),
          Text(productCategories[widget.index].getName(context), textAlign: TextAlign.center, maxLines: 2,)
        ],
      ),
    );
  }
}