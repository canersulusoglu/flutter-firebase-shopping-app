// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart' show rootBundle;

class Category{
  final String id;
  final String firebaseStorageImageName;
  List<Category> subCategories;

  Category({required this.id, required this.firebaseStorageImageName, this.subCategories = const []});

  String getName(context){
    return AppLocalizations.of(context)!.categories(id);
  }

  Future<Image> getImage() async{
    String imagePath = "assets/images/categories/$id.png";
    return rootBundle.load(imagePath).then((value) {
      return Image.memory(value.buffer.asUint8List());
    }).catchError((_) {
      return Image.asset("assets/images/null.png");
    });
  }
}

List<Category> productCategories = [
  // Elektronik
  Category(id: '0', firebaseStorageImageName: "", subCategories: [
    // Bilgisayarlar
    Category(id: '0_0', firebaseStorageImageName: "", subCategories: [
      // Dizüstü Bilgisayalar
      Category(id: '0_0_0', firebaseStorageImageName: ""),
      // Masaüstü Bilgisayalar
      Category(id: '0_0_1', firebaseStorageImageName: ""),
      // Oyun Konsolları
      Category(id: '0_0_2', firebaseStorageImageName: ""),
      // Bilgisayar Bileşenleri
      Category(id: '0_0_3', firebaseStorageImageName: "", subCategories: [
        // Ekran Kartları
        Category(id: '0_0_3_0', firebaseStorageImageName: ""),
        // İşlemciler
        Category(id: '0_0_3_1', firebaseStorageImageName: ""),
        // Ana Kartlar
        Category(id: '0_0_3_2', firebaseStorageImageName: ""),
        // Ramler
        Category(id: '0_0_3_3', firebaseStorageImageName: ""),
        // Hard Diskler - Ssdler
        Category(id: '0_0_3_4', firebaseStorageImageName: ""),
      ]),
      // Bilgisayar Ekipmanları
      Category(id: '0_0_4', firebaseStorageImageName: "", subCategories: [
        // Monitörler
        Category(id: '0_0_4_0', firebaseStorageImageName: ""),
        // Klavyeler
        Category(id: '0_0_4_1', firebaseStorageImageName: ""),
        // Mouselar
        Category(id: '0_0_4_2', firebaseStorageImageName: ""),
        // Mikrofonlar
        Category(id: '0_0_4_3', firebaseStorageImageName: ""),
        // Kulaklıklar
        Category(id: '0_0_4_4', firebaseStorageImageName: "", subCategories:[
          // Bluetooth Kulaklıklar
          Category(id: '0_0_4_4_0', firebaseStorageImageName: ""),
          // Kulaküstü Kulaklıklar
          Category(id: '0_0_4_4_1', firebaseStorageImageName: ""),
          // Kulakiçi Kulaklıklar
          Category(id: '0_0_4_4_2', firebaseStorageImageName: "")
        ]),
        // Kameralar
        Category(id: '0_0_4_5', firebaseStorageImageName: ""),
        // Direksiyon Setleri
        Category(id: '0_0_4_6', firebaseStorageImageName: "")
      ])
    ]),
    // Telefonlar
    Category(id: '0_1', firebaseStorageImageName: "", subCategories: [
      // Android Telefonlar
      Category(id: '0_1_0', firebaseStorageImageName: ""),
      // iOS Telefonlar
      Category(id: '0_1_1', firebaseStorageImageName: ""),
      // Akıllı Saat ve Bileklikler
      Category(id: '0_1_2', firebaseStorageImageName: ""),
      // Telefon Aksesuarları
      Category(id: '0_1_3', firebaseStorageImageName: "")
    ]),
    // Tabletler
    Category(id: '0_2', firebaseStorageImageName: "", subCategories: [
      // Android Tabletler
      Category(id: '0_2_0', firebaseStorageImageName: ""),
      // iOS Tabletler
      Category(id: '0_2_1', firebaseStorageImageName: ""),
      // Tablet Aksesuarları
      Category(id: '0_2_2', firebaseStorageImageName: "")
    ]),
    // Yazıcılar
    Category(id: '0_3', firebaseStorageImageName: "", subCategories: [
      // Lazer Yazıcılar
      Category(id: '0_3_0', firebaseStorageImageName: ""),
      // Tanklı Yazıcılar
      Category(id: '0_3_1', firebaseStorageImageName: ""),
      // Mürekkep Püskürtmeli Yazıcılar
      Category(id: '0_3_2', firebaseStorageImageName: ""),
      // Nokta Vuruşlu Yazıcılar
      Category(id: '0_3_3', firebaseStorageImageName: ""),
      // Fotoğraf Yazıcıları
      Category(id: '0_3_4', firebaseStorageImageName: ""),
      // 3D Yazıcılar
      Category(id: '0_3_5', firebaseStorageImageName: ""),
      // Barkod Yazıcıları
      Category(id: '0_3_6', firebaseStorageImageName: ""),
      // Tarayıcılar
      Category(id: '0_3_7', firebaseStorageImageName: ""),
    ]),
    // Televizyon, Görüntü ve Ses Sistemleri
    Category(id: '0_4', firebaseStorageImageName: "", subCategories: [
      // Televizyonlar
      Category(id: '0_4_0', firebaseStorageImageName: ""),
      // Ev Sinema Sistemleri
      Category(id: '0_4_1', firebaseStorageImageName: ""),
      // Bluetooth Hoparlörler
      Category(id: '0_4_2', firebaseStorageImageName: ""),
      // Müzik Sistemleri
      Category(id: '0_4_3', firebaseStorageImageName: ""),
      // Projeksiyon Sistemleri
      Category(id: '0_4_4', firebaseStorageImageName: ""),
      // Uydu Alıcıları
      Category(id: '0_4_5', firebaseStorageImageName: ""),
      // Blu-Ray ve DVD Oynatıcılar
      Category(id: '0_4_6', firebaseStorageImageName: ""),
      // Kablo ve Soketler
      Category(id: '0_4_7', firebaseStorageImageName: ""),
      // Tv Aksesuarları
      Category(id: '0_4_8', firebaseStorageImageName: ""),
      // Güvenlik Sistemleri
      Category(id: '0_4_9', firebaseStorageImageName: ""),
      // Media Player
      Category(id: '0_4_10', firebaseStorageImageName: ""),
      // Kablosuz Ses ve Görüntü Aktarıcı
      Category(id: '0_4_11', firebaseStorageImageName: ""),
    ]),
    // Beyaz Eşyalar
    Category(id: '0_5', firebaseStorageImageName: "", subCategories: [
      // Çamaşır Makineleri
      Category(id: '0_5_0', firebaseStorageImageName: ""),
      // Buzdolapları
      Category(id: '0_5_1', firebaseStorageImageName: ""),
      // Bulaşık Makineleri
      Category(id: '0_5_2', firebaseStorageImageName: ""),
      // Kurutma Makineleri
      Category(id: '0_5_3', firebaseStorageImageName: ""),
      // Su Sebilleri
      Category(id: '0_5_4', firebaseStorageImageName: ""),
      // Derin Dondurucular
      Category(id: '0_5_5', firebaseStorageImageName: ""),
      // Ocaklar
      Category(id: '0_5_6', firebaseStorageImageName: ""),
      // Fırınlar
      Category(id: '0_5_7', firebaseStorageImageName: ""),
      // Mikrodalga Fırınlar
      Category(id: '0_5_8', firebaseStorageImageName: ""),
      // Ankastre Setler
      Category(id: '0_5_9', firebaseStorageImageName: ""),
      // Davlumbazlar
      Category(id: '0_5_10', firebaseStorageImageName: ""),
    ]),
    // Klima ve Isıtıcılar
    Category(id: '0_6', firebaseStorageImageName: "", subCategories: [
      // Klimalar
      Category(id: '0_6_0', firebaseStorageImageName: ""),
      // Kombiler
      Category(id: '0_6_1', firebaseStorageImageName: ""),
      // Şofbenler
      Category(id: '0_6_2', firebaseStorageImageName: ""),
      // Termosifonlar
      Category(id: '0_6_3', firebaseStorageImageName: ""),
      // Vantilatörler
      Category(id: '0_6_4', firebaseStorageImageName: ""),
      // Sobalar ve Isıtıcılar
      Category(id: '0_6_5', firebaseStorageImageName: ""),
    ]),
    // Elektrikli Ev Aletleri
    Category(id: '0_7', firebaseStorageImageName: "", subCategories: [
      // Ütüler
      Category(id: '0_7_0', firebaseStorageImageName: ""),
      // Süpürgeler
      Category(id: '0_7_1', firebaseStorageImageName: ""),
      // Saç ve Sakal Makinaları
      Category(id: '0_7_2', firebaseStorageImageName: ""),
      // Saç Kurutma ve Şekillendirme Makinaları
      Category(id: '0_7_3', firebaseStorageImageName: ""),
      // Epilatörler ve IPL Cihazları
      Category(id: '0_7_4', firebaseStorageImageName: ""),
      // İçecek Hazırlama
      Category(id: '0_7_5', firebaseStorageImageName: ""),
      // Yiyecek Hazırlama
      Category(id: '0_7_6', firebaseStorageImageName: ""),
      // Pişirme
      Category(id: '0_7_7', firebaseStorageImageName: ""),
      // Hava Temizleme ve Nem Alma Cihazları
      Category(id: '0_7_8', firebaseStorageImageName: ""),
      // Çay ve Kahve Makineleri
      Category(id: '0_7_9', firebaseStorageImageName: ""),
    ]),
    // Fotoğraf ve Kameralar
    Category(id: '0_8', firebaseStorageImageName: "", subCategories: [
      // SLR Fotoğraf Makineleri
      Category(id: '0_8_0', firebaseStorageImageName: ""),
      // Dijital Fotoğraf Makineleri
      Category(id: '0_8_1', firebaseStorageImageName: ""),
      // Aksiyon Kamera
      Category(id: '0_8_2', firebaseStorageImageName: ""),
      // Outdoor & Sualtı Foto. Mk.
      Category(id: '0_8_3', firebaseStorageImageName: ""),
      // Drone
      Category(id: '0_8_4', firebaseStorageImageName: ""),
      // Aynasız Kompakt SLR Mk.
      Category(id: '0_8_5', firebaseStorageImageName: ""),
      // Video Kameralar
      Category(id: '0_8_6', firebaseStorageImageName: ""),
      // Elektronik-Optik (GPS,Dürbün)
      Category(id: '0_8_7', firebaseStorageImageName: ""),
      // Aksesuarlar
      Category(id: '0_8_8', firebaseStorageImageName: ""),
    ]),
  ]),
  // Moda - Giyim
  Category(id: '1', firebaseStorageImageName: ""),
];