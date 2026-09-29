```dart
// Cihazların alabileceği tipleri tanımlar.
enum CihazTipi { sensor, gateway, edgeServer, router }

// IoT ağındaki bir cihazın bilgilerini tutar.
class IoTCihaz {
  final String seriNo;
  final String cihazAdi;
  final CihazTipi tip;
  final double cpuYukYuzdesi;
  final int bellekMb;
  final Set<String> acikPortlar; // Set, aynı portun tekrarını tutmaz.
  final bool sslSertifikasiGecerliMi;
  final bool acikMi; // Cihazın erişilebilir olup olmadığını gösterir.

  // Yeni cihaz oluştururken bütün bilgilerin verilmesini zorunlu kılar.
  IoTCihaz({
    required this.seriNo,
    required this.cihazAdi,
    required this.tip,
    required this.cpuYukYuzdesi,
    required this.bellekMb,
    required this.acikPortlar,
    required this.sslSertifikasiGecerliMi,
    required this.acikMi,
  });

  // SSL geçersizse veya TELNET açıksa güvenlik açığı vardır.
  bool get guvenlikAcigiVarMi =>
      !sslSertifikasiGecerliMi || acikPortlar.contains("23/TELNET");

  // Güvenlik açığı veya %85'in üzerinde CPU kullanımı alarm oluşturur.
  bool get riskliMi => guvenlikAcigiVarMi || cpuYukYuzdesi > 85;

  // Kapalı cihaza erişilmeye çalışılırsa özel hatamızı fırlatır.
  void erisimiKontrolEt() {
    if (!acikMi) {
      throw CihazErisilemezException("$cihazAdi kapalı; cihaza erişilemiyor.");
    }
    print("$cihazAdi cihazına erişildi.");
  }
}

// Cihaza erişilemediğinde kullanılacak özel hata sınıfı.
class CihazErisilemezException implements Exception {
  final String mesaj;

  CihazErisilemezException(this.mesaj);

  @override
  String toString() => mesaj;
}

// Seri numarasından cihazı bulur; üç bilgiyi isimlendirilmiş Record olarak döndürür.
({String cihazAdi, CihazTipi tip, bool alarmDurumu}) cihazBilgisiBul(
  List<IoTCihaz> cihazlar,
  String arananSeriNo,
) {
  for (final cihaz in cihazlar) {
    if (cihaz.seriNo == arananSeriNo) {
      return (
        cihazAdi: cihaz.cihazAdi,
        tip: cihaz.tip,
        alarmDurumu: cihaz.riskliMi,
      );
    }
  }

  // Seri numarası listede yoksa durumu açıkça bildirir.
  throw StateError("$arananSeriNo seri numaralı cihaz bulunamadı.");
}

// Cihaz tipini Dart 3 switch expression ile izolasyon bölgesine dönüştürür.
String izolasyonBolgesi(CihazTipi tip) {
  return switch (tip) {
    CihazTipi.sensor => "ZONE-S",
    CihazTipi.gateway => "ZONE-G",
    CihazTipi.edgeServer => "ZONE-E",
    CihazTipi.router => "ZONE-R",
  };
}

void main() {
  // Farklı özelliklere sahip altı cihazı bir List içinde tutuyoruz.
  final List<IoTCihaz> cihazlar = [
    IoTCihaz(
      seriNo: "SN-001",
      cihazAdi: "Sıcaklık Sensörü",
      tip: CihazTipi.sensor,
      cpuYukYuzdesi: 20,
      bellekMb: 256,
      acikPortlar: {"443/HTTPS"},
      sslSertifikasiGecerliMi: true,
      acikMi: true,
    ),
    IoTCihaz(
      seriNo: "SN-002",
      cihazAdi: "Ana Gateway",
      tip: CihazTipi.gateway,
      cpuYukYuzdesi: 60,
      bellekMb: 512,
      acikPortlar: {"443/HTTPS", "23/TELNET"},
      sslSertifikasiGecerliMi: true,
      acikMi: true,
    ),
    IoTCihaz(
      seriNo: "SN-003",
      cihazAdi: "Edge Sunucu",
      tip: CihazTipi.edgeServer,
      cpuYukYuzdesi: 91,
      bellekMb: 1024,
      acikPortlar: {"443/HTTPS"},
      sslSertifikasiGecerliMi: true,
      acikMi: true,
    ),
    IoTCihaz(
      seriNo: "SN-004",
      cihazAdi: "Ofis Router",
      tip: CihazTipi.router,
      cpuYukYuzdesi: 45,
      bellekMb: 2048,
      acikPortlar: {"22/SSH"},
      sslSertifikasiGecerliMi: false,
      acikMi: true,
    ),
    IoTCihaz(
      seriNo: "SN-005",
      cihazAdi: "Nem Sensörü",
      tip: CihazTipi.sensor,
      cpuYukYuzdesi: 85,
      bellekMb: 128,
      acikPortlar: {"443/HTTPS"},
      sslSertifikasiGecerliMi: true,
      acikMi: true,
    ),
    IoTCihaz(
      seriNo: "SN-006",
      cihazAdi: "Yedek Gateway",
      tip: CihazTipi.gateway,
      cpuYukYuzdesi: 30,
      bellekMb: 512,
      acikPortlar: {"443/HTTPS"},
      sslSertifikasiGecerliMi: true,
      acikMi: false, // Erişim hatasını göstermek için kapalı.
    ),
  ];

  print("Ağdaki cihazlar:");
  for (final cihaz in cihazlar) {
    print("${cihaz.seriNo}: ${cihaz.cihazAdi} (${cihaz.tip.name})");
  }

  // where() koşulu sağlayanları seçer; toList() sonucu listeye çevirir.
  final List<IoTCihaz> riskliCihazlar = cihazlar
      .where((cihaz) => cihaz.riskliMi)
      .toList();

  print("\nRiskli cihazlar:");
  for (final cihaz in riskliCihazlar) {
    print("${cihaz.seriNo}: ${cihaz.cihazAdi}");
  }

  // fold() 0'dan başlayarak her cihazın belleğini toplama ekler.
  final int toplamBellek = cihazlar.fold(
    0,
    (toplam, cihaz) => toplam + cihaz.bellekMb,
  );
  print("\nToplam bellek: $toplamBellek MB");

  // Bulunan cihazın Record içindeki alanlarına isimleriyle erişiyoruz.
  final bilgi = cihazBilgisiBul(cihazlar, "SN-003");
  print(
    "Aranan cihaz: ${bilgi.cihazAdi}, "
    "tip: ${bilgi.tip.name}, alarm: ${bilgi.alarmDurumu}",
  );

  print("\nİzolasyon bölgeleri:");
  for (final cihaz in cihazlar) {
    print("${cihaz.cihazAdi}: ${izolasyonBolgesi(cihaz.tip)}");
  }

  // Kapalı cihaza erişirken fırlatılan özel hatayı yakalıyoruz.
  try {
    cihazlar[5].erisimiKontrolEt();
  } on CihazErisilemezException catch (hata) {
    print("\nErişim hatası: $hata");
  }

  // Olmayan seri numarasının nasıl ele alındığını da gösteriyoruz.
  try {
    cihazBilgisiBul(cihazlar, "SN-999");
  } on StateError catch (hata) {
    print("Arama hatası: ${hata.message}");
  }
}
```