```html
<!doctype html>
<!-- HTML5 Belge Türü Bildirimi -->
<html lang="en">
  <head>
    <!-- Karakter Kümesini UTF-8 (Türkçe Karakterleri Destekler) Olarak Tanımlar. -->
    <meta charset="UTF-8" />

    <!-- Sayfanın Mobil ve Masaüstü Tüm Cihaz Ekranlarına Tam Uyum Sağlamasını (Responsive) Sağlar -->
    <meta
      name="viewport"
      content="width=device-width,
    initial-scale=1.0"
    />

    <!-- Tarayıcı Sekmesinde Görünen Başlık -->
    <title>Sipariş & Gelir Kokpit Dashboard</title>

    <!-- Dahili CSS Kodları -->
    <style>
      /* :Root: Tüm Projede Tekrar Tekrar Kullanılacak Global CSS Değişkenlerini Tanımlar */
      :root {
        --bg: #f8f7f4; /* Genel Sayfa Arka Plan Rengi */
        --card: #ffffff; /* Kart ve Panel Arka Plan Rengi */
        --border: #e6e5df; /* Kenarlık/Çerçeve Rengi */
        --text: #181716; /* Ana Metin Rengi */
        --muted: #6b6963; /* İkincil/Silik Metin Rengi */
        --clay: #c85a32; /* Vurgu ve Butonlar İçin Kiremit Rengi */
        --clay-hover: #b04e29; /* Buton Üzerine Gelindiğindeki Kiremit Tonu */
        --font-main:
          "Plus Jakarta Sans", system-ui, sans-serif; /* Ana Yazı Tipi Ailesi */
        --font-mono:
          "JetBrains Mono", monospace; /* Sayısal ve Kod Alanları İçin Yazı Tipi */
      }

      /* Sayfadaki Tüm Öğeler (*) İçin Temel Sıfırlama (CSS Reset) */
      * {
        box-sizing: border-box; /* Padding ve Border Değerlerini Toplam Genişliğe Dahil Eder */
        margin: 0; /* Tarayıcı Varsayılan Dış Boşluklarını Sıfırlar */
        padding: 0; /* Tarayıcı Varsayılan İç Boşluklarını Sıfırlar */
      }

      /* Sayfanın Gövde (Body) Biçimlendirmesi */
      body {
        background: var(--bg); /* Değişkenden Arka Plan Rengini Uygular */
        color: var(--text); /* Değişkenden Yazı Rengini Uygular */
        font-family: var(--font-main); /* Yazı Tipi Ailesini Belirler */
        padding: 36px 16px; /* Üst/Alt 36px, Sağ/Sol 16px İç Boşluk Verir */
        line-height: 1.5; /* Satır Yüksekliğini Metnin 1.5 Katı Yapar */
      }

      /* Ana Panel Taşıyıcısı */
      .kokpit {
        max-width: 960px; /* Maksimum Genişliği 960px İle Sınırlar */
        margin: 0 auto; /* Paneli Ekranda Yatayda Ortalar */
      }

      /* ==================== ÜST BİLGİ & KPI BÖLÜMÜ ==================== */
      .header {
        margin-bottom: 24px; /* Alt Kısımla Arasına 24px Boşluk Bırakır */
        padding-bottom: 16px; /* Çizginin Üstüne 16px İç Boşluk Verir */
        border-bottom: 1px solid var(--border); /* Alt Kısıma İnce Bir Ayırıcı Çizgi Çeker */
      }

      .header__tag {
        font-size: 11px; /* Küçük Punto Boyutu */
        text-transform: uppercase; /* Metni Tamamen Büyük Harfe Dönüştürür */
        letter-spacing: 0.12em; /* Harfler Arasına Ferah Bir Boşluk Ekler */
        color: var(--clay); /* Kiremit Rengi Uygular */
        font-weight: 700; /* Kalın (Bold) Yazı Tipi */
      }

      .header__title {
        font-size: 26px; /* Başlık Font Boyutu */
        font-weight: 700; /* Kalın Font */
        margin-top: 2px; /* Etiket ile Başlık Arasına Ufak Bir Boşluk */
      }

      /* 3'lü KPI Özet Kartlarının Izgara (Grid) Yapısı */
      .kpi-grid {
        display: grid; /* Grid Düzeni Kullanır */
        grid-template-columns: repeat(
          3,
          1fr
        ); /* Eşit Genişlikte Yan Yana 3 Sütun Oluşturur */
        gap: 14px; /* Kartlar Arasında 14px Boşluk Bırakır */
        margin-bottom: 24px; /* Alttaki Panel ile Arasına Boşluk Koyar */
      }

      .kpi-card {
        background: var(--card); /* Beyaz Kart Arka Planı */
        border: 1px solid var(--border); /* İnce Gri Çerçeve */
        border-radius: 8px; /* Köşeleri 8px Yuvarlatır */
        padding: 14px 18px; /* Kart İçi Ferah Boşluk */
      }

      .kpi-card span {
        font-size: 12px; /* Açıklama Yazısı Boyutu */
        color: var(--muted); /* Soluk Gri Renk */
        font-weight: 600; /* Yarı Kalın Font */
      }

      .kpi-card h3 {
        font-size: 22px; /* Sayısal Değer Font Boyutu */
        font-weight: 700; /* Kalın Yazı */
        font-family: var(
          --font-mono
        ); /* Sayılar İçin Mono (Sabit Genişlikli) Yazı Tipi */
        margin-top: 4px; /* Başlık ile Üst Açıklama Arası Boşluk */
      }

      /* ==================== GENEL DÜZEN (LAYOUT) ==================== */
      .layout {
        display: grid; /* Grid Düzeni Başlatır */
        grid-template-columns: 320px 1fr; /* Solda 320px Form, Sağda Kalan Alanı Kaplayan Liste */
        gap: 24px; /* Sütunlar Arasında 24px Boşluk */
      }

      /* Mobil Uyumluluk: Ekran 768px ve Daha Altına Düştüğünde */
      @media (max-width: 768px) {
        .layout,
        .kpi-grid {
          grid-template-columns: 1fr; /* 3 Sütunlu Veya 2 Sütunlu Yapıları Tek Sütuna Düşürür */
        }
      }

      /* ==================== FORM VE PANELLER ==================== */
      .panel {
        background: var(--card); /* Beyaz Arka Plan */
        border: 1px solid var(--border); /* Çerçeve */
        border-radius: 10px; /* Köşeleri 10px Yuvarlar */
        padding: 20px; /* İç Boşluk */
      }

      .panel h4 {
        font-size: 15px; /* Panel Başlık Boyutu */
        font-weight: 700; /* Kalın Metin */
        margin-bottom: 14px; /* Alt Boşluk */
        padding-bottom: 8px; /* Çizgi Üstü Boşluk */
        border-bottom: 1px solid var(--border); /* Başlığın Altına Ayırıcı Çizgi */
      }

      .field {
        margin-bottom: 12px; /* Her Giriş Alanı Grubunun Altına Boşluk Bırakır */
      }

      .field label {
        display: block; /* Etiketi Alt Satıra Geçirecek Şekilde Blok Element Yapar */
        font-size: 12px; /* Etiket Yazı Boyutu */
        font-weight: 600; /* Yarı Kalın Metin */
        margin-bottom: 4px; /* Etiket ile Input Arasına Boşluk */
      }

      .field input,
      .field select {
        width: 100%; /* Kutunun Tüm Genişliği Kaplamasını Sağlar */
        padding: 8px 10px; /* İçerik Etrafına Boşluk Verir */
        font-size: 13px; /* Yazı Boyutu */
        font-family: inherit; /* Sayfanın Genel Yazı Tipini Miras Alır */
        background: var(--bg); /* Hafif Kırık Beyaz Arka Plan */
        border: 1px solid var(--border); /* Çerçeve */
        border-radius: 6px; /* Köşe Yuvarlama */
      }

      /* Form Alanlarına Tıklandığında (Focus Durumu) */
      .field input:focus,
      .field select:focus {
        outline: none; /* Tarayıcının Varsayılan Mavi Çerçevesini Kaldırır */
        border-color: var(--clay); /* Çerçeveyi Kiremit Rengi Yapar */
        background: #fff; /* Arka Planı Beyaza Çeker */
      }

      /* Form Kaydetme Butonu */
      .btn-submit {
        width: 100%; /* Genişliği Tam Yayar */
        background: var(--clay); /* Kiremit Zemin Rengi */
        color: #fff; /* Beyaz Yazı Rengi */
        border: none; /* Kenarlığı Kaldırır */
        padding: 10px; /* İç Boşluk */
        font-size: 13px; /* Yazı Boyutu */
        font-weight: 600; /* Yarı Kalın Metin */
        border-radius: 6px; /* Köşe Yuvarlama */
        cursor: pointer; /* Üzerine Gelince El (Tıklama) İmleci Gösterir */
        margin-top: 6px; /* Üstten Hafif Boşluk */
      }

      /* Butonun Üzerine Fareyle Gelindiğinde */
      .btn-submit:hover {
        background: var(--clay-hover); /* Rengi Bir Ton Koyulaştırır */
      }

      /* ==================== LİSTE VE FİLTRELEME BÖLÜMÜ ==================== */
      .filter-bar {
        display: flex; /* Arama Kutusu ve Kategoriyi Yan Yana Dizer */
        gap: 10px; /* Aralarına 10px Boşluk Koyar */
        margin-bottom: 14px; /* Altındaki Liste ile Boşluk */
      }

      .order-list {
        display: flex; /* Sipariş Kartlarını Kapsar */
        flex-direction: column; /* Kartları Alt Alta Sıralar */
        gap: 10px; /* Her Kart Arasına 10px Boşluk */
      }

      /* Tekil Sipariş Kartı */
      .order-item {
        background: var(--bg); /* Arka Plan Rengi */
        border: 1px solid var(--border); /* Çerçeve */
        border-radius: 6px; /* Köşe Yuvarlama */
        padding: 12px 14px; /* Kart İçi Boşluk */
        display: flex; /* İçindeki Elemanları Yan Yana Dizer */
        justify-content: space-between; /* Sol Bilgiyi Sola, Sağ Bilgiyi Sağa Yaslar */
        align-items: center; /* Dikeyde Tam Ortalar */
      }

      .order-item h5 {
        font-size: 13px; /* Ürün Adı Font Boyutu */
        font-weight: 600; /* Kalınlık */
      }

      .order-item p {
        font-size: 12px; /* Fiyat Açıklaması Boyutu */
        color: var(--muted); /* Soluk Gri Yazı Rengi */
      }

      .meta-box {
        display: flex; /* Kategori Etiketi ve Sil Butonunu Yan Yana Tutar */
        align-items: center; /* Dikeyde Ortalar */
        gap: 10px; /* Aralarında 10px Mesafe Bırakır */
      }

      /* Kategori Rozeti (Badge) Genel Stili */
      .badge {
        font-size: 11px; /* Küçük Yazı */
        padding: 2px 7px; /* Rozet İçi Boşluk */
        border-radius: 4px; /* Yuvarlatılmış Köşeler */
        font-weight: 600; /* Yarı Kalın Metin */
        background: #fef3c7; /* Varsayılan Sarımsı Arka Plan */
        color: #92400e; /* Varsayılan Kahverengimsi Metin */
        font-family: var(--font-mono); /* Sabit Aralıklı Font */
      }

      /* Kategoriye Özel Renkler */
      .badge--mobilya {
        background: #e0e7ff; /* Açık Mavi/Mor Zemin */
        color: #3730a3; /* Koyu İndigo Metin */
      }

      .badge--aydinlatma {
        background: #fef3c7; /* Açık Sarı Zemin */
        color: #b45309; /* Koyu Amber Metin */
      }

      .badge--seramik {
        background: #d1fae5; /* Açık Yeşil Zemin */
        color: #065f46; /* Koyu Yeşil Metin */
      }

      /* Silme Butonu Stili */
      .btn-del {
        background: transparent; /* Saydam Arka Plan */
        border: 1px solid var(--border); /* İnce Çerçeve */
        color: var(--muted); /* Soluk Gri Buton Metni */
        font-size: 11px; /* Küçük Yazı Boyutu */
        padding: 4px 8px; /* Buton İçi Boşluk */
        border-radius: 4px; /* Köşe Yuvarlama */
        cursor: pointer; /* Tıklama İmleci */
        transition: all 0.2s ease; /* Geçiş Animasyonunu Yumuşatır */
      }

      /* Sil Butonunun Üzerine Gelindiğinde (Hover) */
      .btn-del:hover {
        background: #ef4444; /* Arka Planı Kırmızı Yapar */
        color: #fff; /* Yazıyı Beyaz Yapar */
        border-color: #ef4444; /* Kenarlığı Kırmızı Yapar */
      }
    </style>
  </head>

  <body>
    <!-- Sayfa Ana Kapsayıcısı -->
    <div class="kokpit">
      <!-- Sayfa Başlığı ve Üst Bilgi Bölümü -->
      <header class="header">
        <span class="header__tag">Sipariş Takip</span>
        <h1 class="header__title">Sipariş Yönetim Kokpiti</h1>
      </header>

      <!-- KPI (Temel Performans Göstergesi) Metrik Kartları Bölümü -->
      <section class="kpi-grid">
        <!-- 1. KPI: Toplam Sipariş Adedi -->
        <div class="kpi-card">
          <span>Kayıtlı sipariş</span>
          <h3 id="kpiCount">0</h3>
        </div>
        <!-- 2. KPI: Toplam Sipariş Tutarı -->
        <div class="kpi-card">
          <span>Toplam Sipariş Tutar</span>
          <h3 id="kpiTotal">0 ₺</h3>
        </div>
        <!-- 3. KPI: Ortalama Ürün Fiyatı -->
        <div class="kpi-card">
          <span>Ortalama Ürün Fiyatı</span>
          <h3 id="kpiAvg">0 ₺</h3>
        </div>
      </section>

      <!-- Ana İçerik Bölümü (Form + Liste Yan Yana) -->
      <main class="layout">
        <!-- Sol Panel: Yeni Sipariş Ekleme Formu -->
        <section class="panel">
          <h4>Yeni Sipariş Kaydı</h4>
          <form id="orderForm">
            <!-- Ürün Adı Giriş Alanı -->
            <div class="field">
              <label for="prodName">Ürün Adı</label>
              <input type="text" id="prodName" placeholder="Sehpa" required />
            </div>

            <!-- Kategori Seçim Alanı -->
            <div class="field">
              <label for="prodCat">Kategori</label>
              <select name="prodCat" id="prodCat">
                <option value="Mobilya">Mobilya</option>
                <option value="Aydınlatma">Aydınlatma</option>
                <option value="Mutfak">Mutfak</option>
              </select>
            </div>

            <!-- Fiyat Giriş Alanı -->
            <div class="field">
              <label for="prodPrice">Fiyat</label>
              <input
                type="number"
                id="prodPrice"
                value="3250"
                min="100"
                step="50"
                required
              />
            </div>

            <!-- Form Gönderme Butonu -->
            <button type="submit" class="btn-submit">Siparişi Kaydet</button>
          </form>
        </section>

        <!-- Sağ Panel: Filtreleme ve Sipariş Listesi -->
        <section class="panel">
          <!-- Arama ve Kategori Filtreleme Çubuğu -->
          <div class="filter-bar">
            <!-- İsim ile Arama Kutusu -->
            <input
              type="text"
              id="searchInput"
              class="field"
              style="margin-bottom: 0"
              placeholder="Ürün Adına Göre Filtrele"
            />
            <!-- Kategoriye Göre Filtreleme Kutusu -->
            <select
              id="categoryFilter"
              style="width: 130px; font-size: 12px; padding: 6px"
            >
              <option value="ALL">Tüm Kategoriler</option>
              <option value="Mobilya">Mobilya</option>
              <option value="Aydınlatma">Aydınlatma</option>
              <option value="Mutfak">Mutfak</option>
            </select>
          </div>

          <!-- JS Tarafından Dinamik Olarak Sipariş Kartlarının Basılacağı Kapsayıcı -->
          <div id="orderContainer" class="order-list">
            <!-- Dinamik Olarak Elemanlar Buraya Eklenecek -->
          </div>
        </section>
      </main>
    </div>

    <!-- ==================== JAVASCRIPT KODLARI ==================== -->
    <script>
      // Başlangıç Verisi Olarak Kullanılan Sipariş Dizisi (State / Veri Kaynağı)
      let orders = [
        { id: 1, name: "Sehpa", category: "Mobilya", price: 6500 },
        { id: 2, name: "Abajür", category: "Aydınlatma", price: 7500 },
        { id: 3, name: "Koltuk", category: "Mobilya", price: 8500 },
        { id: 4, name: "Bulaşık Makinası", category: "Mutfak", price: 10000 },
        { id: 5, name: "Ocak", category: "Mutfak", price: 15000 },
      ];

      // ==================== DOM ELEMENTLERİNİN YAKALANMASI ====================
      // Sipariş Kartlarının Listeleneceği Div Konteyneri
      const orderContainer = document.getElementById("orderContainer");
      // Yeni Sipariş Ekleme Formu
      const orderForm = document.getElementById("orderForm");
      // İsimle Arama Yapılan Input Alanı
      const searchInput = document.getElementById("searchInput");
      // Kategori Filtreleme Açılır Kutusu (Select)
      const categoryFilter = document.getElementById("categoryFilter");
      // KPI Kartları Metin Alanları
      const kpiCount = document.getElementById("kpiCount");
      const kpiTotal = document.getElementById("kpiTotal");
      const kpiAvg = document.getElementById("kpiAvg");

      // ==================== FORM INPUT ALANLARI ====================
      const prodNameInput = document.getElementById("prodName"); // Ürün Adı Inputu
      const prodCatInput = document.getElementById("prodCat"); // Kategori Selecti
      const prodPriceInput = document.getElementById("prodPrice"); // Fiyat Inputu

      /**
       * KPI Göstergelerini Güncelleyen Fonksiyon
       * @param {Array} dataList - Hesaplanacak Güncel Sipariş Dizisi
       */
      const updateKPIs = (dataList) => {
        // Kayıtlı Sipariş Adedini Güncelle
        kpiCount.textContent = dataList.length;

        // Eğer Listede Hiç Ürün Kalmadıysa Değerleri Sıfırla ve Fonksiyondan Çık
        if (dataList.length === 0) {
          kpiTotal.textContent = "0 ₺";
          kpiAvg.textContent = "0 ₺";
          return;
        }

        // Toplam Tutarı Hesaplar (Reduce Kullanarak Tüm Fiyatları Toplar)
        const total = dataList.reduce((acc, curr) => acc + curr.price, 0);
        // Sayıyı Türkiye Para Formatına (Örn: 10.000 ₺) Dönüştürerek Ekrana Yazar
        kpiTotal.textContent = `${total.toLocaleString("tr-TR")} ₺`;

        // Ortalama Fiyatı Hesaplar (Toplam Tutar / Eleman Sayısı)
        const avg = total / dataList.length;
        // Ortalamayı En Yakın Tam Sayıya Yuvarlar ve Ekrana Yazar
        kpiAvg.textContent = `${Math.round(avg).toLocaleString("tr-TR")} ₺`;
      };

      /**
       * Siparişleri Filtreleyen ve Ekrana Basan (Render Eden) Ana Fonksiyon
       */
      const renderOrders = () => {
        // Arama Terimini Alır, Küçük Harfe Çevirir ve Başındaki/Sonundaki Boşlukları Siler
        const term = searchInput.value.toLowerCase().trim();
        // Seçilen Kategoriyi Alır (ALL, Mobilya, Aydınlatma Vb.)
        const selectedCat = categoryFilter.value;

        // Siparişler Dizisini Belirlenen Arama Kriterlerine Göre Filtreler
        const filtered = orders.filter((order) => {
          // Ürün Adı Arama Terimini İçeriyor Mu Kontrolü
          const matchesName = order.name.toLowerCase().includes(term);
          // Tüm Kategoriler Mi Seçili Yoksa Siparişin Kategorisiyle Eşleşiyor Mu Kontrolü
          const matchesCategory =
            selectedCat === "ALL" || order.category === selectedCat;
          // Her İki Şartı Da Sağlayan Siparişleri Döndürür
          return matchesName && matchesCategory;
        });

        // Konteynerin İçerisindeki Önceki HTML İçeriğini Temizler
        orderContainer.innerHTML = "";

        // Eğer Arama Sonucu Eşleşen Hiçbir Kayıt Bulunamazsa
        if (filtered.length === 0) {
          // Kullanıcıya Bilgi Mesajı Basar
          orderContainer.innerHTML = `
            <div style="padding:24px; text-align:center; color:var(--muted); font-size:12px">
              Kriterlere Uygun Ürün Bulunamadı
            </div>
          `;
          // KPI Göstergelerini De Boş Dizi Göndererek Sıfırlar
          updateKPIs([]);
          return; // Fonksiyonun Devam Etmesini Engeller
        }

        // Filtrelenmiş Her Bir Sipariş İçin Döngü Başlatarak HTML Elemanlarını Oluşturur
        filtered.forEach((order) => {
          // Yeni Bir <Article> Etiketi Oluşturur
          const item = document.createElement("article");
          // Sınıf Adını Atar
          item.className = "order-item";
          // Hangi Sipariş Olduğunu Ayırt Etmek İçin Data-Id Attribute'u Ekler
          item.setAttribute("data-id", order.id);

          // Kategoriye Göre İlgili Rozet (Badge) CSS Sınıfını Belirler
          const badgeClass =
            order.category === "Mobilya"
              ? "badge--mobilya"
              : order.category === "Aydınlatma"
                ? "badge--aydinlatma"
                : "badge--seramik";

          // Kartın İç HTML Yapısını Şablon Literali (Template Literal) ile Doldurur
          item.innerHTML = `
            <div>
              <h5>${order.name}</h5>
              <p>Birim Fiyat: ${order.price.toLocaleString("tr-TR")} ₺</p>
            </div>
            <div class="meta-box">
              <span class="badge ${badgeClass}">${order.category}</span>
              <button class="btn-del" data-action="delete">Sil</button>
            </div>
          `;
          // Oluşturulan Kartı Sipariş Listesi Konteynerine Bir Çocuk Eleman Olarak Ekler
          orderContainer.appendChild(item);
        });

        // Filtrelenmiş Güncel Liste ile KPI Kartlarını Yeniler
        updateKPIs(filtered);
      };

      // ==================== OLAY DİNLEYİCİLERİ (EVENT LISTENERS) ====================

      // 1. Yeni Sipariş Ekleme Olayı
      orderForm.addEventListener("submit", (e) => {
        // Form Gönderildiğinde Sayfanın Yeniden Yüklenmesini (Refresh) Engeller
        e.preventDefault();

        // Form Alanlarındaki Değerleri Alır
        const name = prodNameInput.value.trim();
        const category = prodCatInput.value;
        const price = Number(prodPriceInput.value); // Metin Değerini Sayıya Dönüştürür

        // İsim Boşsa Veya Fiyat Geçerli Bir Sayı Değilse İşlemi Durdurur
        if (!name || isNaN(price)) return;

        // Yeni Sipariş Nesnesini Oluşturur (Date.now() O Anki Milisaniyeyi Vererek Benzersiz ID Üretir)
        const newOrder = {
          id: Date.now(),
          name: name,
          category: category,
          price: price,
        };

        // Yeni Siparişi Dizinin En Başına Ekler (Unshift Metodu)
        orders.unshift(newOrder);

        // Formdaki Input Alanlarını Sıfırlar
        orderForm.reset();
        // Varsayılan Fiyat Değerini Tekrar 3250 Olarak Ayarlar
        prodPriceInput.value = "3250";

        // Ekrandaki Listeyi ve Metrikleri Günceller
        renderOrders();
      });

      // 2. Sipariş Silme Olayı (Event Delegation Yöntemi Kullanılmıştır)
      orderContainer.addEventListener("click", (e) => {
        // Tıklanan Elemanın Data-Action Özelliği "Delete" Mi Kontrol Eder (Sil Butonu Mu?)
        if (e.target.dataset.action === "delete") {
          // Tıklanan Sil Butonunun Ait Olduğu Ana Kart Elementini (.Order-Item) Bulur
          const itemElement = e.target.closest(".order-item");
          // Kart Üzerindeki Data-Id Değerini Alıp Sayıya Çevirir
          const orderId = Number(itemElement.getAttribute("data-id"));

          // İlgili Siparişi Orders Dizisinden Çıkarır (İd'si Eşleşmeyenleri Tutar)
          orders = orders.filter((order) => order.id !== orderId);

          // Ekranı Yeni Liste Durumuna Göre Tekrar Çizer
          renderOrders();
        }
      });

      // 3. Arama Kutusuna Her Harf Yazıldığında Listeyi Anlık Olarak Filtreler
      searchInput.addEventListener("input", renderOrders);

      // 4. Kategori Kutusundan Yeni Bir Kategori Seçildiğinde Listeyi Filtreler
      categoryFilter.addEventListener("change", renderOrders);

      // Sayfa İlk Defa Açıldığında Başlangıç Verilerini Ekrana Basar
      renderOrders();
    </script>
  </body>
</html>
```