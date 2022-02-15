import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/services.dart' show rootBundle;

class Category{
  final String id;
  List<Category> subCategories;

  Category({required this.id, this.subCategories = const []});

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
  Category(id: '0', subCategories: [
    // Bilgisayarlar
    Category(id: '0_0', subCategories: [
      // Dizüstü Bilgisayalar
      Category(id: '0_0_0'),
      // Masaüstü Bilgisayalar
      Category(id: '0_0_1'),
      // Oyun Konsolları
      Category(id: '0_0_2'),
      // Bilgisayar Bileşenleri
      Category(id: '0_0_3', subCategories: [
        // Ekran Kartları
        Category(id: '0_0_3_0'),
        // İşlemciler
        Category(id: '0_0_3_1'),
        // Ana Kartlar
        Category(id: '0_0_3_2'),
        // Ramler
        Category(id: '0_0_3_3'),
        // Hard Diskler - Ssdler
        Category(id: '0_0_3_4'),
      ]),
      // Bilgisayar Ekipmanları
      Category(id: '0_0_4', subCategories: [
        // Monitörler
        Category(id: '0_0_4_0'),
        // Klavyeler
        Category(id: '0_0_4_1'),
        // Mouselar
        Category(id: '0_0_4_2'),
        // Mikrofonlar
        Category(id: '0_0_4_3'),
        // Kulaklıklar
        Category(id: '0_0_4_4', subCategories:[
          // Bluetooth Kulaklıklar
          Category(id: '0_0_4_4_0'),
          // Kulaküstü Kulaklıklar
          Category(id: '0_0_4_4_1'),
          // Kulakiçi Kulaklıklar
          Category(id: '0_0_4_4_2')
        ]),
        // Kameralar
        Category(id: '0_0_4_5'),
        // Direksiyon Setleri
        Category(id: '0_0_4_6')
      ])
    ]),
    // Telefonlar
    Category(id: '0_1', subCategories: [
      // Android Telefonlar
      Category(id: '0_1_0'),
      // iOS Telefonlar
      Category(id: '0_1_1'),
      // Akıllı Saat ve Bileklikler
      Category(id: '0_1_2'),
      // Telefon Aksesuarları
      Category(id: '0_1_3')
    ]),
    // Tabletler
    Category(id: '0_2', subCategories: [
      // Android Tabletler
      Category(id: '0_2_0'),
      // iOS Tabletler
      Category(id: '0_2_1'),
      // Tablet Aksesuarları
      Category(id: '0_2_2')
    ]),
    // Yazıcılar
    Category(id: '0_3', subCategories: [
      // Lazer Yazıcılar
      Category(id: '0_3_0'),
      // Tanklı Yazıcılar
      Category(id: '0_3_1'),
      // Mürekkep Püskürtmeli Yazıcılar
      Category(id: '0_3_2'),
      // Nokta Vuruşlu Yazıcılar
      Category(id: '0_3_3'),
      // Fotoğraf Yazıcıları
      Category(id: '0_3_4'),
      // 3D Yazıcılar
      Category(id: '0_3_5'),
      // Barkod Yazıcıları
      Category(id: '0_3_6'),
      // Tarayıcılar
      Category(id: '0_3_7'),
    ]),
    // Televizyon, Görüntü ve Ses Sistemleri
    Category(id: '0_4', subCategories: [
      // Televizyonlar
      Category(id: '0_4_0'),
      // Ev Sinema Sistemleri
      Category(id: '0_4_1'),
      // Bluetooth Hoparlörler
      Category(id: '0_4_2'),
      // Müzik Sistemleri
      Category(id: '0_4_3'),
      // Projeksiyon Sistemleri
      Category(id: '0_4_4'),
      // Uydu Alıcıları
      Category(id: '0_4_5'),
      // Blu-Ray ve DVD Oynatıcılar
      Category(id: '0_4_6'),
      // Kablo ve Soketler
      Category(id: '0_4_7'),
      // Tv Aksesuarları
      Category(id: '0_4_8'),
      // Güvenlik Sistemleri
      Category(id: '0_4_9'),
      // Media Player
      Category(id: '0_4_10'),
      // Kablosuz Ses ve Görüntü Aktarıcı
      Category(id: '0_4_11'),
    ]),
    // Beyaz Eşyalar
    Category(id: '0_5', subCategories: [
      // Çamaşır Makineleri
      Category(id: '0_5_0'),
      // Buzdolapları
      Category(id: '0_5_1'),
      // Bulaşık Makineleri
      Category(id: '0_5_2'),
      // Kurutma Makineleri
      Category(id: '0_5_3'),
      // Su Sebilleri
      Category(id: '0_5_4'),
      // Derin Dondurucular
      Category(id: '0_5_5'),
      // Ocaklar
      Category(id: '0_5_6'),
      // Fırınlar
      Category(id: '0_5_7'),
      // Mikrodalga Fırınlar
      Category(id: '0_5_8'),
      // Ankastre Setler
      Category(id: '0_5_9'),
      // Davlumbazlar
      Category(id: '0_5_10'),
    ]),
    // Klima ve Isıtıcılar
    Category(id: '0_6', subCategories: [
      // Klimalar
      Category(id: '0_6_0'),
      // Kombiler
      Category(id: '0_6_1'),
      // Şofbenler
      Category(id: '0_6_2'),
      // Termosifonlar
      Category(id: '0_6_3'),
      // Vantilatörler
      Category(id: '0_6_4'),
      // Sobalar ve Isıtıcılar
      Category(id: '0_6_5'),
    ]),
    // Elektrikli Ev Aletleri
    Category(id: '0_7', subCategories: [
      // Ütüler
      Category(id: '0_7_0'),
      // Süpürgeler
      Category(id: '0_7_1'),
      // Saç ve Sakal Makinaları
      Category(id: '0_7_2'),
      // Saç Kurutma ve Şekillendirme Makinaları
      Category(id: '0_7_3'),
      // Epilatörler ve IPL Cihazları
      Category(id: '0_7_4'),
      // İçecek Hazırlama
      Category(id: '0_7_5'),
      // Yiyecek Hazırlama
      Category(id: '0_7_6'),
      // Pişirme
      Category(id: '0_7_7'),
      // Hava Temizleme ve Nem Alma Cihazları
      Category(id: '0_7_8'),
      // Çay ve Kahve Makineleri
      Category(id: '0_7_9'),
    ]),
    // Fotoğraf ve Kameralar
    Category(id: '0_8', subCategories: [
      // SLR Fotoğraf Makineleri
      Category(id: '0_8_0'),
      // Dijital Fotoğraf Makineleri
      Category(id: '0_8_1'),
      // Aksiyon Kamera
      Category(id: '0_8_2'),
      // Outdoor & Sualtı Foto. Mk.
      Category(id: '0_8_3'),
      // Drone
      Category(id: '0_8_4'),
      // Aynasız Kompakt SLR Mk.
      Category(id: '0_8_5'),
      // Video Kameralar
      Category(id: '0_8_6'),
      // Elektronik-Optik (GPS,Dürbün)
      Category(id: '0_8_7'),
      // Aksesuarlar
      Category(id: '0_8_8'),
    ]),
  ]),
  // Moda - Giyim
  Category(id: '1'),
];