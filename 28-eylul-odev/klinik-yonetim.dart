// Hizmet Türlerini Sabit ve Güvenli Biçimde Tanımlar.
enum HizmetKategorisi { ciltYenileme, medikalEstetik, lazerEpilasyon, lipo }

// Bir Seansın İşlem Sürecindeki Durumlarını Tanımlar.
enum SeansDurumu { bekliyor, odadaIslemde, tamamlandi, iptalEdildi }

// Klinik Tarafından Kabul Edilen Ödeme Yöntemlerini Tanımlar.
enum OdemeYontemi { kredikarti, havaleEft, nakit, klinikPaketKredisi }

// Danışana Ait Temel İletişim ve Sağlık Bilgilerini Temsil Eder.
class Danisan {
  // Danışanın Sistemdeki Benzersiz Kimliği.
  final String id;
  // Danışanın Ad ve Soyadı.
  final String adSoyad;
  // Danışanın İletişim Telefonu.
  final String telefon;
  // Danışanın VİP Üyeliği Olup Olmadığını Belirtir.
  final bool vipUyeMi;
  // Danışanın Alerji Listesini Tutar.
  final List<String> alerjiler;
  // Varsa Danışana Ait Özel Cilt veya Medikal Nottur.
  final String? ozelCiltNotu;

  // Yeni Bir Danışan Nesnesi Oluşturur.
  const Danisan({
    required this.id, // Kimlik Bilgisi Zorunludur.
    required this.adSoyad, // Ad Soyad Bilgisi Zorunludur.
    required this.telefon, // Telefon Bilgisi Zorunludur.
    this.vipUyeMi = false, // Varsayılan Olarak Standart Üyedir.
    this.alerjiler = const [], // Varsayılan Olarak Alerji Kaydı Yoktur.
    this.ozelCiltNotu, // Özel Not İsteğe Bağlıdır.
  });

  // Alerji Listesinde Kayıt Varsa Cildin Hassas Olduğu Kabul Edilir.
  bool get hassasCiltMi => alerjiler.isNotEmpty;

  // Danışanın Ekranda veya Raporda Kullanılabilecek Özet Metnini Üretir.
  String get bilgiOzeti {
    // Alerji Yoksa Uygun Varsayılan Metni, Varsa Alerjileri Birleştirir.
    final String alerjiBilgisi = alerjiler.isEmpty
        ? "Kayıtlı alerji yok"
        : "Alerjiler: ${alerjiler.join(', ')}";
    // Özel Not Yoksa Açıklayıcı Varsayılan Değer Kullanır.
    final String notBilgisi = ozelCiltNotu ?? "Özel medikal not girilmemiş";
    // Üyelik Tipine Göre Rozet Metnini Belirler.
    final String vipRozeti = vipUyeMi ? "VİP" : "Standart";
    // Tüm Danışan Bilgilerini Tek Bir Metinde Döndürür.
    return "$vipRozeti $adSoyad ($telefon) | $alerjiBilgisi | Not: $notBilgisi";
  }
}

// Bir Danışanın Aldığı Randevu veya Hizmet Seansını Temsil Eder.
class SeansKaydi {
  // Seansın Benzersiz Takip Kodu.
  final String seansKodu;
  // Seansın Sahibi Olan Danışan.
  final Danisan danisan;
  // Hizmetin Ait Olduğu Kategori.
  final HizmetKategorisi kategori;
  // Yapılacak İşlemin Görünen Adı.
  final String islemAdi;
  // Tek Seans İçin Belirlenen Fiyat.
  final double birimFiyat;
  // Paket İçindeki Toplam Seans Sayısı.
  final int seansSayisi;
  // VIP İndiriminden Bağımsız, Yüzde Cinsinden İndirim Oranı.
  final double indirimOrani;
  // Seansla İlgilenen Uzman; Henüz Atanmamışsa null Olur.
  final String? sorumluUzman;
  // Seansın Güncel Durumu; Süreç İçinde Değiştirilebilir.
  SeansDurumu durum;
  // Seans Tamamlandığında Kullanılan Ödeme Tipi.
  OdemeYontemi? odemeTipi;

  // Seans Kaydı Oluşturur.
  SeansKaydi({
    required this.seansKodu,
    required this.danisan,
    required this.kategori,
    required this.islemAdi,
    required this.birimFiyat,
    this.seansSayisi = 1, // Varsayılan Tek Seanstır.
    this.indirimOrani = 0.0, // Varsayılan Ek İndirim Yoktur.
    this.sorumluUzman,
    this.durum =
        SeansDurumu.bekliyor, // Yeni Seanslar Bekliyor Durumunda Başlar.
    this.odemeTipi,
  });

  // İndirim Uygulanmadan Önceki Toplam Tutarı Hesaplar.
  double get brutTutar => birimFiyat * seansSayisi;

  // Ek İndirim ve VİP İndirimini Kullanarak İndirim Tutarını Hesaplar.
  double get indirimTutari {
    // Hesaplama Kayıt Üzerindeki İndirim Oranıyla Başlar.
    double toplamOran = indirimOrani;
    // VİP Danışanlara Yüzde 10 İlave İndirim Uygular.
    if (danisan.vipUyeMi) {
      toplamOran += 10.0;
    }
    // Brüt Tutarın İndirim Oranına Karşılık Gelen Kısmını Döndürür.
    return brutTutar * (toplamOran / 100.0);
  }

  // Brüt Tutardan İndirimi Çıkararak Tahsil Edilecek Net Tutarı Hesaplar.
  double get netTutar => brutTutar - indirimTutari;
}

// Danışan ve Seans Kayıtlarının Yönetildiği Ana Servis Sınıfıdır.
class KlinikYoneticisi {
  // Bu Yöneticinin Sorumlu Olduğu Şubenin Adı.
  final String subeAdi;
  // Şubedeki Tüm Seans Kayıtlarını Saklayan Özel Liste.
  final List<SeansKaydi> _seanslar = [];
  // Danışanları Kimlikleriyle Hızlı Bulmak İçin Kullanılan Özel Rehber.
  final Map<String, Danisan> _danisanRehberi = {};

  // Belirtilen Şube İçin Yönetici Oluşturur.
  KlinikYoneticisi({required this.subeAdi});

  // Danışanı Rehbere Ekler; Aynı Kimlik Varsa Mevcut Kaydı Günceller.
  void danisanKaydet(Danisan danisan) {
    _danisanRehberi[danisan.id] = danisan;
    // Kullanıcıya Kayıt İşleminin Sonucunu Bildirir.
    print(
      "Rehbere eklendi: ${danisan.adSoyad} (${danisan.vipUyeMi ? "VİP" : "Standart"})",
    );
  }

  // Yeni Bir Seansı Sisteme Ekler.
  void randevuOlustur(SeansKaydi seans) {
    _seanslar.add(seans);
    // Kaydedilen Seansın Temel Bilgisini Ekrana Yazar.
    print(
      "Randevu kaydedildi [${seans.seansKodu}]: ${seans.danisan.adSoyad} -> ${seans.islemAdi}",
    );
  }

  // Seansı Tamamlanmış Olarak İşaretler ve Ödeme Yöntemini Kaydeder.
  void seansiTamamla({required String seansKodu, required OdemeYontemi odeme}) {
    // Koda Ait Seansı Bulmak İçin Tüm Seansları Dolaşır.
    for (final seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        // Bulunan Seansın Durumunu ve Ödeme Bilgisini Günceller.
        seans.durum = SeansDurumu.tamamlandi;
        seans.odemeTipi = odeme;
        // Net Tahsilat Bilgisini Ekrana Yazar.
        print(
          "Seans tamamlandı [${seans.seansKodu}]: ${seans.netTutar.toStringAsFixed(2)} tahsil edildi (${odeme.name})",
        );
        return; // İşlem Tamamlandığı İçin Metottan Çıkar.
      }
    }
    // Döngü Tamamlandıysa Verilen Kodla Seans Bulunamamıştır.
    print("Hata: [$seansKodu] kodlu seans bulunamadı");
  }

  // Seansı İptal Edilmiş Olarak İşaretler; İsteğe Bağlı İptal Nedenini Kaydeder.
  void seansiIptalEt(String seansKodu, {String? iptalNedeni}) {
    // Koda Ait Seansı Bulmak İçin Tüm Seansları Dolaşır.
    for (final seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        // Bulunan Seansın Durumunu İptal Edildi Yapar.
        seans.durum = SeansDurumu.iptalEdildi;
        // İptal Nedeni Varsa Onu, Yoksa Varsayılan Metni Gösterir.
        print(
          "Seans iptal edildi [${seans.seansKodu}]: ${iptalNedeni ?? "Gerekçe belirtilmedi"}",
        );
        return; // İşlem Tamamlandığı İçin Metottan Çıkar.
      }
    }
    // Döngü Tamamlandıysa Verilen Kodla Seans Bulunamamıştır.
    print("Hata: [$seansKodu] kodlu seans bulunamadı");
  }

  // Yalnızca Tamamlanan Seansların Net Tutarlarını Toplayarak Ciroyu Hesaplar.
  double get toplamTahsilEdilenCiro => _seanslar
      .where((s) => s.durum == SeansDurumu.tamamlandi)
      .fold(0.0, (toplam, s) => toplam + s.netTutar);

  // Bekleyen veya İşlemdeki Seanslardan Alınması Beklenen Toplamı Hesaplar.
  double get beklenenPotansiyelCiro => _seanslar
      .where(
        (s) =>
            s.durum == SeansDurumu.bekliyor ||
            s.durum == SeansDurumu.odadaIslemde,
      )
      .fold(0.0, (toplam, s) => toplam + s.netTutar);

  // Her Hizmet Kategorisindeki Seans Sayısını Döndürür.
  Map<HizmetKategorisi, int> kategoriBazliSeansDagilimi() {
    // Sonuç Haritasını Oluşturur.
    final Map<HizmetKategorisi, int> dagilim = {};
    // Rapor İçinde Görünmesi İçin Tüm Kategorileri Sıfırdan Başlatır.
    for (final kategori in HizmetKategorisi.values) {
      dagilim[kategori] = 0;
    }
    // Her Seansın Kategorisine Karşılık Gelen Sayacı Bir Artırır.
    for (final seans in _seanslar) {
      dagilim[seans.kategori] = (dagilim[seans.kategori] ?? 0) + 1;
    }
    return dagilim;
  }

  // Atanmış Uzman İsimlerini Tekrar Etmeyecek Şekilde Döndürür.
  Set<String> gorevliUzmanKadrosu() {
    return _seanslar
        .map((seans) => seans.sorumluUzman) // Uzman Adlarını Alır.
        .whereType<String>() // null Uzman Kayıtlarını Ayıklar.
        .toSet(); // Tekrarlanan Adları Kaldırır.
  }

  // Sorumlu Uzmanı Henüz Atanmamış Seansları Listeler.
  List<SeansKaydi> uzmansizSeanslariGetir() {
    return _seanslar.where((seans) => seans.sorumluUzman == null).toList();
  }

  // Gün Sonu Operasyon ve Finans Raporunu Konsola Yazdırır.
  void gunSonuRaporuYazdir() {
    // Rapor Başlığını ve Tablo Ayırıcısını Yazdırır.
    print("Günlük Seans ve İşlem Çizelgesi");
    print("--------------------------------------------------");
    // Tablo Sütun Başlıklarını Sabit Genişlikte Oluşturur.
    print(
      "${'Kod'.padRight(10)} | "
      "${'Danışan'.padRight(16)} | "
      "${'İşlem'.padRight(20)} | "
      "${'Uzman'.padRight(18)} | "
      "${'Tutar'.padRight(10)} | "
      "${'Durum'}",
    );
    print("--------------------------------------------------");

    // Her Seansı Rapor Tablosunda Ayrı Bir Satır Olarak Gösterir.
    for (final s in _seanslar) {
      // Uzman Yoksa Geçici Açıklama Metni Kullanır.
      final uzman = s.sorumluUzman ?? "Nöbetçi Bekliyor";
      // Enum Durumunu Kullanıcı Dostu Bir Metne Dönüştürür.
      final durumRozet = switch (s.durum) {
        SeansDurumu.tamamlandi => "Tamamlandı",
        SeansDurumu.odadaIslemde => "İşlemde",
        SeansDurumu.bekliyor => "Bekliyor",
        SeansDurumu.iptalEdildi => "İptal",
      };

      // Seans Verilerini Sabit Sütun Genişlikleriyle Ekrana Yazar.
      print(
        "${s.seansKodu.padRight(10)} | "
        "${s.danisan.adSoyad.padRight(16)} | "
        "${s.islemAdi.padRight(20)} | "
        "${uzman.padRight(18)} | "
        "${s.netTutar.toStringAsFixed(2).padRight(10)} | "
        "$durumRozet",
      );
    }

    // Finansal Özet Bölümünü Yazdırır.
    print("--------------------------------------------------");
    print("Finansal Özet:");
    print(
      " * Gerçekleşen (kasadaki net ciro): "
      "${toplamTahsilEdilenCiro.toStringAsFixed(2)}",
    );
    print(
      " * Bekleyen Potansiyel Alacak: "
      "${beklenenPotansiyelCiro.toStringAsFixed(2)}",
    );
    print(" * Toplam Seans: ${_seanslar.length} Randevu");
    print("--------------------------------------------------");
    print("Aktif Uzmanlar");

    // Uzman Kadrosunu Hazırlar ve Ekrana Yazdırır.
    final uzmanlar = gorevliUzmanKadrosu();
    if (uzmanlar.isEmpty) {
      print("Kayıtlı Uzman Bulunamadı");
    } else {
      print(" ${uzmanlar.join(', ')}");
    }

    // Atanmamış Uzmanı Olan Seanslar İçin Uyarı Listesi Oluşturur.
    final uzmansizlar = uzmansizSeanslariGetir();
    if (uzmansizlar.isNotEmpty) {
      print(
        "Dikkat: ${uzmansizlar.length} adet seansa henüz uzman atanmamıştır",
      );
      // Her Uzmansız Seansın Kodunu ve Danışanını Listeler.
      for (final u in uzmansizlar) {
        print("->[${u.seansKodu}] ${u.danisan.adSoyad} (${u.islemAdi})");
      }
    }
    print("--------------------------------------------------");
  }
}

// Uygulamanın Başlangıç Noktasıdır; Örnek Klinik Verisiyle Akışı Gösterir.
void main() {
  print("Klinik yönetim sistemi başlatılıyor....");
  // Bağcılar Şubesi İçin Klinik Yöneticisi Oluşturur.
  final yonetici = KlinikYoneticisi(subeAdi: "Softito Bağcılar Şubesi");

  // Farklı Üyelik ve Alerji Bilgileriyle Danışan Örnekleri Oluşturur.
  final d1 = Danisan(
    id: "DAN-101",
    adSoyad: "Ahmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: ["Retinol,Aspirin"],
    ozelCiltNotu: "Cilt bariyeri hassas",
  );

  final d2 = Danisan(
    id: "DAN-102",
    adSoyad: "Ahmet Yılan",
    telefon: "0555 555 55 55",
    vipUyeMi: false,
    alerjiler: [],
  );

  final d3 = Danisan(
    id: "DAN-103",
    adSoyad: "Mehmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: ["Retinol,Aspirin"],
  );

  final d4 = Danisan(
    id: "DAN-104",
    adSoyad: "Ahmet Mehmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: [],
    ozelCiltNotu: "Cilt bariyeri hassas",
  );

  // Oluşturulan Danışanları Klinik Rehberine Kaydeder.
  yonetici.danisanKaydet(d1);
  yonetici.danisanKaydet(d2);
  yonetici.danisanKaydet(d3);
  yonetici.danisanKaydet(d4);

  // İlk İki Danışanın Özet Bilgisini Örnek Olarak Gösterir.
  print("Danışan güvenlik kontrolü");
  print(d1.bilgiOzeti);
  print(d2.bilgiOzeti);
  print("--------------------------------------------------");

  // Her Danışan İçin Hizmet, Fiyat, İndirim ve Uzman Bilgileriyle Seanslar Oluşturur.
  final seans1 = SeansKaydi(
    seansKodu: "SNS-2026-1",
    danisan: d1,
    kategori: HizmetKategorisi.lipo,
    islemAdi: "Lipo gerisini bilmiyorum",
    birimFiyat: 6500.0,
    seansSayisi: 2,
    indirimOrani: 5.0,
    sorumluUzman: "Sümeyye Arab",
  );

  final seans2 = SeansKaydi(
    seansKodu: "SNS-2026-2",
    danisan: d2,
    kategori: HizmetKategorisi.ciltYenileme,
    islemAdi: "Siverex ile tyüz temizleme",
    birimFiyat: 2500.0,
    seansSayisi: 5,
    indirimOrani: 15.0,
    sorumluUzman: null, // Bu Seansa Henüz Uzman Atanmamıştır.
  );

  final seans3 = SeansKaydi(
    seansKodu: "SNS-2026-3",
    danisan: d3,
    kategori: HizmetKategorisi.lazerEpilasyon,
    islemAdi: "Tüm Vücut",
    birimFiyat: 25000.0,
    seansSayisi: 15,
    indirimOrani: 0.0,
    sorumluUzman: "Tuba Aydın",
  );

  final seans4 = SeansKaydi(
    seansKodu: "SNS-2026-4",
    danisan: d4,
    kategori: HizmetKategorisi.medikalEstetik,
    islemAdi: "Burun Estetiği",
    birimFiyat: 1500.0,
    seansSayisi: 3,
    sorumluUzman: "Alaaddin Odabaşı",
  );

  // Oluşturulan Seansları Yöneticiye Kaydeder.
  yonetici.randevuOlustur(seans1);
  yonetici.randevuOlustur(seans2);
  yonetici.randevuOlustur(seans3);
  yonetici.randevuOlustur(seans4);
  print("Seanslar Gönderiliyor");

  // İlk Seansı Kredi Kartı Ödemesiyle Tamamlar.
  yonetici.seansiTamamla(
    seansKodu: "SNS-2026-1",
    odeme: OdemeYontemi.kredikarti,
  );

  // İkinci Seansı Nakit Ödemeyle Tamamlar.
  yonetici.seansiTamamla(seansKodu: "SNS-2026-2", odeme: OdemeYontemi.nakit);

  // Dördüncü Seansı Belirtilen Gerekçeyle İptal Eder.
  yonetici.seansiIptalEt(
    "SNS-2026-4",
    iptalNedeni: "Danışanın şehir dışından tanıdığı geldiği için gelemedi",
  );

  // Tüm Seans ve Finans Bilgilerini İçeren Gün Sonu Raporunu Yazdırır.
  yonetici.gunSonuRaporuYazdir();
}
