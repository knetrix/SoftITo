```dart
/*

JS'deki gibi `let x = "ahmet"; x = 42;` serbestliği yoktur; Dart tip güvenli (type-safe) bir dildir.
print("İlk dersimiz - Dart SDK aktif olmalı");


1. AÇIK BELİRTİLEN VERİ TİPLERİ (Explicit Types)
--------------------------------------------------------------------------------
int seansSuresiDakika = 45;
double seansUcretiTl = 2750.50;
String uzmanAdi = "Dr Aygen Yıldırım";
bool aktifMi = true;


2. STRING INTERPOLATION
--------------------------------------------------------------------------------
JS'deki `${}` yerine:
- Sadece değişken varsa   : $degisken
- İşlem/ifade varsa       : ${degisken * 2}

Örnekler:
print("Uzman: $uzmanAdi | Süre: $seansSuresiDakika dk | Ücret: $seansUcretiTl ₺");
print("KDV dahil (%20): ${seansUcretiTl * 1.20} ₺");


3. 'var' İLE TİP ÇIKARIMI (Type Inference)
--------------------------------------------------------------------------------
var tedaviAdi = "Kahve ile Peeling"; // Dart tipi String olarak sabitler
// tedaviAdi = 99;                   // Hata verir, tip sonradan değişemez.


4. 'dynamic' VERİ TİPİ
--------------------------------------------------------------------------------
Bağımsız olarak kullanabilirsiniz ancak Flutter'da önerilmez.
dynamic serbestKutu = "Lazer Epilasyon";
serbestKutu = 1000; // İzin verilir ama tip güvenliğini yok eder.


5. 'const' VE 'final' FARKI
--------------------------------------------------------------------------------
const: Derleme anında (compile-time) değeri belli olan verilerdir. Bellekte tek yerde tutulur.
const String KLINIK_ADI = "Softİto Güzellik Merkezi";
const double KDV_ORANI = 0.20;
// const DateTime suankiZaman = DateTime.now(); // HATA! Derleme anında bu değer bilinemez.

final: Çalışma anında (runtime) hesaplanır, bir kere atandıktan sonra değiştirilemez.
final DateTime randevuZamani = DateTime.now();
final String takipKodu = "SOFT-" + randevuZamani.microsecondsSinceEpoch.toString();

print("Klinik adı: $KLINIK_ADI");
print("Oluşturulma tarihi: $randevuZamani | Kod: $takipKodu");


6. NULL SAFETY (Boş Değer Güvenliği)
--------------------------------------------------------------------------------
Dart'ta değişkenler varsayılan olarak null olamaz. Null safety operatörleri kullanılır: (?, ??, !)

String zorunluDanisanAdi = "Meltem Demir";
String? danisanAlerjiNotu; // '?' ile null değer alabilir hale gelir
print("alerji notu: $danisanAlerjiNotu");

// '??' ifNull operatörü: Değer null ise sağdaki varsayılan değeri kullanır
String goruntulenecekNot = danisanAlerjiNotu ?? "Bilinen bir alerjisi yok";
print("Rapor: $goruntulenecekNot");

// '?.' null-aware operatörü: null değilse devam et
print("alerji metin uzunluğu: ${danisanAlerjiNotu?.length}");


7. FONKSİYONLAR
--------------------------------------------------------------------------------
- Klasik sıralı fonksiyon (Arrow Syntax):
  double topla(double a, double b) => a + b;

- Modern Dart / Flutter standartları (Named Parameters - {}):
  Parametreler süslü parantez içine alınarak isimlendirilir.
================================================================================
*/


// Named parameters ({}) kullanılarak tanımlanan seans kayıt fonksiyonu
void seansKaydiOlustur({
  required String danisan,
  required String tedavi,
  required double birimFiyat,
  int seansSayisi = 1,        // Varsayılan değer (default)
  double indirimOrani = 0.0,  // Varsayılan değer (default)
  String? uzmanHekim,         // Null olabilir (opsiyonel)
}) {
  final double brutTutar = birimFiyat * seansSayisi;
  final double indirimTutari = brutTutar * (indirimOrani / 100);
  final double netTutar = brutTutar - indirimTutari;

  print("""
==================================================

Softİto Seans Sözleşmesi

--------------------------------------------------

Danışan         :   $danisan
Tedavi          :   $tedavi (x$seansSayisi Seans)
Uzman Hekim     :   ${uzmanHekim ?? "Nöbetçi Estetisyen"}
Brüt Tutar      :   $brutTutar ₺
İndirim         :   -$indirimTutari ₺ ($indirimOrani)
Ödenecek Tutar  :   $netTutar ₺

==================================================
""");
}

void main() {
  seansKaydiOlustur(
    danisan: "Sümeyye Muhammed",
    tedavi: "Medikal Cilt Yenileme",
    birimFiyat: 4500.0,
    seansSayisi: 3,
    indirimOrani: 15.0,
    uzmanHekim: "Dr. Shahd",
  );
}
```