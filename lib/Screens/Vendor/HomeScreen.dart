// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_firebase_shopping_app/Services/service.dart';
import '../../DataTypes/Arguments.dart' show VendorScreenArgs;
import '../OnePageScreens/LoadingScreen.dart' show LoadingScreen;
import '../../Services/product_service.dart' show ProductService;
import '../../DataTypes/FirebaseDataTypes.dart' show Vendor;


class VendorHomeScreen extends StatefulWidget {
  final VendorScreenArgs args;
  final VoidCallback exitVendorScreen;
  final VoidCallback goToVendorProductsScreen;
  final VoidCallback goToVendorAssessmentsScreen;
  const VendorHomeScreen({ 
    Key? key,
    required this.args,
    required this.exitVendorScreen,
    required this.goToVendorProductsScreen,
    required this.goToVendorAssessmentsScreen
  }) : super(key: key);

  @override
  _VendorHomeScreenState createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: ProductService.instance.getVendor(widget.args.vendorId),
        builder: (BuildContext context, AsyncSnapshot<ReturnData> snap){
          if(snap.data == null){
            return const LoadingScreen();
          }else{
            Vendor vendor = snap.data!.data;
            return SingleChildScrollView(
              child: Container(
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
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          vendor.name,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          padding: const EdgeInsets.only(right: 15,left: 15,top: 8,bottom: 8),
                          margin: const EdgeInsets.only(right: 10),
                          child: Text("---", style: const TextStyle(color: Colors.white, fontSize: 18),),
                        ),
                      ],
                    ),
                    const Divider(thickness: 5,),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom:10),
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.email, size: 30,),
                              title: Text('E-Mail'),
                              subtitle: Text(vendor.email),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.location_on, size: 30,),
                              title: Text('City'),
                              subtitle: Text(vendor.city)
                            ),
                          ),
                          Card(
                            child: ListTile(
                              leading: Icon(Icons.phone, size: 30,),
                              title: Text('Contact'),
                              subtitle: Text(vendor.contact)
                            ),
                          ),
                        ],
                      )
                    ),
                    const Divider(thickness: 3,),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const[
                                  Padding(padding: EdgeInsets.all(10), child: Icon(Icons.inventory),),
                                  Text("Satıcının Ürünleri", style: TextStyle(fontSize: 16))
                                ],
                              ),
                              onPressed: widget.goToVendorProductsScreen
                            )
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(padding: EdgeInsets.all(10), child: Icon(Icons.comment),),
                                  Text("Satıcı Değerlendirmeleri", style: TextStyle(fontSize: 16))
                                ],
                              ),
                              onPressed: widget.goToVendorAssessmentsScreen
                            )
                          )
                        ],
                      )
                    ),
                    
                  ],
                )
              ) 
            );
          }
        },
      )
    );
  }
}