# Widget Tree

- İskelet
- Immutable
- Hafif.
- Saniyede 60-120 Kez Çöpe Atılıp Yeniden Üretilir.
- Ekranda Çizim Yapmaz, Sadece Şablon Sunar.

# Element Tree

- Yönetici & Yaşayan Omurga.
- Mutable (Durumu ve Referanslı Hafızada Canlı Tutar, Değişir.
- Widget ile renderobject Arasındaki Koordinartördür (Organizasyonu Sunar).

Flutter, Oyun Sektöründe Çok Yoğun Kullanılıyor.

***

# canUpdate

static bool canUpdate (Widget oldWidget, Widget newWidget) {
return oldwidget.runtineType=newWidget.runtimeType && oldWidget.key==newWidget.key;
}

***

# State Yaşam Döngüsü

Eğer İki Sınıf Birleşik Olsaydı Her Rebuild Esnasında Kullanıcı Girdiler, Sayaçlar, Controller'lar, vb. Sıfırlanırdı.

```dart
1. createState()

2. mounted == true

3. initState()

4. didChangeDependencies() -> Widget Değişimlerinde Tetiklenir. Thema.of (Context) Bu Adımda Güvenli Olarak Çalıştırılır.

5. build(BuildContext context) -> UI Burada Döndürür (İÇİNDE ASLA ASENKRON İŞLEM YAPILMAZ)

6. didUpdateWidget(oldWidget) -> Üst Ebeveyn Yeni Bir Parametre Yolladığında Çalışır.

7. deactivate() -> Ağaçtan Geçici Olarak Kopma

8. dispose() -> Ağacı Kalıcı Olarak Kapatır. controller.dispose Stream.cancel -> Burada Yapılır.

9. mounted == false
```

